codeunit 58097 "Process Purchase API"
{
    //BC Upgrade VAMSIU01 >>
    // # Old Nav ID - 50178
    // # Removed Dotnet Variables and Add replacement Datatypes.
    // # Created new procedures for GetNodeByXPath and commented the old Procedure GetNodeByXPath.
    //BC Upgrade VAMSIU01 <<

    // version HEI.26

    // HEI.01 FDD-HB2174 - CHG2104952 IBM NANDIS01 01.06.2021 # Raw & Pack interface HL-Ibecor
    //   # New Codeunit created for Purchase process
    // HEI.02 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # dateArrivalInPortOfDestination tag added as change rcvd on 17th Dec
    //   # Code added to take the THOUSAND price from Blanket Order
    // HEI.03 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # Rectified tempshpment part which contans the value of tag - shpment
    //   # Code added for block line filtering and UOM of PO
    // HEI.04 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # Unblock tempshipment as it will be used in collecting Shipment No. value
    // HEI.05 CHG2168025 IBM NANDIS01 31.07.2022 #IBECOR HeiLite PQ-Call-off integration Retrofit for Rwanda
    //   # Consider G/L while checking validity of a PFI received from Ibecor
    // HEI.06 CHG2168025 IBM NANDIS01 10.08.2022 #IBECOR HeiLite PQ-Call-off integration Retrofit for Rwanda
    //   # Delete lines from PFI under action code -02 if PFI Line No. is different
    //   # Price of BO appear on PFI adding filter on Start Date and End Date
    // HEI.07 CHG2168025 IBM NANDIS01 24.08.2022 #IBECOR HeiLite PQ-Call-off integration Retrofit for Rwanda
    //   # Under action code - 02 all lines in PFI should be deleted first and then create
    // HEI.08 CHG2168025 IBM NANDIS01 02.09.2022 #IBECOR HeiLite PQ-Call-off integration Retrofit for Rwanda
    //   # Price of the contract should be validated with respect to currency
    // HEI.09 CHG2168025 IBM NANDIS01 16.09.2022 #IBECOR HeiLite PQ-Call-off integration Retrofit for Rwanda
    //   # Price fix for contract validity checks and modified price validity error message
    // HEI.10 CHG2156104 IBM NANDIS01 26.10.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # Removal of cntract level validation at time of creating PFIs from Ibecor
    // HEI.11 CHG2156104 IBM NANDIS01 03.11.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # Keeping contract level validation at time of CMG validation
    // HEI.12 CHG2156104 IBM NANDIS01 25.11.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # Currency validation on CMG
    // HEI.13 CHG2156104 IBM NANDIS01 30.11.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # Shipping Agent to be picked validation contract
    // HEI.15 CHG2192056 CC IBM NANDIS01 08.02.2023 #to make validation in Ibecor integration, when Item is blocked
    //   Added few more validation on PFI creation stage
    // HEI.16 CHG2215561 IBM SRIVAS07 21.08.2023 - Message not transferred to Ibecor
    //   # Added Code in ComparePFIHeader()
    //   # Added Code in AssignModifiedPFIHeader()
    // HEI.17 CHG2215561 IBM SRIVAS07 23.08.2023 - Message not transferred to Ibecor
    //   # Added Code in ComparePFIHeader()
    //   # Added Code in AssignModifiedPFIHeader()
    // HEI.18 CHG2241947 SRIVAS07 IBM 04.03.2024 # Ibecor Integration - Error Log
    //   # Created newfunction PFIExpiredValidation()
    //   # Added Code in CreateUpdatePFIHeader()
    // HEI.19 CHG2241947 SRIVAS07 IBM 14.03.2024 # Ibecor Integration - Error Log
    //   # Added Code in PFIExpiredValidation().
    // HEI.20 CHG2256978 SAHAL01 15.07.2024 Ibecor - HL Integration - Update Interface
    //   # Added Code
    // HEI.21 CHG2263278 SAHAL01 16.09.2024 Adding Action Code 03
    //   # Added Code
    // HEI.22 CHG2255708 SAHAL01 14.10.2024 Ibecor PFI Acknowledgment Interface
    //   # Corrected Text Constants
    // HEI.23 CHG2290079_HB4228_StP_Report CHOUDS08 26.02.2025 for Ibecor- Heilite Integration INT04- shipment update II V
    //   # Added code in UpdatePO().
    //   # Added code in UpdatePO() to  extract datetime into tempUpdateDate variable and update in Ibecor Situational File Table.
    // HEI.24 CHG2308141 SHARMP16 30.07.2025 HB4313 Ibecor- HL integration-PFI cancelation
    //   # Added Code in ProcessPFICreation() to check some validations and deletion of PO and related entries
    // HEI.25 CHG2308141 SHARMP16 07.08.2025 HB4313 Ibecor- HL integration-PFI cancelation
    //   # Added Code in ProcessPFICreation()
    // HEI.26 CHG2308141 SHARMP16 01.09.2025 HB4313 Ibecor- HL integration-PFI cancelation
    //   # Added Code in ProcessPFICreation()


    // BC Upgrade MISHRS14 >>
    // Changed table name to "Ibecor Situational File FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<




    // BC Upgrade MISHRA14 >>
    // Changed table name to "Logistics Officers FND" as its moved from Interface to Fondation Layer.
    // BC Upgrade MISHRS14 <<


    // BC UPGRADE PATELS08 >>
    // # Table name changed from "Interface Location Matrix" to "Interface Location Matrix FND".
    // BC UPGRADE PATELS08 <<
    // BC Upgrade PATELP08>>
    // Changed name of table from "PFI Lines" to "PFI Lines FND"
    // BC Upgrade PATELP08<<

    //BC UPGRADE ATHUKS01>>
    //1.Added new code for find XML node.
    //BC UPGRADE ATHUKS01<<



    TableNo = "API Interface Log2 INT";

    trigger OnRun();
    begin
        //HEI.01>>
        APIInterfaceLog2 := Rec;
        case APIInterfaceLog2.Entity of
            'PURCHASE':
                begin
                    case APIInterfaceLog2.Operation of
                        'REQINFO':
                            begin
                                ReqPOProcess;
                            end;
                        'UPDATE':
                            begin
                                UpdatePO;
                            end;
                    end;
                end;
        end;
        Rec := APIInterfaceLog2;
        //HEI.01<<
    end;

    var
        APIInterfaceLog2: Record "API Interface Log2 INT";
        MissingNodeErr: Label '%1 node missing from XML';
        // ResponseXmlDocument : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // RootXmlNode : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // ResponsetXml : Record TempBlob temporary;
        ResponseXmlDocument: XmlDocument;
        RootXmlNode: XmlNode;
        ResponsetXml: Codeunit "Temp Blob";
        MessageResponseOutStream: OutStream;
        Text50000: Label 'There is no record available to send to Ibecor';
        grec_IbecorlInterfaceSetup: Record "Ibecor Interface Setup INT";
        GeneralInterfaceSetupRead: Boolean;
        Text50001: Label 'The Ibecor Interface is not enabled to proceed further';
        grec_PFIHeader: Record "PFI Header INT";
        grec_PFILn: Record "PFI Lines FND";
        grec_InterfaceEntryLn: Record "Interface Entry Line INT";
        grec_paymentTermsCode: Record "Payment Terms";
        grec_PaymentMethod: Record "Payment Method";
        Text50002: Label 'The PFI Document No. %1, sent from Ibecor is already present';
        Text50003: Label 'The PFI Document No. %1, is new so it can not be of other action code than 01';
        PFIModified: Boolean;
        TextMissingErr: Label 'Text missing for node %1 in XML';
        Text50004: Label 'The Item %1 does not fall under the Ibecor Item Category Code';
        Text50005: Label 'PFI Status should be Rejected or Open for the PFI - %1';
        Text50006: Label 'The UOM - %1 sent by Ibecor is not International Standard Code';
        Text50007: Label 'The Item - %1, does not have the UoM - %2';
        Text50008: Label 'The PFI Document - %1 sent from Ibecor does not have any location/Brewery value';
        Text50009: Label 'There is no valid location available for - %1 in Heilite under Location Matrix setup';
        ShipmentMethod: Record "Shipment Method";
        Text50010: Label 'Valid Price not available in the given date range of the PFI';
        Text50011: Label 'PO %1 has already been partially or fully received.';
        Text50012: Label 'Prepayment invoice has already been posted for PO %1.';

    local procedure UpdatePO();
    var
        RequestInStream: InStream;
        // RequestXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // OrderXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        RequestXmlDocument: XmlDocument;
        OrderXmlNode: XmlNode;
        TempXmlNode: XmlNode;
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        PurchHdr: Record "Purchase Header";
        lText50000: Label 'The PO Number - %1 is not available';
        StoreOrderId: Text;
        tempdate: Date;
        PurchAddtnlHdr: Record "Purchase Header Additional FND";
        tempdossierNr: Text;
        tempdateOrderFormToSupplier: Date;
        tempexpectedDateToExWorks: Date;
        tempExpectedDateDeparture: Date;
        //LinesXmlNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
        LinesXmlNodeList: XmlNodeList;
        tempshpment: Integer;
        tempexpectedDepartureDate: Date;
        // LineXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // LinesXmlNodeList2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
        // LineXmlNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        LineXmlNode: XmlNode;
        LinesXmlNodeList2: XmlNodeList;
        LineXmlNode2: XmlNode;
        tempDepartureDate: Date;
        tempDateOrigDocsSent: Date;
        tempDateCopyDocsSent: Date;
        tempDateOrigCRFSent: Date;
        tempDateCopyCRFSent: Date;
        tempDateOrigBLSent: Date;
        tempnumberContainer40Feet: Text;
        tempnumberContainer20Feet: Text;
        tempvolumeM3: Text;
        tempdateReceiptDocsForwarder: Date;
        tempdateReceiptDocsSupplier: Date;
        tempReferenceSDV: Text;
        tempTrackingInfo: Text;
        tempOrderNo: Text;
        tempshipmentDescription: Text;
        tempBLAWB: Text;
        tempExpectedDateArrival: Date;
        tempVesselName: Text;
        tempDateCopyBLSent: Date;
        IbecorSituationalFile: Record "Ibecor Situational File FND";
        dateArrivalInPortOfDestination: Date;
        //dateArrivedNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        dateArrivedNode: XmlNode;
        tempUpdateDate: DateTime;
        XMLELEMENT: XmlElement;
    begin
        //HEI.01>>
        APIInterfaceLog2."Request File".CREATEINSTREAM(RequestInStream);
        // RequestXmlDocument := RequestXmlDocument.XmlDocument;//BC Upgrade VAMSIU01
        // RequestXmlDocument.Load(RequestInStream);//BC Upgrade VAMSIU01
        //BC UPGRADE ATHUKS01>>
        //  RequestXmlDocument := XmlDocument.Create(RequestXmlDocument);
        RequestXmlDocument := XmlDocument.Create();
        //BC UPGRADE ATHUKS01<<
        XmlDocument.ReadFrom(RequestInStream, RequestXmlDocument);//BC Upgrade VAMSIU01
        SourceSystemIdentifierAPI.GET(APIInterfaceLog2."Source System Identifier");

        // OrderXmlNode := RequestXmlDocument.SelectSingleNode('/msg/payload');//BC Upgrade VAMSIU01
        // if ISNULL(OrderXmlNode) then //BC Upgrade VAMSIU01
        //     ERROR(MissingNodeErr, 'payload'); //BC Upgrade VAMSIU01
        if not RequestXmlDocument.SelectSingleNode('/msg/payload', OrderXmlNode) then //BC Upgrade VAMSIU01
            Error(MissingNodeErr, 'payload'); //BC Upgrade VAMSIU01

        //HEI.23>>
        //BC Upgrade VAMSIU01>>
        // dateArrivedNode := RequestXmlDocument.SelectSingleNode('msg/msgTimestamp');
        // if ISNULL(dateArrivedNode) then
        //     ERROR(MissingNodeErr, 'msgTimestamp');
        // if dateArrivedNode.InnerText <> '' then
        //     EVALUATE(tempUpdateDate, dateArrivedNode.InnerText);
        //BC Upgrade VAMSIU01<<
        //BC Upgrade VAMSIU01>>
        if RequestXmlDocument.SelectSingleNode('msg/msgTimestamp', dateArrivedNode) then begin
            // if dateArrivedNode.AsXmlElement().InnerText() <> '' then
            //BC UPGRADE ATHUKS01>>
            if dateArrivedNode.SelectSingleNode('msg/msgTimestamp', dateArrivedNode) then
                Evaluate(tempUpdateDate, dateArrivedNode.AsXmlElement().InnerText());
            //BC UPGRADE ATHUKS01<<
        end;
        //BC Upgrade VAMSIU01<<
        //HEI.23<<
        //BC Upgrade VAMSIU01>>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('id');
        // if ISNULL(TempXmlNode) then
        //     ERROR(MissingNodeErr, 'id')
        // else begin
        //     if not ISNULL(TempXmlNode) then
        //         if TempXmlNode.InnerText <> '' then
        //             APIInterfaceLog2."Order ID" := TempXmlNode.InnerText;
        //     StoreOrderId := TempXmlNode.InnerText;
        //     if not PurchHdr.GET(PurchHdr."Document Type"::Order, TempXmlNode.InnerText) then
        //         ERROR(lText50000, TempXmlNode.InnerText);
        // end;
        //BC Upgrade VAMSIU01<<
        //BC Upgrade VAMSIU01>>
        if not OrderXmlNode.SelectSingleNode('id', TempXmlNode) then
            Error(MissingNodeErr, 'id');
        if not TempXmlNode.IsXmlElement() then
            Error(MissingNodeErr, 'id')
        else begin
            if not TempXmlNode.IsXmlElement then
                if TempXmlNode.AsXmlElement().InnerText() <> '' then
                    APIInterfaceLog2."Order ID" := TempXmlNode.AsXmlElement().InnerText();
            StoreOrderId := TempXmlNode.AsXmlElement().InnerText();
            if not PurchHdr.Get(PurchHdr."Document Type"::Order, StoreOrderId) then
                Error(lText50000, StoreOrderId);
        end;
        //BC Upgrade VAMSIU01<<

        APIInterfaceLog2."Source Type" := DATABASE::"Purchase Header";
        //APIInterfaceLog2."Source No." := TempXmlNode.InnerText;//BC Upgrade VAMSIU01
        APIInterfaceLog2."Source No." := TempXmlNode.AsXmlElement().InnerText();//BC Upgrade VAMSIU01
        APIInterfaceLog2.MODIFY;
        COMMIT;

        //2 - dossierNr
        GetNodeByXPath('dossierNr', 'dossierNr', OrderXmlNode, TempXmlNode);
        //EVALUATE(tempdossierNr, TempXmlNode.InnerText, 9);//BC Upgrade VAMSIU01
        EVALUATE(tempdossierNr, TempXmlNode.AsXmlElement().InnerText(), 9);//BC Upgrade VAMSIU01


        //3 - dateOrderFormToSupplier
        tempdateOrderFormToSupplier := 0D;
        GetNodeByXPath('dateOrderFormToSupplier', 'dateOrderFormToSupplier', OrderXmlNode, TempXmlNode);
        // if TempXmlNode.InnerText <> '' then //BC Upgrade VAMSIU01
        //     EVALUATE(tempdateOrderFormToSupplier, TempXmlNode.InnerText, 9); //BC Upgrade VAMSIU01
        if TempXmlNode.AsXmlElement().InnerText() <> '' then //BC Upgrade VAMSIU01
            Evaluate(tempdateOrderFormToSupplier, TempXmlNode.AsXmlElement().InnerText(), 9); //BC Upgrade VAMSIU01

        //4 - expectedDateToExWorks
        tempexpectedDateToExWorks := 0D;
        GetNodeByXPath('expectedDateToExWorks', 'expectedDateToExWorks', OrderXmlNode, TempXmlNode);
        // if TempXmlNode.InnerText <> '' then//BC Upgrade VAMSIU01
        //     EVALUATE(tempexpectedDateToExWorks, TempXmlNode.InnerText, 9);//BC Upgrade VAMSIU01
        if TempXmlNode.AsXmlElement().InnerText() <> '' then //BC Upgrade VAMSIU01
            EVALUATE(tempexpectedDateToExWorks, TempXmlNode.AsXmlElement().InnerText(), 9);//BC Upgrade VAMSIU01

        //5 - registratedShipmentS
        tempshpment := 0;
        //LinesXmlNodeList := OrderXmlNode.SelectNodes('registratedShipmentS/registratedShipment'); //BC Upgrade VAMSIU01
        if not OrderXmlNode.SelectNodes('registratedShipmentS/registratedShipment', LinesXmlNodeList) then //BC Upgrade VAMSIU01
            //if ISNULL(LinesXmlNodeList) then //BC Upgrade VAMSIU01
            ERROR(MissingNodeErr, 'registratedShipment');
        foreach LineXmlNode in LinesXmlNodeList do begin
            //HEI.03>>
            //TempXmlNode := LineXmlNode.SelectSingleNode('shipment');
            //TempXmlNode := LineXmlNode.SelectSingleNode('shpment'); //BC Upgrade VAMSIU01
            LineXmlNode.SelectSingleNode('shpment', TempXmlNode); //BC Upgrade VAMSIU01
            //HEI.03<<
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempshpment, TempXmlNode.InnerText, 9);
            if not TempXmlNode.IsXmlElement then
                if TempXmlNode.AsXmlElement().InnerText() <> '' then
                    EVALUATE(tempshpment, TempXmlNode.AsXmlElement().InnerText(), 9);

            //1 - expectedDepartureDate
            tempexpectedDepartureDate := 0D;
            //TempXmlNode := LineXmlNode.SelectSingleNode('expectedDepartureDate');
            LineXmlNode.SelectSingleNode('expectedDepartureDate', TempXmlNode);
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempexpectedDepartureDate, TempXmlNode.InnerText, 9);
            if not TempXmlNode.IsXmlElement() then
                if TempXmlNode.AsXmlElement().InnerText() <> '' then
                    EVALUATE(tempexpectedDepartureDate, TempXmlNode.AsXmlElement().InnerText(), 9);

            //2 - departureDate
            tempDepartureDate := 0D;
            // TempXmlNode := LineXmlNode.SelectSingleNode('departureDate');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempDepartureDate, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('departureDate', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempshipmentDescription, TempXmlNode.AsXmlElement().InnerText(), 9);


            //3 - dateOrigDocsSent
            tempDateOrigDocsSent := 0D;
            // TempXmlNode := LineXmlNode.SelectSingleNode('dateOrigDocsSent');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempDateOrigDocsSent, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('dateOrigDocsSent', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempshipmentDescription, TempXmlNode.AsXmlElement().InnerText(), 9);

            //4 - dateCopyDocsSent
            tempDateCopyDocsSent := 0D;
            // TempXmlNode := LineXmlNode.SelectSingleNode('dateCopyDocsSent');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempDateCopyDocsSent, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('dateCopyDocsSent', TempXmlNode) then
                if not TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempshipmentDescription, TempXmlNode.AsXmlElement().InnerText(), 9);

            //5 - vesselName
            tempVesselName := '';
            // TempXmlNode := LineXmlNode.SelectSingleNode('vesselName');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempVesselName, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('vesselName', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempshipmentDescription, TempXmlNode.AsXmlElement().InnerText(), 9);

            //6 - expectedDateArrival
            tempExpectedDateArrival := 0D;
            // TempXmlNode := LineXmlNode.SelectSingleNode('expectedDateArrival');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempExpectedDateArrival, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('expectedDateArrival', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempshipmentDescription, TempXmlNode.AsXmlElement().InnerText(), 9);

            //7 - blAwb
            tempBLAWB := '';
            // TempXmlNode := LineXmlNode.SelectSingleNode('blAwb');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempBLAWB, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('blAwb', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempshipmentDescription, TempXmlNode.AsXmlElement().InnerText(), 9);

            //8 - shipmentDescription
            tempshipmentDescription := '';
            // TempXmlNode := LineXmlNode.SelectSingleNode('shipmentDescription');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempshipmentDescription, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('shipmentDescription', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempshipmentDescription, TempXmlNode.AsXmlElement().InnerText(), 9);

            //9 - trackingInfo
            tempTrackingInfo := '';
            // TempXmlNode := LineXmlNode.SelectSingleNode('trackingInfo');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempTrackingInfo, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('trackingInfo', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        EVALUATE(tempTrackingInfo, TempXmlNode.AsXmlElement().InnerText(), 9);

            //10 - referenceSdv
            tempReferenceSDV := '';
            // TempXmlNode := LineXmlNode.SelectSingleNode('referenceSdv');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempReferenceSDV, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('referenceSdv', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        EVALUATE(tempTrackingInfo, TempXmlNode.AsXmlElement().InnerText(), 9);

            //11 - dateReceiptDocsSupplier
            tempdateReceiptDocsSupplier := 0D;
            // TempXmlNode := LineXmlNode.SelectSingleNode('dateReceiptDocsSupplier');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempdateReceiptDocsSupplier, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('dateReceiptDocsSupplier', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempdateReceiptDocsSupplier, TempXmlNode.AsXmlElement().InnerText(), 9);

            //12 - dateReceiptDocsForwarder
            tempdateReceiptDocsForwarder := 0D;
            // TempXmlNode := LineXmlNode.SelectSingleNode('dateReceiptDocsForwarder');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempdateReceiptDocsForwarder, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('dateReceiptDocsForwarder', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempdateReceiptDocsForwarder, TempXmlNode.AsXmlElement().InnerText(), 9);

            //13 - volumeM3
            tempvolumeM3 := '';
            // TempXmlNode := LineXmlNode.SelectSingleNode('volumeM3');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempvolumeM3, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('volumeM3', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempvolumeM3, TempXmlNode.AsXmlElement().InnerText(), 9);

            //14 - numberContainer20Feet
            tempnumberContainer20Feet := '';
            // TempXmlNode := LineXmlNode.SelectSingleNode('numberContainer20Feet');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempnumberContainer20Feet, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('numberContainer20Feet', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempnumberContainer20Feet, TempXmlNode.AsXmlElement().InnerText(), 9);

            //15 - numberContainer40Feet
            tempnumberContainer40Feet := '';
            // TempXmlNode := LineXmlNode.SelectSingleNode('numberContainer40Feet');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempnumberContainer40Feet, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('numberContainer40Feet', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempnumberContainer40Feet, TempXmlNode.AsXmlElement().InnerText(), 9);

            //HEI.02>>
            //16 - dateArrivalInPortOfDestination
            dateArrivalInPortOfDestination := 0D;
            // TempXmlNode := LineXmlNode.SelectSingleNode('dateArrivalInPortOfDestination');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(dateArrivalInPortOfDestination, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode.SelectSingleNode('dateArrivalInPortOfDestination', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(dateArrivalInPortOfDestination, TempXmlNode.AsXmlElement().InnerText(), 9);

            //HEI.02<<
            //Create or Modify Ibecor Situational File Data
            if not IbecorSituationalFile.GET(StoreOrderId, tempshpment, IbecorSituationalFile."Shipment Type"::Registered) then begin
                IbecorSituationalFile.INIT;
                IbecorSituationalFile."Order No." := StoreOrderId;
                IbecorSituationalFile."Shipment No." := FORMAT(tempshpment);
                IbecorSituationalFile."Shipment Type" := IbecorSituationalFile."Shipment Type"::Registered;
                IbecorSituationalFile."Expected Date Departure" := tempexpectedDepartureDate;
                IbecorSituationalFile."Departure Date" := tempDepartureDate;
                IbecorSituationalFile."Date Orig. Docs Sent" := tempDateOrigDocsSent;
                IbecorSituationalFile."Date Copy Docs Sent" := tempDateCopyDocsSent;
                IbecorSituationalFile."Vessel Name" := tempVesselName;
                IbecorSituationalFile."Expected Date Arrival" := tempExpectedDateArrival;
                IbecorSituationalFile."B/L-AWB" := tempBLAWB;
                IbecorSituationalFile."Shipment Description" := tempshipmentDescription;
                IbecorSituationalFile."Tracking Information" := tempTrackingInfo;
                IbecorSituationalFile."Reference SDV" := tempReferenceSDV;
                IbecorSituationalFile."Date Receipt Docs Supplier" := tempdateReceiptDocsSupplier;
                IbecorSituationalFile."Date Receipt Docs Forwarder" := tempdateReceiptDocsForwarder;
                IbecorSituationalFile."Volume in m3" := tempvolumeM3;
                IbecorSituationalFile."Nbr cont. 20 feet" := tempnumberContainer20Feet;
                IbecorSituationalFile."Nbr cont. 40 feet" := tempnumberContainer40Feet;
                //HEI.23>>
                IbecorSituationalFile."Update Date & Time" := tempUpdateDate;
                //HEI.23<<
                //HEI.02>>
                IbecorSituationalFile."Arrival Date Destination Port" := dateArrivalInPortOfDestination;
                //HEI.02<<
                IbecorSituationalFile.INSERT;
            end else begin
                IbecorSituationalFile."Expected Date Departure" := tempexpectedDepartureDate;
                IbecorSituationalFile."Departure Date" := tempDepartureDate;
                IbecorSituationalFile."Expected Date Arrival" := tempExpectedDateArrival;
                IbecorSituationalFile."Date Orig. Docs Sent" := tempDateOrigDocsSent;
                IbecorSituationalFile."Date Copy Docs Sent" := tempDateCopyDocsSent;
                IbecorSituationalFile."Vessel Name" := tempVesselName;
                IbecorSituationalFile."B/L-AWB" := tempBLAWB;
                IbecorSituationalFile."Shipment Description" := tempshipmentDescription;
                IbecorSituationalFile."Tracking Information" := tempTrackingInfo;
                IbecorSituationalFile."Reference SDV" := tempReferenceSDV;
                IbecorSituationalFile."Date Receipt Docs Supplier" := tempdateReceiptDocsSupplier;
                IbecorSituationalFile."Date Receipt Docs Forwarder" := tempdateReceiptDocsForwarder;
                IbecorSituationalFile."Volume in m3" := tempvolumeM3;
                IbecorSituationalFile."Nbr cont. 20 feet" := tempnumberContainer20Feet;
                IbecorSituationalFile."Nbr cont. 40 feet" := tempnumberContainer40Feet;
                //HEI.23>>
                IbecorSituationalFile."Update Date & Time" := tempUpdateDate;
                //HEI.23<<
                //HEI.02>>
                IbecorSituationalFile."Arrival Date Destination Port" := dateArrivalInPortOfDestination;
                //HEI.02<<
                IbecorSituationalFile.MODIFY;
            end;
        end;

        // LinesXmlNodeList2 := OrderXmlNode.SelectNodes('currentShipment'); //BC Upgrade VAMSIU01
        // if ISNULL(LinesXmlNodeList2) then //BC Upgrade VAMSIU01
        if not OrderXmlNode.SelectNodes('currentShipment', LinesXmlNodeList2) then //BC Upgrade VAMSIU01
            ERROR(MissingNodeErr, 'currentShipment');

        foreach LineXmlNode2 in LinesXmlNodeList2 do begin
            //HEI.03>>
            tempshpment := 0;
            //TempXmlNode := LineXmlNode2.SelectSingleNode('shipment');
            //TempXmlNode := LineXmlNode2.SelectSingleNode('shpment');
            //HEI.03<<
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempshpment, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('shpment', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempshpment, TempXmlNode.AsXmlElement().InnerText(), 9);

            //1 - expectedDepartureDate
            tempexpectedDepartureDate := 0D;
            // TempXmlNode := LineXmlNode2.SelectSingleNode('expectedDepartureDate');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempexpectedDepartureDate, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('expectedDepartureDate', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempexpectedDepartureDate, TempXmlNode.AsXmlElement().InnerText(), 9);


            //2 - departureDate
            tempDepartureDate := 0D;
            // TempXmlNode := LineXmlNode2.SelectSingleNode('departureDate');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempDepartureDate, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('departureDate', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempDepartureDate, TempXmlNode.AsXmlElement().InnerText(), 9);

            //3 - dateOrigDocsSent
            tempDateOrigDocsSent := 0D;
            // TempXmlNode := LineXmlNode2.SelectSingleNode('dateOrigDocsSent');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempDateOrigDocsSent, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('dateOrigDocsSent', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempDateOrigDocsSent, TempXmlNode.AsXmlElement().InnerText(), 9);

            //4 - dateCopyDocsSent
            tempDateCopyDocsSent := 0D;
            // TempXmlNode := LineXmlNode2.SelectSingleNode('dateCopyDocsSent');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempDateCopyDocsSent, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('dateCopyDocsSent', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempDateCopyDocsSent, TempXmlNode.AsXmlElement().InnerText(), 9);

            //5 - vesselName
            tempVesselName := '';
            // TempXmlNode := LineXmlNode2.SelectSingleNode('vesselName');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempVesselName, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('vesselName', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempVesselName, TempXmlNode.AsXmlElement().InnerText(), 9);

            //6 - expectedDateArrival
            tempExpectedDateArrival := 0D;
            // TempXmlNode := LineXmlNode2.SelectSingleNode('expectedDateArrival');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempExpectedDateArrival, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('expectedDateArrival', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempExpectedDateArrival, TempXmlNode.AsXmlElement().InnerText(), 9);

            //7 - blAwb
            tempBLAWB := '';
            // TempXmlNode := LineXmlNode2.SelectSingleNode('blAwb');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempBLAWB, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('blAwb', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempBLAWB, TempXmlNode.AsXmlElement().InnerText(), 9);

            //8 - shipmentDescription
            tempshipmentDescription := '';
            // TempXmlNode := LineXmlNode2.SelectSingleNode('shipmentDescription');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempshipmentDescription, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('shipmentDescription', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempshipmentDescription, TempXmlNode.AsXmlElement().InnerText(), 9);


            //9 - trackingInfo
            tempTrackingInfo := '';
            // TempXmlNode := LineXmlNode2.SelectSingleNode('trackingInfo');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempTrackingInfo, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('trackingInfo', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempTrackingInfo, TempXmlNode.AsXmlElement().InnerText(), 9);

            //10 - referenceSdv
            tempReferenceSDV := '';
            // TempXmlNode := LineXmlNode2.SelectSingleNode('referenceSdv');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempReferenceSDV, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('referenceSdv', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempReferenceSDV, TempXmlNode.AsXmlElement().InnerText(), 9);

            //11 - dateReceiptDocsSupplier
            tempdateReceiptDocsSupplier := 0D;
            // TempXmlNode := LineXmlNode2.SelectSingleNode('dateReceiptDocsSupplier');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempdateReceiptDocsSupplier, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('dateReceiptDocsSupplier', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempdateReceiptDocsSupplier, TempXmlNode.AsXmlElement().InnerText(), 9);

            //12 - dateReceiptDocsForwarder
            tempdateReceiptDocsForwarder := 0D;
            // TempXmlNode := LineXmlNode2.SelectSingleNode('dateReceiptDocsForwarder');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempdateReceiptDocsForwarder, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('dateReceiptDocsForwarder', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempdateReceiptDocsForwarder, TempXmlNode.AsXmlElement().InnerText(), 9);

            //13 - volumeM3
            tempvolumeM3 := '';
            // TempXmlNode := LineXmlNode2.SelectSingleNode('volumeM3');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempvolumeM3, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('volumeM3', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempvolumeM3, TempXmlNode.AsXmlElement().InnerText(), 9);

            //14 - numberContainer20Feet
            tempnumberContainer20Feet := '';
            // TempXmlNode := LineXmlNode2.SelectSingleNode('numberContainer20Feet');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempnumberContainer20Feet, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('numberContainer20Feet', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempnumberContainer20Feet, TempXmlNode.AsXmlElement().InnerText(), 9);

            //15 - numberContainer40Feet
            tempnumberContainer40Feet := '';
            // TempXmlNode := LineXmlNode2.SelectSingleNode('numberContainer40Feet');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(tempnumberContainer40Feet, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('numberContainer40Feet', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(tempnumberContainer40Feet, TempXmlNode.AsXmlElement().InnerText(), 9);

            //HEI.02>>
            //16 - dateArrivalInPortOfDestination
            dateArrivalInPortOfDestination := 0D;
            // TempXmlNode := LineXmlNode2.SelectSingleNode('dateArrivalInPortOfDestination');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(dateArrivalInPortOfDestination, TempXmlNode.InnerText, 9);
            Clear(TempXmlNode);
            if LineXmlNode2.SelectSingleNode('dateArrivalInPortOfDestination', TempXmlNode) then
                if TempXmlNode.IsXmlElement() then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        Evaluate(dateArrivalInPortOfDestination, TempXmlNode.AsXmlElement().InnerText(), 9);

            //HEI.02<<
            //Create or Modify Ibecor Situational File Data
            if not IbecorSituationalFile.GET(StoreOrderId, tempshpment, IbecorSituationalFile."Shipment Type"::Current) then begin
                IbecorSituationalFile.INIT;
                IbecorSituationalFile."Order No." := StoreOrderId;
                IbecorSituationalFile."Shipment No." := FORMAT(tempshpment);
                IbecorSituationalFile."Shipment Type" := IbecorSituationalFile."Shipment Type"::Current;
                IbecorSituationalFile."Expected Date Departure" := tempexpectedDepartureDate;
                IbecorSituationalFile."Departure Date" := tempDepartureDate;
                IbecorSituationalFile."Date Orig. Docs Sent" := tempDateOrigDocsSent;
                IbecorSituationalFile."Date Copy Docs Sent" := tempDateCopyDocsSent;
                IbecorSituationalFile."Vessel Name" := tempVesselName;
                IbecorSituationalFile."Expected Date Arrival" := tempExpectedDateArrival;
                IbecorSituationalFile."B/L-AWB" := tempBLAWB;
                IbecorSituationalFile."Shipment Description" := tempshipmentDescription;
                IbecorSituationalFile."Tracking Information" := tempTrackingInfo;
                IbecorSituationalFile."Reference SDV" := tempReferenceSDV;
                IbecorSituationalFile."Date Receipt Docs Supplier" := tempdateReceiptDocsSupplier;
                IbecorSituationalFile."Date Receipt Docs Forwarder" := tempdateReceiptDocsForwarder;
                IbecorSituationalFile."Volume in m3" := tempvolumeM3;
                IbecorSituationalFile."Nbr cont. 20 feet" := tempnumberContainer20Feet;
                IbecorSituationalFile."Nbr cont. 40 feet" := tempnumberContainer40Feet;
                //HEI.23>>
                IbecorSituationalFile."Update Date & Time" := tempUpdateDate;
                //HEI.23<<
                //HEI.02>>
                IbecorSituationalFile."Arrival Date Destination Port" := dateArrivalInPortOfDestination;
                //HEI.02<<
                IbecorSituationalFile.INSERT;
            end else begin
                IbecorSituationalFile."Expected Date Departure" := tempexpectedDepartureDate;
                IbecorSituationalFile."Departure Date" := tempDepartureDate;
                IbecorSituationalFile."Expected Date Arrival" := tempExpectedDateArrival;
                IbecorSituationalFile."Date Orig. Docs Sent" := tempDateOrigDocsSent;
                IbecorSituationalFile."Date Copy Docs Sent" := tempDateCopyDocsSent;
                IbecorSituationalFile."Vessel Name" := tempVesselName;
                IbecorSituationalFile."B/L-AWB" := tempBLAWB;
                IbecorSituationalFile."Shipment Description" := tempshipmentDescription;
                IbecorSituationalFile."Tracking Information" := tempTrackingInfo;
                IbecorSituationalFile."Reference SDV" := tempReferenceSDV;
                IbecorSituationalFile."Date Receipt Docs Supplier" := tempdateReceiptDocsSupplier;
                IbecorSituationalFile."Date Receipt Docs Forwarder" := tempdateReceiptDocsForwarder;
                IbecorSituationalFile."Volume in m3" := tempvolumeM3;
                IbecorSituationalFile."Nbr cont. 20 feet" := tempnumberContainer20Feet;
                IbecorSituationalFile."Nbr cont. 40 feet" := tempnumberContainer40Feet;
                //HEI.23>>
                IbecorSituationalFile."Update Date & Time" := tempUpdateDate;
                //HEI.23<<
                //HEI.02>>
                IbecorSituationalFile."Arrival Date Destination Port" := dateArrivalInPortOfDestination;
                //HEI.02<<
                IbecorSituationalFile.MODIFY;
            end;

            //Update Purch Additional Header Table
            if PurchAddtnlHdr.GET(PurchAddtnlHdr."Document Type"::Order, StoreOrderId) then begin
                //HEI.04>>
                //HEI.03>>
                PurchAddtnlHdr."Order No. INT" := FORMAT(tempshpment);
                //HEI.03<<
                //HEI.04<<
                PurchAddtnlHdr."Order FormTo Supplier Date INT" := tempdateOrderFormToSupplier;
                PurchAddtnlHdr."Expected Date to Ex Works INT" := tempexpectedDateToExWorks;
                PurchAddtnlHdr."Expected Date Departure INT" := tempexpectedDepartureDate;
                PurchAddtnlHdr."Departure Date INT" := tempDepartureDate;
                PurchAddtnlHdr."Expected Date Arrival INT" := tempExpectedDateArrival;
                PurchAddtnlHdr."Date Orig. Docs Sent INT" := tempDateOrigDocsSent;
                PurchAddtnlHdr."Date Copy Docs Sent INT" := tempDateCopyDocsSent;
                PurchAddtnlHdr."Vessel Name INT" := tempVesselName;
                PurchAddtnlHdr."B/L-AWB INT" := tempBLAWB;
                PurchAddtnlHdr."Shipment Description INT" := tempshipmentDescription;
                PurchAddtnlHdr."Tracking Information INT" := tempTrackingInfo;
                PurchAddtnlHdr."Reference SDV INT" := tempReferenceSDV;
                PurchAddtnlHdr."Date Receipt Docs Supplier INT" := tempdateReceiptDocsSupplier;
                PurchAddtnlHdr."Date ReceiptDocs Forwarder INT" := tempdateReceiptDocsForwarder;
                PurchAddtnlHdr."Volume in m3 INT" := tempvolumeM3;
                PurchAddtnlHdr."Nbr cont. 20 feet INT" := tempnumberContainer20Feet;
                PurchAddtnlHdr."Nbr cont. 40 feet INT" := tempnumberContainer40Feet;
                //HEI.02>>
                PurchAddtnlHdr."Arrival Date Dest. Port INT" := dateArrivalInPortOfDestination;
                //HEI.02<<
                PurchAddtnlHdr.MODIFY;
            end;
        end;
        //HEI.01<<
    end;

    //BC Upgrade VAMSIU01 - Start

    // local procedure GetNodeByXPath(XPath: Text; NodeName: Text; var ParentXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; var XmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode");
    // begin
    //     //HEI.01>>
    //     XmlNode := ParentXmlNode.SelectSingleNode(XPath); // Mandatory
    //     if ISNULL(XmlNode) then
    //         ERROR(MissingNodeErr, NodeName);
    //     if XmlNode.InnerText = '' then
    //         ERROR(TextMissingErr, NodeName);
    //     //HEI.01<<
    // end;

    //BC Upgrade VAMSIU01 - End

    //BC Upgrade VAMSIU01 - Start

    local procedure GetNodeByXPath(XPath: Text; NodeName: Text; var ParentXmlNode: XmlNode; var ResultXmlNode: XmlNode)
    begin
        // HEI.01 >>

        if ParentXmlNode.SelectSingleNode(XPath, ResultXmlNode) then
            if not ResultXmlNode.IsXmlElement() then
                Error(MissingNodeErr, NodeName);

        if ResultXmlNode.AsXmlElement().InnerText() = '' then
            Error(TextMissingErr, NodeName);

        // HEI.01 <<
    end;

    //BC Upgrade VAMSIU01 - End


    local procedure ReqPOProcess();
    var
        RequestInStream: InStream;
        //RequestXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        // OrderXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // OrderXmlNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
        // TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        docno: Text;
        PostingDate: Text;
        DocumentDate: Text;
        lrec_Ibecor_POData: Record "Ibecor PO Staging Data INT";
    begin
        //HEI.01>>
        lrec_Ibecor_POData.RESET;
        lrec_Ibecor_POData.SETRANGE("Movement Status", lrec_Ibecor_POData."Movement Status"::"Ready to Send");
        if not lrec_Ibecor_POData.FINDFIRST then
            ERROR(Text50000);
        //HEI.01<<
    end;

    procedure ProcessPFICreation(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        PONo: Code[30];
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        QtyReceived: Boolean;
        TrackingSpecification: Record "Tracking Specification";
        PurchasesUtils: Codeunit "Purchases-Utils";
    begin
        //HEI.01>>
        grec_IbecorlInterfaceSetup.GET;
        if not grec_IbecorlInterfaceSetup."Interface Enable/Disable" then
            ERROR(Text50001);
        grec_IbecorlInterfaceSetup.TESTFIELD("IBECOR PFI");
        grec_IbecorlInterfaceSetup.TESTFIELD("IBECOR Shipping Agent Code");
        grec_IbecorlInterfaceSetup.TESTFIELD("IBC Item Category");

        InterfaceEntryHeader.TESTFIELD("Action Code");
        case InterfaceEntryHeader."Action Code" of
            '01':
                begin
                    grec_PFIHeader.RESET;
                    grec_PFIHeader.SETRANGE("PFI Document No.", InterfaceEntryHeader."Source No.");
                    if not grec_PFIHeader.FINDFIRST then begin
                        if ValidPFItobecreated(InterfaceEntryHeader) then
                            CreateUpdatePFIHeader(grec_PFIHeader, InterfaceEntryHeader, 0);
                    end else
                        ERROR(Text50002, InterfaceEntryHeader."Source No.");
                end;
            '02':
                begin
                    grec_PFIHeader.RESET;
                    grec_PFIHeader.SETRANGE("PFI Document No.", InterfaceEntryHeader."Source No.");
                    //HEI.20>>
                    if not grec_PFIHeader.FINDFIRST then begin
                        if ValidPFItobecreated(InterfaceEntryHeader) then
                            CreateUpdatePFIHeader(grec_PFIHeader, InterfaceEntryHeader, 0);
                    end else begin
                        //IF grec_PFIHeader.FINDFIRST THEN BEGIN
                        //HEI.20<<
                        if not (grec_PFIHeader."PFI Status" in [grec_PFIHeader."PFI Status"::Accepted, grec_PFIHeader."PFI Status"::Rejected, grec_PFIHeader."PFI Status"::Open]) then
                            if not PFIExpiredValidation(grec_PFIHeader, InterfaceEntryHeader) then //HEI.18
                                ERROR(Text50005, grec_PFIHeader."PFI Document No.");
                        grec_PFIHeader.CALCFIELDS("PO Created");
                        grec_PFIHeader.TESTFIELD("PO Created", false);
                        CreateUpdatePFIHeader(grec_PFIHeader, InterfaceEntryHeader, 1);
                        //HEI.20>>
                    end;
                    //END ELSE
                    //ERROR(Text50003,InterfaceEntryHeader."Source No.");
                    //HEI.20<<
                end;
            '03':
                begin
                    grec_PFIHeader.RESET;
                    grec_PFIHeader.SETRANGE("PFI Document No.", InterfaceEntryHeader."Source No.");
                    //HEI.21>>
                    if not grec_PFIHeader.FINDFIRST then begin
                        if ValidPFItobecreated(InterfaceEntryHeader) then
                            CreateUpdatePFIHeader(grec_PFIHeader, InterfaceEntryHeader, 0);
                    end else begin
                        //IF grec_PFIHeader.FINDFIRST THEN BEGIN
                        //HEI.21<<
                        if not (grec_PFIHeader."PFI Status" in [grec_PFIHeader."PFI Status"::Accepted, grec_PFIHeader."PFI Status"::Rejected, grec_PFIHeader."PFI Status"::Open]) then
                            ERROR(Text50005, grec_PFIHeader."PFI Document No.");
                        grec_PFIHeader.CALCFIELDS("PO Created");
                        //grec_PFIHeader.TESTFIELD("PO Created",FALSE);HEI.28>>
                        //HEI.24>>
                        if grec_PFIHeader."PO Created" then begin
                            QtyReceived := false;
                            grec_PFILn.RESET;
                            grec_PFILn.SETRANGE("PFI Document No.", grec_PFIHeader."PFI Document No.");
                            grec_PFILn.SETFILTER("PO Number", '<>%1', '');
                            if grec_PFILn.FINDSET(false) then begin
                                PONo := grec_PFILn."PO Number";
                            end;
                            PurchaseLine.RESET;
                            PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
                            PurchaseLine.SETRANGE("Document No.", PONo);
                            if PurchaseLine.FINDFIRST then begin
                                repeat
                                    if PurchaseLine."Quantity Received" > 0 then
                                        ERROR(Text50011, PONo);
                                    QtyReceived := true;
                                    // (k) Check if prepayment invoice exists
                                    if PurchaseLine."Prepmt. Amt. Inv." > 0 then
                                        ERROR(Text50012, PONo);
                                until PurchaseLine.NEXT = 0;
                            end;
                            WarehouseReceiptHeader.RESET;
                            WarehouseReceiptHeader.SETRANGE("Source Document Type FND", WarehouseReceiptHeader."Source Document Type FND"::"Purchase Order");
                            WarehouseReceiptHeader.SETRANGE("Source No. FND", PONo);
                            if WarehouseReceiptHeader.FINDFIRST then begin
                                repeat
                                    WarehouseReceiptLine.RESET;
                                    WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
                                    if WarehouseReceiptLine.FINDFIRST then
                                        WarehouseReceiptLine.DELETEALL;
                                    WarehouseReceiptHeader.DELETE;
                                until WarehouseReceiptHeader.NEXT = 0;
                            end;
                            TrackingSpecification.RESET;
                            TrackingSpecification.SETRANGE("Source ID", PONo);
                            if TrackingSpecification.FINDFIRST then
                                TrackingSpecification.DELETEALL;

                            //HEI.25>>
                            //IF PurchaseHeader.GET(PONo) THEN BEGIN
                            PurchaseHeader.RESET;
                            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
                            PurchaseHeader.SETRANGE("No.", PONo);
                            if PurchaseHeader.FINDFIRST then begin
                                PurchaseHeader.VALIDATE(Status, PurchaseHeader.Status::Open);
                                PurchaseHeader.MODIFY;
                                //HEI.26>>
                                if PurchasesUtils.TODeletionRestriction(PurchaseHeader) then
                                    PurchasesUtils.ManageTOfromPO(PurchaseHeader);
                                //HEI.26<<
                            end;
                            //HEI.25<<

                            PurchaseLine.RESET;
                            PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
                            PurchaseLine.SETRANGE("Document No.", PONo);
                            if PurchaseLine.FINDFIRST then begin
                                PurchaseLine.DELETEALL;
                                PurchaseHeader.DELETE;
                            end;

                            grec_PFILn.RESET;
                            grec_PFILn.SETRANGE("No.", grec_PFIHeader."PFI Document No.");
                            if grec_PFILn.FINDFIRST then
                                repeat
                                    grec_PFILn."PO Number" := '';
                                    grec_PFILn.MODIFY;
                                until grec_PFILn.NEXT = 0;
                        end;
                        //HEI.24<<
                        CancelPFI(grec_PFIHeader);
                        //HEI.21>>
                    end;
                    //END ELSE
                    //ERROR(Text50003,InterfaceEntryHeader."Source No.");
                    //HEI.21<<
                end;
        end;
        //HEI.01<<
    end;

    local procedure CreateUpdatePFIHeader(prec_PFIHdr: Record "PFI Header INT"; prec_InterfaceEntryHeader: Record "Interface Entry Header INT"; "Action": Option Insert,Modify);
    var
        lrecPHIHdrMod: Record "PFI Header INT";
        lrecPFILnLineNumber: Record "PFI Lines FND";
        LineNumber: Integer;
        lrecItem: Record Item;
        lrec_PurchaseLine: Record "Purchase Line";
        StoreItemCMGNo: Code[20];
        lrecShippingAgent: Record "Shipping Agent";
        lrec_PurchLnPrice: Record "Purchase Line Price FND";

        lrec_LogisticsOfficers: Record "Logistics Officers FND";
        lrec_InterfaceLocationMatrix: Record "Interface Location Matrix FND";

        lrec_Vendor: Record Vendor;
    begin
        //HEI.01>>
        grec_IbecorlInterfaceSetup.TESTFIELD("Default CMG");
        case Action of
            Action::Insert:
                begin
                    prec_PFIHdr.INIT;
                    prec_PFIHdr."PFI Document No." := prec_InterfaceEntryHeader."Source No.";
                    prec_PFIHdr."PFI Status" := prec_PFIHdr."PFI Status"::Open;
                    prec_PFIHdr."Document Date" := prec_InterfaceEntryHeader."Posting Date";
                    prec_PFIHdr."PQ Number" := prec_InterfaceEntryHeader."Your Reference";
                    if grec_paymentTermsCode.GET(prec_InterfaceEntryHeader."Payment Terms Code") then begin
                        prec_PFIHdr."Payment Terms Code" := prec_InterfaceEntryHeader."Payment Terms Code";
                        prec_PFIHdr."Payment Terms Description" := prec_InterfaceEntryHeader.Name;
                    end;
                    if grec_PaymentMethod.GET(prec_InterfaceEntryHeader."Shipping Agent Code") then begin
                        prec_PFIHdr."Payment Method Code" := prec_InterfaceEntryHeader."Shipping Agent Code";
                        prec_PFIHdr."Payment Method Description" := prec_InterfaceEntryHeader."External Requisition No.";
                    end;
                    if ShipmentMethod.GET(prec_InterfaceEntryHeader."Driver Code") then begin
                        prec_PFIHdr."Shipment Method Code" := prec_InterfaceEntryHeader."Driver Code";
                        prec_PFIHdr."Shipment Method Description" := prec_InterfaceEntryHeader.Address;
                    end;
                    prec_PFIHdr."IBECOR Dossier No." := prec_InterfaceEntryHeader."External Order No.";
                    prec_PFIHdr."Logistics Officer" := prec_InterfaceEntryHeader."Transfer-from Code";
                    if (prec_InterfaceEntryHeader."E-Mail" <> '') then
                        prec_PFIHdr."Logistics Officer Email" := prec_InterfaceEntryHeader."E-Mail"
                    else begin
                        lrec_LogisticsOfficers.RESET;
                        lrec_LogisticsOfficers.SETRANGE("LO Code", prec_InterfaceEntryHeader."Transfer-from Code");
                        if lrec_LogisticsOfficers.FINDFIRST then
                            if (lrec_LogisticsOfficers."LO Name" <> '') then
                                prec_PFIHdr."Logistics Officer Email" := lrec_LogisticsOfficers."LO Email";
                    end;
                    prec_PFIHdr."Total Amount(Incl. VAT)" := prec_InterfaceEntryHeader.Amount;
                    prec_PFIHdr."Currency Code" := prec_InterfaceEntryHeader."Currency Code";
                    prec_PFIHdr."PFI Expiration Date" := prec_InterfaceEntryHeader."Valid From";
                    prec_PFIHdr."Brewery ID" := prec_InterfaceEntryHeader.Contact;
                    prec_PFIHdr.Description := prec_InterfaceEntryHeader.Description;
                    prec_PFIHdr."PFI Version No" := 0;
                    //HEI.14>>
                    prec_PFIHdr."License Required" := prec_InterfaceEntryHeader."Processing Flag";
                    prec_PFIHdr."Credit Info Required" := prec_InterfaceEntryHeader."Simulation Done";
                    //HEI.14<<
                    prec_PFIHdr.INSERT;
                    grec_PFILn.RESET;
                    CrateUpdatePFILines(prec_PFIHdr, prec_InterfaceEntryHeader, 0, grec_PFILn);
                end;
            Action::Modify:
                begin
                    PFIModified := false;
                    if ComparePFIHeader(prec_PFIHdr, prec_InterfaceEntryHeader) then begin
                        AssignModifiedPFIHeader(prec_PFIHdr, prec_InterfaceEntryHeader);
                        PFIModified := true;
                    end;
                    //HEI.07>>
                    //LineNumber := 0;
                    //grec_InterfaceEntryLn.RESET;
                    //grec_InterfaceEntryLn.SETRANGE("Header Entry No.",prec_InterfaceEntryHeader."Entry No.");
                    //IF grec_InterfaceEntryLn.FINDSET THEN REPEAT
                    //  grec_PFILn.RESET;
                    //  grec_PFILn.SETRANGE("PFI Document No.",prec_PFIHdr."PFI Document No.");
                    //  grec_PFILn.SETRANGE("PFI Line No.",grec_InterfaceEntryLn."Source Line No.");
                    //  IF NOT grec_PFILn.FINDFIRST THEN BEGIN
                    //    lrecPFILnLineNumber.RESET;
                    //    lrecPFILnLineNumber.SETRANGE("PFI Document No.",prec_PFIHdr."PFI Document No.");
                    //    IF lrecPFILnLineNumber.FINDLAST THEN
                    //      LineNumber := lrecPFILnLineNumber."Line No" + 10000
                    //    ELSE
                    //      LineNumber := 10000;
                    //
                    //    grec_PFILn.INIT;
                    //    grec_PFILn."PFI Document No." := prec_PFIHdr."PFI Document No.";
                    //    grec_PFILn."Line No" := LineNumber;
                    //    grec_PFILn."PFI Line No." := grec_InterfaceEntryLn."Source Line No.";
                    //    grec_PFILn.Type := grec_InterfaceEntryLn.Type;//validation req
                    //    IF (grec_InterfaceEntryLn."Description 2" <> '') THEN BEGIN
                    //      lrecItem.RESET;
                    //      lrecItem.SETRANGE("No. 2",grec_InterfaceEntryLn."Description 2");
                    //      IF lrecItem.FINDFIRST THEN BEGIN
                    //        grec_PFILn.Type := grec_PFILn.Type::Item;
                    //        grec_PFILn."No." := lrecItem."No.";
                    //      END;
                    //    END;
                    //    grec_PFILn."CMG Code" := grec_InterfaceEntryLn."CMG Code";//validation req
                    //    grec_PFILn.Description := grec_InterfaceEntryLn.Description;
                    //    grec_PFILn.Amount := grec_InterfaceEntryLn."Line Amount";
                    //    lrec_Vendor.RESET;
                    //    lrec_Vendor.SETRANGE("Global Vendor Number",grec_IbecorlInterfaceSetup."IBECOR Vendor");
                    //    IF lrec_Vendor.FINDFIRST THEN;
                    //    lrec_PurchaseLine.RESET;
                    //    lrec_PurchaseLine.SETRANGE("Document Type",lrec_PurchaseLine."Document Type"::"Blanket Order");
                    //    lrec_PurchaseLine.SETRANGE("Buy-from Vendor No.",lrec_Vendor."No.");
                    //    IF (grec_InterfaceEntryLn."Description 2" <> '') THEN BEGIN
                    //      lrecItem.RESET;
                    //      lrecItem.SETRANGE("No. 2",grec_InterfaceEntryLn."Description 2");
                    //      IF lrecItem.FINDFIRST THEN
                    //        StoreItemCMGNo := lrecItem."No.";
                    //    END;
                    //    lrec_PurchaseLine.SETRANGE("No.",StoreItemCMGNo);
                    //    IF lrec_PurchaseLine.FINDLAST THEN BEGIN
                    //      grec_PFILn."Blanket Order No" := lrec_PurchaseLine."Document No.";
                    //      lrec_PurchLnPrice.RESET;
                    //      lrec_PurchLnPrice.SETRANGE("Document Type",lrec_PurchaseLine."Document Type"::"Blanket Order");
                    //      lrec_PurchLnPrice.SETRANGE("Document No.",lrec_PurchaseLine."No.");
                    //      lrec_PurchLnPrice.SETRANGE("Document Line No.",lrec_PurchaseLine."Line No.");
                    //      IF lrec_PurchLnPrice.FINDLAST THEN
                    //        grec_PFILn."Price from Blanket Order" := lrec_PurchLnPrice."Direct Unit Cost";
                    //    END;
                    //    IF lrecShippingAgent.GET(grec_IbecorlInterfaceSetup."IBECOR Shipping Agent Code") THEN
                    //      grec_PFILn."Shipping Agent Code" := lrecShippingAgent.Code;
                    //    grec_PFILn.Quantity := grec_InterfaceEntryLn.Quantity;
                    //    grec_PFILn."Unit Price" := grec_InterfaceEntryLn."Unit Amount";
                    //    grec_PFILn."Unit Of Measure" := grec_InterfaceEntryLn."Unit of Measure Code";
                    //    IF (prec_InterfaceEntryHeader.Contact <> '') THEN BEGIN
                    //      lrec_InterfaceLocationMatrix.RESET;
                    //      lrec_InterfaceLocationMatrix.SETRANGE("Heilite Location Code",prec_InterfaceEntryHeader.Contact);
                    //      IF lrec_InterfaceLocationMatrix.FINDFIRST THEN
                    //        grec_PFILn."Location Code" := lrec_InterfaceLocationMatrix."Heilite Location Code";
                    //    END;
                    //    grec_PFILn.INSERT;
                    //    PFIModified := TRUE;
                    //  END ELSE BEGIN
                    //    IF ComparePFILines(grec_PFILn,grec_InterfaceEntryLn) THEN BEGIN
                    //      grec_PFILn.Quantity := grec_InterfaceEntryLn.Quantity;
                    //      grec_PFILn."Unit Price" := grec_InterfaceEntryLn."Unit Amount";
                    //      grec_PFILn.Description := grec_InterfaceEntryLn.Description;
                    //      grec_PFILn.Amount := grec_InterfaceEntryLn."Line Amount";
                    //      grec_PFILn.MODIFY;
                    //      PFIModified := TRUE;
                    //    END;
                    //  END;
                    //UNTIL grec_InterfaceEntryLn.NEXT = 0;
                    grec_PFILn.RESET;
                    grec_PFILn.SETRANGE("PFI Document No.", prec_PFIHdr."PFI Document No.");
                    grec_PFILn.DELETEALL;
                    grec_PFILn.RESET;
                    CrateUpdatePFILines(prec_PFIHdr, prec_InterfaceEntryHeader, 0, grec_PFILn);
                    PFIModified := true;
                    //HEI.07<<
                    if PFIModified then begin
                        if lrecPHIHdrMod.GET(prec_PFIHdr."PFI Document No.") then begin
                            lrecPHIHdrMod."PFI Version No" += 1;
                            lrecPHIHdrMod.Amend := lrecPHIHdrMod.Amend::" ";
                            lrecPHIHdrMod."PFI Status" := lrecPHIHdrMod."PFI Status"::Open;
                            lrecPHIHdrMod.MODIFY;
                        end;
                    end;
                    //HEI.07>>
                    ////HEI.06>>
                    //grec_PFILn.RESET;
                    //grec_PFILn.SETRANGE("PFI Document No.",prec_PFIHdr."PFI Document No.");
                    //IF grec_PFILn.FINDFIRST THEN REPEAT
                    //  grec_InterfaceEntryLn.RESET;
                    //  grec_InterfaceEntryLn.SETRANGE("Header Entry No.",prec_InterfaceEntryHeader."Entry No.");
                    //  grec_InterfaceEntryLn.SETRANGE("Source Line No.",grec_PFILn."PFI Line No.");
                    //  IF NOT grec_InterfaceEntryLn.FINDFIRST THEN
                    //    grec_PFILn.DELETE;
                    //UNTIL grec_PFILn.NEXT = 0;
                    ////HEI.06<<
                    //HEI.07<<
                end;
        end;
        //HEI.01<<
    end;

    local procedure CrateUpdatePFILines(prec_PFIHeader: Record "PFI Header INT"; p_InterfaceEntryHeader: Record "Interface Entry Header INT"; "Action": Option Insert,Modify; p_PFILn: Record "PFI Lines FND");
    var
        lrec_PFILns: Record "PFI Lines FND";
        LineNo: Integer;
        lrec_PFILns_LineNo: Record "PFI Lines FND";
        lrec_PurchaseLine: Record "Purchase Line";
        lrecItem: Record Item;
        StoreItemCMGNo: Code[20];
        lrecShippingAgent: Record "Shipping Agent";
        lrec_PurchLnPrice: Record "Purchase Line Price FND";
        lrec_InterfaceLocationMatrix: Record "Interface Location Matrix FND";
        ItemCMGNo: Code[20];
        lrecDimValue: Record "Dimension Value";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        lrec_ShippingAgentServices: Record "Shipping Agent Services";
        lrec_Vendor: Record Vendor;
    begin
        //HEI.01>>
        grec_IbecorlInterfaceSetup.GET;

        case Action of
            Action::Insert:
                begin
                    StoreItemCMGNo := '';
                    ItemCMGNo := '';
                    LineNo := 0;
                    grec_InterfaceEntryLn.RESET;
                    grec_InterfaceEntryLn.SETRANGE("Header Entry No.", p_InterfaceEntryHeader."Entry No.");
                    if grec_InterfaceEntryLn.FINDSET then
                        repeat
                            lrec_PFILns_LineNo.RESET;
                            lrec_PFILns_LineNo.SETRANGE("PFI Document No.", prec_PFIHeader."PFI Document No.");
                            if lrec_PFILns_LineNo.FINDLAST then
                                LineNo := lrec_PFILns_LineNo."Line No" + 10000
                            else
                                LineNo := 10000;
                            lrec_PFILns.INIT;
                            lrec_PFILns."PFI Document No." := prec_PFIHeader."PFI Document No.";
                            lrec_PFILns."Line No" := LineNo;
                            lrec_PFILns."PFI Line No." := grec_InterfaceEntryLn."Source Line No.";

                            //Validation of Type and No.
                            case grec_InterfaceEntryLn.Type of
                                grec_InterfaceEntryLn.Type::" ":
                                    begin
                                        lrec_PFILns.Type := lrec_PFILns.Type::" ";
                                        lrec_PFILns."No." := '';
                                        lrec_PFILns.Description := grec_InterfaceEntryLn.Description;
                                    end;
                                grec_InterfaceEntryLn.Type::"G/L Account":
                                    begin
                                        lrec_PFILns.Type := lrec_PFILns.Type::"Item Charge";
                                        lrec_PFILns."No." := grec_IbecorlInterfaceSetup."Default CMG";
                                    end;
                                grec_InterfaceEntryLn.Type::Item:
                                    begin
                                        if (grec_InterfaceEntryLn."Description 2" = '') and (grec_InterfaceEntryLn."CMG Code" = '') then begin
                                            lrec_PFILns.Type := lrec_PFILns.Type::"Item Charge";
                                            lrec_PFILns."No." := grec_IbecorlInterfaceSetup."Default CMG";
                                        end;
                                        if (grec_InterfaceEntryLn."Description 2" <> '') then begin
                                            lrec_PFILns.Type := lrec_PFILns.Type::Item;
                                            lrecItem.RESET;
                                            lrecItem.SETRANGE("No. 2", grec_InterfaceEntryLn."Description 2");
                                            if lrecItem.FINDFIRST then
                                                ItemCMGNo := lrecItem."No.";
                                            if (ItemCMGNo <> '') then begin
                                                if not FindItemCategoryFilters(lrecItem) then
                                                    ERROR(Text50004, ItemCMGNo);
                                            end;
                                            lrec_PFILns."No." := ItemCMGNo;
                                        end;
                                        if (grec_InterfaceEntryLn."Description 2" = '') and (grec_InterfaceEntryLn."CMG Code" <> '') then begin
                                            lrec_PFILns.Type := lrec_PFILns.Type::"Item Charge";
                                            lrecDimValue.RESET;
                                            lrecDimValue.SETRANGE("Dimension Code", 'CMG');
                                            lrecDimValue.SETRANGE(Code, grec_InterfaceEntryLn."CMG Code");
                                            if lrecDimValue.FINDFIRST then
                                                lrec_PFILns."No." := lrecDimValue.Code;

                                            //HEI.10>>
                                            //To fetch BO Number and the price from BO Price
                                            if (lrec_PFILns."No." <> '') then begin
                                                lrec_Vendor.RESET;
                                                lrec_Vendor.SETRANGE("Global Vendor Number FND", grec_IbecorlInterfaceSetup."IBECOR Vendor");
                                                if lrec_Vendor.FINDFIRST then;

                                                lrec_PurchaseLine.RESET;
                                                lrec_PurchaseLine.SETRANGE("Document Type", lrec_PurchaseLine."Document Type"::"Blanket Order");
                                                lrec_PurchaseLine.SETRANGE("Buy-from Vendor No.", lrec_Vendor."No.");
                                                lrec_PurchaseLine.SETRANGE("No.", lrec_PFILns."No.");
                                                lrec_PurchaseLine.SETRANGE("Block Line Ordering FND", lrec_PurchaseLine."Block Line Ordering FND"::" ");
                                                lrec_PurchaseLine.SETRANGE("Currency Code", prec_PFIHeader."Currency Code");  //HEI.12
                                                if lrec_PurchaseLine.FINDLAST then begin
                                                    lrec_PFILns."Blanket Order No" := lrec_PurchaseLine."Document No.";
                                                    lrec_PurchLnPrice.RESET;
                                                    lrec_PurchLnPrice.SETRANGE("Document Type", lrec_PurchaseLine."Document Type"::"Blanket Order");
                                                    lrec_PurchLnPrice.SETRANGE("Document No.", lrec_PurchaseLine."Document No.");
                                                    lrec_PurchLnPrice.SETRANGE("Document Line No.", lrec_PurchaseLine."Line No.");
                                                    lrec_PurchLnPrice.SETFILTER("Starting Date", '<=%1', prec_PFIHeader."Document Date");
                                                    lrec_PurchLnPrice.SETFILTER("Ending Date", '>=%1', prec_PFIHeader."Document Date");
                                                    lrec_PurchLnPrice.SETRANGE("Currency Code", prec_PFIHeader."Currency Code");
                                                    if lrec_PurchLnPrice.FINDLAST then begin
                                                        lrec_PFILns."UOM of BO" := lrec_PurchLnPrice."Unit of Measure Code";
                                                        if lrecItem.GET(lrec_PFILns."No.") then;
                                                        if (lrecItem."Base Unit of Measure" <> lrec_PFILns."Unit Of Measure") then begin
                                                            if (lrec_PurchLnPrice."Direct Unit Cost Multiplier" <> 0) then begin
                                                                lrec_PFILns."Price from Blanket Order" := lrec_PurchLnPrice."Direct Cost Per Multiplier";
                                                                lrec_PFILns."Direct Multiplier of BO" := lrec_PurchLnPrice."Direct Unit Cost Multiplier";
                                                            end else begin
                                                                lrec_PFILns."Price from Blanket Order" := lrec_PurchLnPrice."Direct Unit Cost";
                                                                lrec_PFILns."Direct Multiplier of BO" := 0;
                                                            end;
                                                        end;
                                                    end else
                                                        lrec_PFILns."Price from Blanket Order" := 0;
                                                end;
                                            end;
                                            //HEI.10<<
                                        end;
                                    end;
                            end;

                            lrec_PFILns."CMG Code" := grec_InterfaceEntryLn."CMG Code";//validation req
                            lrec_PFILns.Description := grec_InterfaceEntryLn.Description;
                            lrec_PFILns.Quantity := grec_InterfaceEntryLn.Quantity;
                            lrec_PFILns."Unit Of Measure" := InterfaceFrameworkMgt.GetISOCodeUnitOfMeasure(grec_InterfaceEntryLn."Unit of Measure Code");
                            lrec_PFILns."Unit Price" := grec_InterfaceEntryLn."Unit Amount";
                            lrec_PFILns.Amount := grec_InterfaceEntryLn."Line Amount";

                            //HEI.10>>
                            ////To fetch BO Number and the price from BO Price
                            //IF (lrec_PFILns."No." <> '') THEN BEGIN
                            //  lrec_Vendor.RESET;
                            //  lrec_Vendor.SETRANGE("Global Vendor Number",grec_IbecorlInterfaceSetup."IBECOR Vendor");
                            //  IF lrec_Vendor.FINDFIRST THEN;

                            //  lrec_PurchaseLine.RESET;
                            //  lrec_PurchaseLine.SETRANGE("Document Type",lrec_PurchaseLine."Document Type"::"Blanket Order");
                            //  lrec_PurchaseLine.SETRANGE("Buy-from Vendor No.",lrec_Vendor."No.");
                            //  lrec_PurchaseLine.SETRANGE("No.",lrec_PFILns."No.");
                            //  //HEI.03>>
                            //  lrec_PurchaseLine.SETRANGE("Block Line Ordering",lrec_PurchaseLine."Block Line Ordering"::" ");
                            //  //HEI.03<<
                            //  IF lrec_PurchaseLine.FINDLAST THEN BEGIN
                            //    lrec_PFILns."Blanket Order No" := lrec_PurchaseLine."Document No.";
                            //    lrec_PurchLnPrice.RESET;
                            //    lrec_PurchLnPrice.SETRANGE("Document Type",lrec_PurchaseLine."Document Type"::"Blanket Order");
                            //    lrec_PurchLnPrice.SETRANGE("Document No.",lrec_PurchaseLine."Document No.");
                            //    lrec_PurchLnPrice.SETRANGE("Document Line No.",lrec_PurchaseLine."Line No.");
                            //    //HEI.06>>
                            //    lrec_PurchLnPrice.SETFILTER("Starting Date",'<=%1',prec_PFIHeader."Document Date");
                            //    lrec_PurchLnPrice.SETFILTER("Ending Date",'>=%1',prec_PFIHeader."Document Date");
                            //    //HEI.06<<
                            //    lrec_PurchLnPrice.SETRANGE("Currency Code",prec_PFIHeader."Currency Code");//HEI.08
                            //    //HEI.02>>
                            //    //IF lrec_PurchLnPrice.FINDLAST THEN
                            //    //lrec_PFILns."Price from Blanket Order" := lrec_PurchLnPrice."Direct Unit Cost"
                            //    //ELSE
                            //    IF lrec_PurchLnPrice.FINDLAST THEN BEGIN
                            //      //HEI.03>>
                            //      lrec_PFILns."UOM of BO" := lrec_PurchLnPrice."Unit of Measure Code";
                            //      //HEI.03<<
                            //      IF lrecItem.GET(lrec_PFILns."No.") THEN;
                            //      IF (lrecItem."Base Unit of Measure" <> lrec_PFILns."Unit Of Measure") THEN BEGIN
                            //        IF (lrec_PurchLnPrice."Direct Unit Cost Multiplier" <> 0) THEN BEGIN
                            //          lrec_PFILns."Price from Blanket Order" := lrec_PurchLnPrice."Direct Cost Per Multiplier";
                            //          lrec_PFILns."Direct Multiplier of BO" := lrec_PurchLnPrice."Direct Unit Cost Multiplier";
                            //        //END;  //HEI.03
                            //        END ELSE BEGIN
                            //          lrec_PFILns."Price from Blanket Order" := lrec_PurchLnPrice."Direct Unit Cost";
                            //          lrec_PFILns."Direct Multiplier of BO" := 0;
                            //        END;  //HEI.03
                            //      END;
                            //    END ELSE
                            //    //HEI.02<<
                            //      lrec_PFILns."Price from Blanket Order" := 0;
                            //  END;
                            //END;
                            //HEI.10<<

                            if lrecShippingAgent.GET(grec_IbecorlInterfaceSetup."IBECOR Shipping Agent Code") then
                                lrec_PFILns."Shipping Agent Code" := lrecShippingAgent.Code;
                            lrec_ShippingAgentServices.RESET;
                            lrec_ShippingAgentServices.SETRANGE("Shipping Agent Code", grec_IbecorlInterfaceSetup."IBECOR Shipping Agent Code");
                            //lrec_ShippingAgentServices.SETRANGE("Shipping Charge No.", lrec_PFILns."CMG Code");BC Upgrade VAMSIU01
                            lrec_ShippingAgentServices.SETRANGE("Blanket Order No. FND", lrec_PFILns."Blanket Order No");  //HEI.13
                            if lrec_ShippingAgentServices.FINDFIRST then
                                lrec_PFILns."Shipping Agent Service Code" := lrec_ShippingAgentServices.Code;

                            if (p_InterfaceEntryHeader.Contact <> '') then begin
                                lrec_InterfaceLocationMatrix.RESET;
                                lrec_InterfaceLocationMatrix.SETRANGE("IBC Location Code", p_InterfaceEntryHeader.Contact);
                                if lrec_InterfaceLocationMatrix.FINDFIRST then
                                    lrec_PFILns."Location Code" := lrec_InterfaceLocationMatrix."Heilite Location Code";
                            end;

                            lrec_PFILns.INSERT;
                        until grec_InterfaceEntryLn.NEXT = 0;
                end;
            Action::Modify:
                begin
                end;
        end;
        //HEI.01<<
    end;

    local procedure ComparePFIHeader(p_PFIHdr: Record "PFI Header INT"; prec_InterfaceEntryHdr: Record "Interface Entry Header INT"): Boolean;
    var
        StoreLOEmail: Text;
        lrec_LogisticsOfficers: Record "Logistics Officers FND";
    begin
        //HEI.01>>
        if not (prec_InterfaceEntryHdr."E-Mail" <> '') then
            StoreLOEmail := prec_InterfaceEntryHdr."E-Mail"
        else begin
            lrec_LogisticsOfficers.RESET;
            lrec_LogisticsOfficers.SETRANGE("LO Code", prec_InterfaceEntryHdr."Transfer-from Code");
            if lrec_LogisticsOfficers.FINDFIRST then
                if (lrec_LogisticsOfficers."LO Name" <> '') then
                    StoreLOEmail := lrec_LogisticsOfficers."LO Email";
        end;

        case true of
            p_PFIHdr."Document Date" <> prec_InterfaceEntryHdr."Posting Date":
                exit(true);
            p_PFIHdr."PQ Number" <> prec_InterfaceEntryHdr."Your Reference":
                exit(true);
            p_PFIHdr."Payment Method Code" <> prec_InterfaceEntryHdr."Shipping Agent Code":
                exit(true);
            p_PFIHdr."Payment Terms Code" <> prec_InterfaceEntryHdr."Payment Terms Code":
                exit(true);
            p_PFIHdr."Shipment Method Code" <> prec_InterfaceEntryHdr."Driver Code":
                exit(true);
            p_PFIHdr."IBECOR Dossier No." <> prec_InterfaceEntryHdr."External Order No.":
                exit(true);
            p_PFIHdr."Logistics Officer" <> prec_InterfaceEntryHdr."Transfer-from Code":
                exit(true);
            p_PFIHdr."Logistics Officer Email" <> StoreLOEmail:
                exit(true);
            p_PFIHdr."Total Amount(Incl. VAT)" <> prec_InterfaceEntryHdr.Amount:
                exit(true);
            p_PFIHdr."Currency Code" <> prec_InterfaceEntryHdr."Currency Code":
                exit(true);
            p_PFIHdr."PFI Expiration Date" <> prec_InterfaceEntryHdr."Valid From":
                exit(true);
            p_PFIHdr.Description <> prec_InterfaceEntryHdr.Description:
                exit(true);
            p_PFIHdr."License Required" <> prec_InterfaceEntryHdr."Processing Flag":
                exit(true); //HEI.16
            p_PFIHdr."Credit Info Required" <> prec_InterfaceEntryHdr."Simulation Done":
                exit(true); //HEI.17
        end;
        //HEI.01<<
    end;

    local procedure AssignModifiedPFIHeader(prc_PFIHdr: Record "PFI Header INT"; prc_InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        lrec_LogisticsOfficers: Record "Logistics Officers FND";
    begin
        //HEI.01>>
        prc_PFIHdr."Document Date" := prc_InterfaceEntryHeader."Posting Date";
        prc_PFIHdr."PQ Number" := prc_InterfaceEntryHeader."Your Reference";
        if grec_paymentTermsCode.GET(prc_InterfaceEntryHeader."Payment Terms Code") then begin
            prc_PFIHdr."Payment Terms Code" := prc_InterfaceEntryHeader."Payment Terms Code";
            prc_PFIHdr."Payment Terms Description" := prc_InterfaceEntryHeader.Name;
        end;
        if grec_PaymentMethod.GET(prc_InterfaceEntryHeader."Shipping Agent Code") then begin
            prc_PFIHdr."Payment Method Code" := prc_InterfaceEntryHeader."Shipping Agent Code";
            prc_PFIHdr."Payment Method Description" := prc_InterfaceEntryHeader."External Requisition No.";
        end;
        if ShipmentMethod.GET(prc_InterfaceEntryHeader."Driver Code") then begin
            prc_PFIHdr."Shipment Method Code" := prc_InterfaceEntryHeader."Driver Code";
            prc_PFIHdr."Shipment Method Description" := prc_InterfaceEntryHeader.Address;
        end;
        if (prc_InterfaceEntryHeader."E-Mail" <> '') then
            prc_PFIHdr."Logistics Officer Email" := prc_InterfaceEntryHeader."E-Mail"
        else begin
            lrec_LogisticsOfficers.RESET;
            lrec_LogisticsOfficers.SETRANGE("LO Code", prc_InterfaceEntryHeader."Transfer-from Code");
            if lrec_LogisticsOfficers.FINDFIRST then
                if (lrec_LogisticsOfficers."LO Name" <> '') then
                    prc_PFIHdr."Logistics Officer Email" := lrec_LogisticsOfficers."LO Email";
        end;
        prc_PFIHdr."IBECOR Dossier No." := prc_InterfaceEntryHeader."External Order No.";
        prc_PFIHdr."Logistics Officer" := prc_InterfaceEntryHeader."Transfer-from Code";
        prc_PFIHdr."Logistics Officer Email" := prc_InterfaceEntryHeader."E-Mail";
        prc_PFIHdr."Total Amount(Incl. VAT)" := prc_InterfaceEntryHeader.Amount;
        prc_PFIHdr."Currency Code" := prc_InterfaceEntryHeader."Currency Code";
        prc_PFIHdr."PFI Expiration Date" := prc_InterfaceEntryHeader."Valid From";
        prc_PFIHdr.Description := prc_InterfaceEntryHeader.Description;
        prc_PFIHdr."License Required" := prc_InterfaceEntryHeader."Processing Flag"; //HEI.16
        prc_PFIHdr."Credit Info Required" := prc_InterfaceEntryHeader."Simulation Done"; //HEI.17
        prc_PFIHdr.MODIFY;
        //HEI.01<<
    end;

    local procedure ComparePFILines(p_PFILn: Record "PFI Lines FND"; prec_InterfaceEntryLine: Record "Interface Entry Line INT"): Boolean;
    begin
        //HEI.01>>
        case true of
            p_PFILn.Quantity <> prec_InterfaceEntryLine.Quantity:
                exit(true);
            p_PFILn.Description <> prec_InterfaceEntryLine.Description:
                exit(true);
            p_PFILn."Unit Price" <> prec_InterfaceEntryLine."Unit Amount":
                exit(true);
        end;
        //HEI.01<<
    end;

    local procedure ValidPFItobecreated(precIntrfcEntryHdr: Record "Interface Entry Header INT"): Boolean;
    var
        lrec_PurchaseLine: Record "Purchase Line";
        PFILineIsvalid: Boolean;
        lrecItem: Record Item;
        ItemCMGNo: Code[20];
        lrecDimValue: Record "Dimension Value";
        lTxt50001: Label 'There is no such item available with Global ID - %1.';
        lTxt50002: Label 'There is no such CMG available - %1.';
        lTxt50003: Label 'Both Global Item No. and CMG cannot be BLANK.';
        lTxt50004: Label 'No Blanket Order found for the PFI of CMG - %1.';
        DefaultCMG: Boolean;
        lrec_UnitofMeasure: Record "Unit of Measure";
        lrec_ItemUOM: Record "Item Unit of Measure";
        StoreUOM: Code[20];
        lrec_Vendor: Record Vendor;
        lrec_InterfaceLocMatrix: Record "Interface Location Matrix FND";
        PurchaseLinePrice: Record "Purchase Line Price FND";
        lTxt50005: Label 'The Item - %1 is blocked and cannot be used for PFI.';
        lTxt50006: Label 'The Vendor - %1 is blocked and cannot be used for PFI.';
        lTxt50007: Label 'The Payment Terms cannot be blank.';
        lTxt50008: Label 'No such Payment Terms Code - %1 available in HeiLite.';
        lTxt50009: Label 'The Shipment Method Code cannot be blank.';
        lTxt50010: Label 'No such Shipment Method Code - %1 available in HeiLite.';
    begin
        //HEI.01>>
        PFILineIsvalid := false;
        //HEI.15>>
        //Validation of Vendor block
        lrec_Vendor.RESET;
        lrec_Vendor.SETRANGE("Global Vendor Number FND", grec_IbecorlInterfaceSetup."IBECOR Vendor");
        if lrec_Vendor.FINDFIRST then begin
            if (lrec_Vendor.Blocked = lrec_Vendor.Blocked::All) then
                ERROR(lTxt50006, grec_IbecorlInterfaceSetup."IBECOR Vendor");
        end;
        //Validation of payment terms code
        if (precIntrfcEntryHdr."Payment Terms Code" <> '') then begin
            if not grec_paymentTermsCode.GET(precIntrfcEntryHdr."Payment Terms Code") then
                ERROR(lTxt50008, precIntrfcEntryHdr."Payment Terms Code");
        end else
            ERROR(lTxt50007);

        //Validation of shipment method code
        if (precIntrfcEntryHdr."Driver Code" <> '') then begin
            if not ShipmentMethod.GET(precIntrfcEntryHdr."Driver Code") then
                ERROR(lTxt50010, precIntrfcEntryHdr."Driver Code");
        end else
            ERROR(lTxt50009);
        //HEI.15<<

        grec_InterfaceEntryLn.RESET;
        grec_InterfaceEntryLn.SETRANGE("Header Entry No.", precIntrfcEntryHdr."Entry No.");
        if grec_InterfaceEntryLn.FINDSET then
            repeat
                DefaultCMG := false;
                ItemCMGNo := '';
                //Check Location Code available or not
                if (precIntrfcEntryHdr.Contact <> '') then begin
                    lrec_InterfaceLocMatrix.RESET;
                    lrec_InterfaceLocMatrix.SETRANGE("IBC Location Code", precIntrfcEntryHdr.Contact);
                    if not lrec_InterfaceLocMatrix.FINDFIRST then
                        ERROR(Text50009, lrec_InterfaceLocMatrix."IBC Location Code");
                end else
                    ERROR(Text50008, precIntrfcEntryHdr.Contact);
                //Check the Item UOM
                if (grec_InterfaceEntryLn."Unit of Measure Code" <> '') then begin
                    lrec_UnitofMeasure.RESET;
                    lrec_UnitofMeasure.SETRANGE("International Standard Code", grec_InterfaceEntryLn."Unit of Measure Code");
                    if not lrec_UnitofMeasure.FINDFIRST then
                        ERROR(Text50006, grec_InterfaceEntryLn."Unit of Measure Code")
                    else
                        StoreUOM := lrec_UnitofMeasure.Code;
                end;

                //Check the CMG, Item and their validity
                case grec_InterfaceEntryLn.Type of
                    grec_InterfaceEntryLn.Type::" ":
                        begin
                            DefaultCMG := true;
                        end;
                    grec_InterfaceEntryLn.Type::"G/L Account":
                        begin
                            DefaultCMG := true;//HEI.05
                        end;
                    grec_InterfaceEntryLn.Type::Item:
                        begin
                            if (grec_InterfaceEntryLn."Description 2" = '') and (grec_InterfaceEntryLn."CMG Code" = '') then begin
                                grec_IbecorlInterfaceSetup.TESTFIELD("Default CMG");
                                ItemCMGNo := grec_IbecorlInterfaceSetup."Default CMG";
                                DefaultCMG := true;
                            end;
                            if (grec_InterfaceEntryLn."Description 2" <> '') then begin
                                lrecItem.RESET;
                                lrecItem.SETRANGE("No. 2", grec_InterfaceEntryLn."Description 2");
                                if lrecItem.FINDFIRST then
                                    ItemCMGNo := lrecItem."No."
                                else
                                    ERROR(lTxt50001, grec_InterfaceEntryLn."Description 2");
                                //HEI.15>>
                                if lrecItem.Blocked then
                                    ERROR(lTxt50005, grec_InterfaceEntryLn."Description 2");
                                //HEI.15<<
                                if (ItemCMGNo <> '') then begin
                                    if not FindItemCategoryFilters(lrecItem) then
                                        ERROR(Text50004, ItemCMGNo);
                                end;
                                if not lrec_ItemUOM.GET(ItemCMGNo, StoreUOM) then
                                    ERROR(Text50007, ItemCMGNo, StoreUOM);
                            end;
                            if (grec_InterfaceEntryLn."Description 2" = '') and (grec_InterfaceEntryLn."CMG Code" <> '') then begin
                                lrecDimValue.RESET;
                                lrecDimValue.SETRANGE("Dimension Code", 'CMG');
                                lrecDimValue.SETRANGE(Code, grec_InterfaceEntryLn."CMG Code");
                                if not lrecDimValue.FINDFIRST then
                                    ERROR(lTxt50002, grec_InterfaceEntryLn."CMG Code")
                                //HEI.11>>
                                //ELSE
                                //  ItemCMGNo := lrecDimValue.Code;
                                else begin
                                    lrec_Vendor.RESET;
                                    lrec_Vendor.SETRANGE("Global Vendor Number FND", grec_IbecorlInterfaceSetup."IBECOR Vendor");
                                    if lrec_Vendor.FINDFIRST then;
                                    lrec_PurchaseLine.RESET;
                                    lrec_PurchaseLine.SETCURRENTKEY("Valid To FND");
                                    lrec_PurchaseLine.SETRANGE("Document Type", lrec_PurchaseLine."Document Type"::"Blanket Order");
                                    lrec_PurchaseLine.SETRANGE("Buy-from Vendor No.", lrec_Vendor."No.");
                                    lrec_PurchaseLine.SETRANGE("No.", grec_InterfaceEntryLn."CMG Code");
                                    lrec_PurchaseLine.SETRANGE("Block Line Ordering FND", lrec_PurchaseLine."Block Line Ordering FND"::" ");
                                    lrec_PurchaseLine.SETFILTER("Valid To FND", '>%1', precIntrfcEntryHdr."Posting Date");
                                    lrec_PurchaseLine.SETFILTER("Currency Code", precIntrfcEntryHdr."Currency Code");
                                    if not lrec_PurchaseLine.FINDLAST then
                                        ERROR(lTxt50004, grec_InterfaceEntryLn."CMG Code")
                                end;
                                //HEI.11<<
                            end;
                        end;
                end;
            //HEI.10>>
            //lrec_Vendor.RESET;
            //lrec_Vendor.SETRANGE("Global Vendor Number",grec_IbecorlInterfaceSetup."IBECOR Vendor");
            //IF lrec_Vendor.FINDFIRST THEN;
            //lrec_PurchaseLine.RESET;
            //lrec_PurchaseLine.SETCURRENTKEY("Valid To");
            //lrec_PurchaseLine.SETRANGE("Document Type",lrec_PurchaseLine."Document Type"::"Blanket Order");
            //lrec_PurchaseLine.SETRANGE("Buy-from Vendor No.",lrec_Vendor."No.");
            //lrec_PurchaseLine.SETRANGE("No.",ItemCMGNo);
            ////HEI.03>>
            //lrec_PurchaseLine.SETRANGE("Block Line Ordering",lrec_PurchaseLine."Block Line Ordering"::" ");
            ////HEI.03<<
            //lrec_PurchaseLine.SETFILTER("Valid To",'>%1',precIntrfcEntryHdr."Posting Date");
            //IF lrec_PurchaseLine.FINDLAST THEN BEGIN
            //  //HEI.08>>
            //  //PFILineIsvalid := TRUE;
            //  //Price check wrt currecncy
            //  IF (lrec_PurchaseLine.Type = lrec_PurchaseLine.Type::Item) THEN BEGIN
            //    PurchaseLinePrice.RESET;
            //    PurchaseLinePrice.SETRANGE("Document Type",PurchaseLinePrice."Document Type"::"Blanket Order");
            //    PurchaseLinePrice.SETRANGE("Document No.",lrec_PurchaseLine."Document No.");
            //    PurchaseLinePrice.SETRANGE("Document Line No.",lrec_PurchaseLine."Line No.");
            //    //HEI.09>>
            //    //PurchaseLinePrice.SETFILTER("Starting Date",'<=%1',precIntrfcEntryHdr."Expected Delivery Date");
            //    //PurchaseLinePrice.SETFILTER("Ending Date",'>=%1',precIntrfcEntryHdr."Expected Delivery Date");
            //    PurchaseLinePrice.SETFILTER("Starting Date",'<=%1',precIntrfcEntryHdr."Posting Date");
            //    PurchaseLinePrice.SETFILTER("Ending Date",'>=%1',precIntrfcEntryHdr."Posting Date");
            //    //HEI.09<<
            //    PurchaseLinePrice.SETRANGE("Currency Code",precIntrfcEntryHdr."Currency Code");
            //    IF PurchaseLinePrice.FINDLAST THEN
            //      PFILineIsvalid := TRUE
            //    ELSE
            //      //ERROR(Text50010,lrec_PurchaseLine."Document No.");//HEI.09
            //      ERROR(Text50010);//HEI.09
            // END ELSE
            //    PFILineIsvalid := TRUE;
            //  //HEI.08<<
            //END ELSE BEGIN
            //  IF NOT DefaultCMG THEN
            //    ERROR(lTxt50004,ItemCMGNo)
            //  ELSE
            //    PFILineIsvalid := TRUE;
            //END;
            //HEI.10<<
            until grec_InterfaceEntryLn.NEXT = 0;

        //HEI.10>>
        //IF PFILineIsvalid THEN
        exit(true);
        //HEI.10<<
        //HEI.01<<
    end;

    local procedure CancelPFI(precPFIHdr: Record "PFI Header INT");
    begin
        //HEI.01>>
        precPFIHdr."PFI Status" := precPFIHdr."PFI Status"::Cancelled;
        precPFIHdr.MODIFY;
        //HEI.01<<
    end;

    procedure FindItemCategoryFilters(var Item: Record Item): Boolean;
    begin
        //HEI.01>>
        Item.SETFILTER("Item Category Code", grec_IbecorlInterfaceSetup."IBC Item Category");
        if Item.FINDFIRST then
            exit(true);
        //HEI.01<<
    end;

    local procedure PFIExpiredValidation(PFIHeader: Record "PFI Header INT"; InterfaceEntryHeader: Record "Interface Entry Header INT"): Boolean;
    begin
        //HEI.18>>
        PFIHeader.SETAUTOCALCFIELDS("PO Created");

        //IF NOT (PFIHeader."PFI Status" <> PFIHeader."PFI Status"::Expired) THEN //HEI.19
        if PFIHeader."PFI Status" <> PFIHeader."PFI Status"::Expired then //HEI.19
            exit(false);

        if PFIHeader."PO Created" then
            exit(false);

        if InterfaceEntryHeader."Valid From" < WORKDATE then
            exit(false);

        if PFIHeader."PFI Expiration Date" >= InterfaceEntryHeader."Valid From" then
            exit(false);

        exit(true);
        //HEI.18<<
    end;

    //event ResponseXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXmlDocument(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;
}

