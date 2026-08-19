namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using Microsoft.Inventory.Transfer;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Journal;
using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Posting;
using Microsoft.Inventory.Tracking;

codeunit 58107 "IC Transfer Order Process"
{
    // HEI.01 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Codeunit created for IC Transfer Order Interface
    // HEI.02 FDD-HT1304 IBM NASTAA02 21.10.2020 # IC Transfer Order Automation
    //   # Shipping information should not be copied from Source to Target
    // HEI.03 INC3241649 CHG2092633 IBM NASTAA02 29.12.2020 # IC Transfer UOM issues and automatic duplicated entries"
    //   # Added extra filter on Reservation Entries on 'ProcessPositiveStockAdjustment' function
    //   # Code changed on function 'CreateTransferLine' to use Line No. from Sending Company
    // HEI.04 INC3268719 CHG2094201 IBM NASTAA02 14.01.2020 # Posting done in the receiving company are wrong
    //   # Updated the value of 'Qty. Per Unit of Measure' and 'Quantity (Base)' in the Reservation Entry table
    //   # Unit Cost will take the value of the Unit Amount in the Item Journal
    //   # Used UoM Code from XML instead of Inventory Unit of Measure
    // HEI.05 CHG2131272 IBM.LS      04.01.2022
    //   # Added Code for Reporting Type
    // HEI.06 CHG2143788/INC3938587 IBM SURYAS01 "DRC IC Transfer Order Interface Issue"
    //   #Locking table Transfer header & Transfer Line suggested by Mimikos
    // HEI.07 INC4083000 - CHG2156647 IBM NASTAA02 03.05.2022 # NAS Service consuming high memory
    //   # Clear variables after Webservice call
    // HEI.08 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables

    // BC Upgrade SHUKLP03 >>
    // Nav old id - 50132
    // On procedure CreateTransferLine() blocked DIT field "Unit Amount".
    // On procedure CreateReservationEntry() Blocked DIT fields "Bin Code", "Strength Spec. Code" and "Strength Spec. Value" and some part of code blocked because dependency on DIT field "Expiration Date".
    // Blocked Dotnet variables of local procedure CreateTransferOrder(). 
    // LOCAL procedure ProcessPositiveStockAdjustment() blocked DIT field "Item Charge Value" and some part of code blocked because dependency on DIT fields "Strength Spec. Code", "Strength Spec. Value".
    // LOCAL procedure ParseRequestXML() code is modified replaced dotNet variables with BC variables. 
    // BC Upgrade SHUKLP03 <<

    TableNo = "Transfer Ord. IC Log Entry DTW";

    var
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        CurrentElementName: Text;
        FromCompany: Text;
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
        PositiveAdjustmentPosted: Boolean;
        LastErrorMsg: Text;
        BPG: Code[10];
        NewLot: Boolean;

    trigger OnRun()
    var
    begin
        CreateTransferOrder(Rec);
    end;

    // BC Upgrade SHUKLP03 >> Blocked procedure ParseRequestXML() and created same name new procedure and replaced dotnet variables with BC variables.
    // LOCAL procedure ParseRequestXML(CurrentXMLNode: DotNet "System.Xml.XmlNode")
    // begin
    //     CurrentXMLNode2 := CurrentXMLNode;
    //     CASE FORMAT(CurrentXMLNode2.NodeType) OF
    //         'Element': // Element
    //             BEGIN
    //                 CurrentElementName := CurrentXMLNode2.Name;

    //                 //Create Transfer Header before parsing the first Transfer Line or Header Dimension
    //                 IF ((CurrentElementName = 'TransferOrderLine') OR
    //                     (CurrentElementName = 'HeaderDimensions')) AND
    //                     ((DimensionCode = '') AND (DimensionValueCode = ''))
    //                 THEN
    //                     IF LineNo = 0 THEN
    //                         CreateTransferHeader
    //                     ELSE BEGIN
    //                         CLEAR(ItemNo);
    //                         CLEAR(TransferQuantity);
    //                         CLEAR(UoMCode);
    //                         CLEAR(QtyPerUoM);
    //                         CLEAR(UnitAmount);
    //                         CLEAR(BinCode);
    //                     END;

    //                 //Create Header Dimension Set Entry
    //                 IF ((CurrentElementName = 'TransferOrderLine') OR
    //                     (CurrentElementName = 'HeaderDimensions')) AND
    //                     ((DimensionCode <> '') AND (DimensionValueCode <> ''))
    //                 THEN
    //                     CreateDimensionSetEntry(TRUE);

    //                 //Create Transfer Line before parsing the first Tracking Spec Line
    //                 IF (((CurrentElementName = 'TrackingSpecification') AND (LineNo = 0)) OR
    //                     ((CurrentElementName = 'TrackingSpecification') AND (LineNo <> ItemLineNo))) OR
    //                     (((CurrentElementName = 'LineDimensions') AND (LineNo = 0)) OR
    //                     ((CurrentElementName = 'LineDimensions') AND (LineNo <> ItemLineNo)))
    //                 THEN
    //                     CreateTransferLine;

    //                 //Create Reservation Entries before last Attribute in Tracking Spec Line or before Line Dimension
    //                 IF CurrentElementName = 'StrengthSpecValue' THEN
    //                     CreateTrackingSpecification;

    //                 //Create Positive Adjustment
    //                 IF (CurrentElementName = 'LineDimensions') AND (ItemNo <> '') AND NOT PositiveAdjustmentPosted THEN
    //                     ProcessPositiveStockAdjustment;

    //                 // If the element has attributes, then browse through those.
    //                 TempXMLAttributeList := CurrentXMLNode2.Attributes;
    //                 FOR k := 0 TO TempXMLAttributeList.Count - 1 DO
    //                     ParseRequestXML(TempXMLAttributeList.Item(k));

    //                 // Process Child nodes
    //                 TempXMLNodeList := CurrentXMLNode2.ChildNodes;
    //                 FOR j := 0 TO TempXMLNodeList.Count - 1 DO
    //                     ParseRequestXML(TempXMLNodeList.Item(j));
    //             END;

    //         'Text': //Values
    //             BEGIN
    //                 IF CurrentElementName = 'FromCompany' THEN
    //                     FromCompany := CurrentXMLNode2.Value;

    //                 IF CurrentElementName = 'TransferOrderNo' THEN
    //                     FromTransferOrderNo := CurrentXMLNode2.Value;

    //                 IF CurrentElementName = 'FromLocation' THEN
    //                     FromLocation := CurrentXMLNode2.Value;

    //                 IF CurrentElementName = 'ToLocation' THEN
    //                     ToLocation := CurrentXMLNode2.Value;

    //                 IF CurrentElementName = 'PostingDate' THEN
    //                     EVALUATE(PostingDate, CurrentXMLNode2.Value);

    //                 IF CurrentElementName = 'ICDocument' THEN
    //                     ICDocument := TRUE;

    //                 IF CurrentElementName = 'TransferReceiptNo' THEN
    //                     TransferRcptNo := CurrentXMLNode2.Value;

    //                 //IF CurrentElementName = 'TransferRcptPostingDate' THEN
    //                 //EVALUATE(TransferRcptPostingDate,CurrentXMLNode2.Value);

    //                 IF CurrentElementName = 'In-Transit' THEN
    //                     InTransitCode := CurrentXMLNode2.Value;

    //                 //HEI.02>>
    //                 //IF CurrentElementName = 'Route' THEN
    //                 //RouteCode := CurrentXMLNode2.Value;

    //                 //IF CurrentElementName = 'ShipAgCode' THEN
    //                 //ShipAgCode := CurrentXMLNode2.Value;

    //                 //IF CurrentElementName = 'ShipAgServCode' THEN
    //                 //ShipAgServCode := CurrentXMLNode2.Value;

    //                 //IF CurrentElementName = 'Truck' THEN
    //                 //TruckCode := CurrentXMLNode2.Value;

    //                 //IF CurrentElementName = 'Driver' THEN
    //                 //DriverCode := CurrentXMLNode2.Value;

    //                 //IF CurrentElementName = 'Driver2' THEN
    //                 //DriverCode2 := CurrentXMLNode2.Value;
    //                 //HEI.02<<

    //                 IF CurrentElementName = 'BPG' THEN
    //                     BPG := CurrentXMLNode2.Value;

    //                 //Header Dimensions
    //                 IF CurrentElementName = 'DimensionCode' THEN
    //                     DimensionCode := CurrentXMLNode2.Value;

    //                 IF CurrentElementName = 'DimensionValue' THEN
    //                     DimensionValueCode := CurrentXMLNode2.Value;

    //                 //Transfer Line
    //                 IF CurrentElementName = 'SourceLineNo' THEN
    //                     EVALUATE(ItemLineNo, CurrentXMLNode2.Value);

    //                 IF CurrentElementName = 'ItemNo' THEN
    //                     ItemNo := CurrentXMLNode2.Value;

    //                 IF CurrentElementName = 'Quantity' THEN
    //                     EVALUATE(TransferQuantity, CurrentXMLNode2.Value);

    //                 IF CurrentElementName = 'UoMCode' THEN
    //                     UoMCode := CurrentXMLNode2.Value;

    //                 IF CurrentElementName = 'UnitAmount' THEN
    //                     EVALUATE(UnitAmount, CurrentXMLNode2.Value);

    //                 IF CurrentElementName = 'BinCode' THEN
    //                     BinCode := CurrentXMLNode2.Value;

    //                 //Tracking Specification
    //                 IF CurrentElementName = 'LotNo' THEN
    //                     LotNo := CurrentXMLNode2.Value;

    //                 IF CurrentElementName = 'ExpirationDate' THEN
    //                     EVALUATE(LotExpirationDate, CurrentXMLNode2.Value);

    //                 IF CurrentElementName = 'BaseQty' THEN
    //                     EVALUATE(LotBaseQty, CurrentXMLNode2.Value);

    //                 IF CurrentElementName = 'StrengthSpecCode' THEN
    //                     LotStrengthSpecCode := CurrentXMLNode2.Value;

    //                 IF CurrentElementName = 'StrengthSpecValue' THEN
    //                     EVALUATE(LotStrengthSpecValue, CurrentXMLNode2.Value);

    //                 //Line Dimensions
    //                 IF CurrentElementName = 'LineDimensionCode' THEN
    //                     LineDimensionCode := CurrentXMLNode2.Value;

    //                 IF CurrentElementName = 'LineDimensionValue' THEN BEGIN
    //                     LineDimensionValue := CurrentXMLNode2.Value;

    //                     //Create Line Dimension Set Entry
    //                     IF (LineDimensionCode <> '') AND (LineDimensionValue <> '') THEN
    //                         CreateDimensionSetEntry(FALSE);
    //                 END;
    //             END;
    //     END;

    //     //HEI.07>>
    //     CLEAR(TempXMLNodeList);
    //     CLEAR(TempXMLAttributeList);
    //     CLEAR(CurrentXMLNode2);
    //     //HEI.07<<
    // end;
    // BC Upgrade SHUKLP03 << Blocked procedure ParseRequestXML() and created same name new procedure and replaced dotnet variables with BC variables.

    // BC Upgrade SHUKLP03 >> Created procedure ParseRequestXML().
    LOCAL procedure ParseRequestXML(CurrentXMLNode: XmlNode)
    var
        TempXMLNodeList: XmlNodeList;
        TempXMLAttributeList: XmlAttributeCollection;
        XmlAttr: XmlAttribute;
        XmlElem: XmlElement;
        XmlTxt: XmlText;
        ChildNode: XmlNode;
        j: Integer;
        k: Integer;
        CurrentXMLNode2: XmlNode;
    begin
        if CurrentXMLNode.IsXmlElement() then begin
            XmlElem := CurrentXMLNode.AsXmlElement();
            CurrentElementName := XmlElem.Name();

            //Create Transfer Header before parsing the first Transfer Line or Header Dimension
            IF ((CurrentElementName = 'TransferOrderLine') OR
               (CurrentElementName = 'HeaderDimensions')) AND
               ((DimensionCode = '') AND (DimensionValueCode = ''))
            THEN
                IF LineNo = 0 THEN
                    CreateTransferHeader
                ELSE BEGIN
                    CLEAR(ItemNo);
                    CLEAR(TransferQuantity);
                    CLEAR(UoMCode);
                    CLEAR(QtyPerUoM);
                    CLEAR(UnitAmount);
                    CLEAR(BinCode);
                END;

            //Create Header Dimension Set Entry
            IF ((CurrentElementName = 'TransferOrderLine') OR
               (CurrentElementName = 'HeaderDimensions')) AND
               ((DimensionCode <> '') AND (DimensionValueCode <> ''))
            THEN
                CreateDimensionSetEntry(TRUE);

            //Create Transfer Line before parsing the first Tracking Spec Line
            IF (((CurrentElementName = 'TrackingSpecification') AND (LineNo = 0)) OR
               ((CurrentElementName = 'TrackingSpecification') AND (LineNo <> ItemLineNo))) OR
               (((CurrentElementName = 'LineDimensions') AND (LineNo = 0)) OR
               ((CurrentElementName = 'LineDimensions') AND (LineNo <> ItemLineNo)))
            THEN
                CreateTransferLine;

            //Create Reservation Entries before last Attribute in Tracking Spec Line or before Line Dimension
            IF CurrentElementName = 'StrengthSpecValue' THEN
                CreateTrackingSpecification;

            //Create Positive Adjustment
            IF (CurrentElementName = 'LineDimensions') AND (ItemNo <> '') AND NOT PositiveAdjustmentPosted THEN
                ProcessPositiveStockAdjustment;

            TempXMLAttributeList := XmlElem.Attributes;
            FOR k := 0 TO TempXMLAttributeList.Count - 1 DO begin
                if XmlAttr.Name() = CurrentElementName then
                    ParseRequestXML(XmlAttr.AsXmlNode());
            end;

            XmlElem.SelectNodes('*', TempXMLNodeList);
            FOR j := 0 TO TempXMLNodeList.Count - 1 DO begin
                if TempXMLNodeList.Get(j, ChildNode) then
                    ParseRequestXML(ChildNode);
            end;

        end else if CurrentXMLNode.IsXmlText() then begin
            XmlTxt := CurrentXMLNode.AsXmlText();

            IF CurrentElementName = 'FromCompany' THEN
                FromCompany := XmlTxt.Value;

            IF CurrentElementName = 'TransferOrderNo' THEN
                FromTransferOrderNo := XmlTxt.Value;

            IF CurrentElementName = 'FromLocation' THEN
                FromLocation := XmlTxt.Value;

            IF CurrentElementName = 'ToLocation' THEN
                ToLocation := XmlTxt.Value;

            IF CurrentElementName = 'PostingDate' THEN
                EVALUATE(PostingDate, XmlTxt.Value);

            IF CurrentElementName = 'ICDocument' THEN
                ICDocument := TRUE;

            IF CurrentElementName = 'TransferReceiptNo' THEN
                TransferRcptNo := XmlTxt.Value;

            //IF CurrentElementName = 'TransferRcptPostingDate' THEN
            //EVALUATE(TransferRcptPostingDate,CurrentXMLNode2.Value);

            IF CurrentElementName = 'In-Transit' THEN
                InTransitCode := XmlTxt.Value;

            //HEI.02>>
            //IF CurrentElementName = 'Route' THEN
            //RouteCode := CurrentXMLNode2.Value;

            //IF CurrentElementName = 'ShipAgCode' THEN
            //ShipAgCode := CurrentXMLNode2.Value;

            //IF CurrentElementName = 'ShipAgServCode' THEN
            //ShipAgServCode := CurrentXMLNode2.Value;

            //IF CurrentElementName = 'Truck' THEN
            //TruckCode := CurrentXMLNode2.Value;

            //IF CurrentElementName = 'Driver' THEN
            //DriverCode := CurrentXMLNode2.Value;

            //IF CurrentElementName = 'Driver2' THEN
            //DriverCode2 := CurrentXMLNode2.Value;
            //HEI.02<<

            IF CurrentElementName = 'BPG' THEN
                BPG := XmlTxt.Value;

            //Header Dimensions
            IF CurrentElementName = 'DimensionCode' THEN
                DimensionCode := XmlTxt.Value;

            IF CurrentElementName = 'DimensionValue' THEN
                DimensionValueCode := XmlTxt.Value;

            //Transfer Line
            IF CurrentElementName = 'SourceLineNo' THEN
                EVALUATE(ItemLineNo, XmlTxt.Value);

            IF CurrentElementName = 'ItemNo' THEN
                ItemNo := XmlTxt.Value;

            IF CurrentElementName = 'Quantity' THEN
                EVALUATE(TransferQuantity, XmlTxt.Value);

            IF CurrentElementName = 'UoMCode' THEN
                UoMCode := XmlTxt.Value;

            IF CurrentElementName = 'UnitAmount' THEN
                EVALUATE(UnitAmount, XmlTxt.Value);

            IF CurrentElementName = 'BinCode' THEN
                BinCode := XmlTxt.Value;

            //Tracking Specification
            IF CurrentElementName = 'LotNo' THEN
                LotNo := XmlTxt.Value;

            IF CurrentElementName = 'ExpirationDate' THEN
                EVALUATE(LotExpirationDate, XmlTxt.Value);

            IF CurrentElementName = 'BaseQty' THEN
                EVALUATE(LotBaseQty, XmlTxt.Value);

            IF CurrentElementName = 'StrengthSpecCode' THEN
                LotStrengthSpecCode := XmlTxt.Value;

            IF CurrentElementName = 'StrengthSpecValue' THEN
                EVALUATE(LotStrengthSpecValue, XmlTxt.Value);

            //Line Dimensions
            IF CurrentElementName = 'LineDimensionCode' THEN
                LineDimensionCode := XmlTxt.Value;

            IF CurrentElementName = 'LineDimensionValue' THEN BEGIN
                LineDimensionValue := XmlTxt.Value;

                //Create Line Dimension Set Entry
                IF (LineDimensionCode <> '') AND (LineDimensionValue <> '') THEN
                    CreateDimensionSetEntry(FALSE);
            END;
        END;

        //HEI.07>>
        CLEAR(TempXMLNodeList);
        CLEAR(TempXMLAttributeList);
        CLEAR(CurrentXMLNode2);
        //HEI.07<<
    end;
    // BC Upgrade SHUKLP03 << Created procedure ParseRequestXML().


    LOCAL procedure CreateTransferOrder(VAR TransferOrderICLogEntry: Record "Transfer Ord. IC Log Entry DTW")
    var
        // BC Upgrade SHUKLP03 >> Blocked DotNet variables and replaced with BC variables.	
        // XmlDoc: DotNet	System.Xml.XmlDocument.'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
        // XMLNodeList: DotNet	System.Xml.XmlNodeList.'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
        // DOMNode: DotNet	System.Xml.XmlNode.'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	       	
        XmlDoc: XmlDocument;
        XMLNodeList: XmlNodeList;
        DOMNode: XmlNode;
        // BC Upgrade SHUKLP03 << Blocked Nav DotNet variables and replaced with BC variables.	

        TransferHeader: Record "Transfer Header";
        TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
        InputStream: InStream;
        i: Integer;
    begin
        TransferOrderICLogEntry.CALCFIELDS("Request File");
        TransferOrderICLogEntry."Request File".CREATEINSTREAM(InputStream);

        // BC Upgrade SHUKLP03 >> Blocked Dotnet code and replaced with BC saas variables
        // XmlDoc := XmlDoc.XmlDocument;
        // XmlDoc.Load(InputStream);
        // XMLNodeList := XmlDoc.ChildNodes;

        // FOR i := 0 TO XMLNodeList.Count - 1 DO BEGIN
        //     DOMNode := XMLNodeList.Item(i);
        //     ParseRequestXML(DOMNode);
        // END;

        XmlDoc := XmlDocument.Create();
        XmlDoc.Add(InputStream);
        XMLNodeList := XmlDoc.GetChildNodes();
        for i := 0 to XMLNodeList.Count() - 1 do begin
            if XMLNodeList.Get(i, DOMNode) then
                ParseRequestXML(DOMNode);
        end;

        // BC Upgrade SHUKLP03 << Blocked Dotnet code and replaced with BC saas variables


        TransferOrderICLogEntry."Created Document No." := CreatedTransferOrderNo;
        TransferOrderICLogEntry.MODIFY();

        //Post Transfer Order - Shipment
        TransferHeader.LOCKTABLE(TRUE); //HEI.06
        TransferHeader.GET(TransferOrderICLogEntry."Created Document No.");
        TransferPostShipment.RUN(TransferHeader);

        //HEI.07>>
        // BC Upgrade SHUKLP03 >> Blocked DotNet code.	
        // CLEAR(XmlDoc);
        // CLEAR(XMLNodeList);
        // CLEAR(DOMNode);
        // BC Upgrade SHUKLP03 << Blocked DotNet code.	
        //HEI.07<<
        CLEAR(InputStream); //HEI.08
    end;

    LOCAL procedure CreateTransferHeader()
    var
        TransferHeader: Record "Transfer Header";
    begin
        TransferHeader.INIT();
        TransferHeader.INSERT(TRUE);
        CreatedTransferOrderNo := TransferHeader."No.";

        TransferHeader.VALIDATE("Transfer-from Code", FromLocation);
        TransferHeader.VALIDATE("Transfer-to Code", ToLocation);
        IF TransferHeader."In-Transit Code" = '' THEN
            TransferHeader.VALIDATE("In-Transit Code", InTransitCode);

        //HEI.02>>
        // IF (TransferHeader.Route = '') AND (RouteCode <> '') THEN
        //  TransferHeader.VALIDATE(Route,RouteCode);
        // IF (TransferHeader."Shipping Agent Code" = '') AND (ShipAgCode <> '') THEN
        //  TransferHeader.VALIDATE("Shipping Agent Code",ShipAgCode);
        // IF (TransferHeader."Shipping Agent Service Code" = '') AND (ShipAgServCode <> '') THEN
        //  TransferHeader.VALIDATE("Shipping Agent Service Code",ShipAgServCode);
        // IF (TransferHeader."Truck Code" = '') AND (TruckCode <> '') THEN
        //  TransferHeader.VALIDATE("Truck Code",TruckCode);
        // IF (TransferHeader."Driver Code" = '') AND (DriverCode <> '') THEN
        //  TransferHeader.VALIDATE("Driver Code",DriverCode);
        // IF (TransferHeader."Driver 2 Code" = '') AND (DriverCode2 <> '') THEN
        //  TransferHeader.VALIDATE("Driver 2 Code",DriverCode2);
        //HEI.02<<

        //TransferHeader.VALIDATE("Posting Date",WORKDATE);
        TransferHeader.VALIDATE("Posting Date", PostingDate);
        TransferHeader.VALIDATE("IC Document FND", ICDocument);
        TransferHeader.VALIDATE("External Document No.", FromTransferOrderNo);
        TransferHeader.MODIFY();

        DimensionSetEntryNo := TransferHeader."Dimension Set ID";
    end;

    LOCAL procedure CreateTransferLine()
    var
        CurrentLineNo: Integer;
        TransferLine: Record "Transfer Line";
    begin
        TransferLine.INIT();
        TransferLine.VALIDATE("Document No.", CreatedTransferOrderNo);

        //HEI.03>>
        // IF LineNo = 0 THEN
        //  CurrentLineNo := 10000
        // ELSE
        //  CurrentLineNo := LineNo + 10000;
        // LineNo := CurrentLineNo;

        //TransferLine.VALIDATE("Line No.",CurrentLineNo);

        LineNo := ItemLineNo;
        TransferLine.VALIDATE("Line No.", LineNo);
        //HEI.03<<

        TransferLine.INSERT(TRUE);
        TransferLine.VALIDATE("Item No.", ItemNo);
        TransferLine.VALIDATE(Quantity, TransferQuantity);
        TransferLine.VALIDATE("Unit of Measure Code", UoMCode);
        //TransferLine.VALIDATE("Transfer-To Bin Code",BinCode);
        //TransferLine.VALIDATE("Unit Amount", UnitAmount);  // BC Upgrade SHUKLP03 << Blocked DIT field "Unit Amount".
        TransferLine.MODIFY();

        QtyPerUoM := TransferLine."Qty. per Unit of Measure";
        LineDimensionSetEntryNo := TransferLine."Dimension Set ID";
        PositiveAdjustmentPosted := FALSE;
    end;

    LOCAL procedure CreateTrackingSpecification()
    var
        LotNoInformation: Record "Lot No. Information";
    begin
        //Shipment
        LotNoInformation.RESET();
        LotNoInformation.SETRANGE("Lot No.", LotNo);
        LotNoInformation.SETRANGE("Item No.", ItemNo);
        NewLot := NOT LotNoInformation.FINDFIRST();

        CreateReservationEntry(LotBaseQty, QtyPerUoM, DATABASE::"Transfer Line", 0, CreatedTransferOrderNo, '', LineNo, ItemNo, FromLocation,
          '', LotNo, LotExpirationDate, LotStrengthSpecCode, LotStrengthSpecValue);

        //Receipt
        CreateReservationEntry(-LotBaseQty, QtyPerUoM, DATABASE::"Transfer Line", 1, CreatedTransferOrderNo, '', LineNo, ItemNo, ToLocation,
          '', LotNo, LotExpirationDate, LotStrengthSpecCode, LotStrengthSpecValue);

        CLEAR(LotNo);
        CLEAR(LotBaseQty);
        CLEAR(LotExpirationDate);
        CLEAR(LotStrengthSpecCode);
        CLEAR(LotStrengthSpecValue);
    end;

    LOCAL procedure CreateDimensionSetEntry(IsHeaderDimension: Boolean)
    var
        DimensionManagement: Codeunit DimensionManagement;
        TempDimensionSetEntry: Record "Dimension Set Entry";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        Dimension: Record Dimension;
        DimensionValue: Record "Dimension Value";
        ExistingDimension: Boolean;
    begin
        //CLEAR(TempDimensionSetEntry);
        IF IsHeaderDimension THEN
            DimensionManagement.GetDimensionSet(TempDimensionSetEntry, DimensionSetEntryNo)
        ELSE
            DimensionManagement.GetDimensionSet(TempDimensionSetEntry, LineDimensionSetEntryNo);

        CLEAR(ExistingDimension);
        Dimension.RESET();
        DimensionValue.RESET();
        IF DimensionCode <> '' THEN
            IF Dimension.GET(DimensionCode) THEN
                IF DimensionValueCode <> '' THEN
                    IF DimensionValue.GET(DimensionCode, DimensionValueCode) THEN
                        ExistingDimension := TRUE;

        Dimension.RESET();
        DimensionValue.RESET();
        IF LineDimensionCode <> '' THEN
            IF Dimension.GET(LineDimensionCode) THEN
                IF LineDimensionValue <> '' THEN
                    IF DimensionValue.GET(LineDimensionCode, LineDimensionValue) THEN
                        ExistingDimension := TRUE;

        IF ExistingDimension THEN BEGIN

            IF ((DimensionCode <> '') AND (DimensionValueCode <> '')) OR
               ((LineDimensionCode <> '') AND (LineDimensionValue <> ''))
            THEN BEGIN
                //Replace existing Dimension
                IF IsHeaderDimension THEN
                    TempDimensionSetEntry.SETRANGE("Dimension Code", DimensionCode)
                ELSE
                    TempDimensionSetEntry.SETRANGE("Dimension Code", LineDimensionCode);
                IF TempDimensionSetEntry.FINDFIRST() THEN
                    TempDimensionSetEntry.DELETE();

                //Insert new Dimension Value
                TempDimensionSetEntry.INIT();
                IF IsHeaderDimension THEN BEGIN
                    TempDimensionSetEntry."Dimension Code" := DimensionCode;
                    TempDimensionSetEntry."Dimension Value Code" := DimensionValueCode;
                END ELSE BEGIN
                    TempDimensionSetEntry."Dimension Code" := LineDimensionCode;
                    TempDimensionSetEntry."Dimension Value Code" := LineDimensionValue;
                END;
                IF TempDimensionSetEntry.INSERT(TRUE) THEN;
            END;

            CLEAR(DimensionCode);
            CLEAR(DimensionValueCode);
            CLEAR(LineDimensionCode);
            CLEAR(LineDimensionValue);

            IF IsHeaderDimension THEN
                NewDimensionSetEntryNo := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry)
            ELSE
                NewLineDimensionSetEntryNo := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);

            IF IsHeaderDimension THEN BEGIN
                IF DimensionSetEntryNo <> NewDimensionSetEntryNo THEN BEGIN
                    DimensionSetEntryNo := NewDimensionSetEntryNo;
                    TransferHeader.GET(CreatedTransferOrderNo);
                    TransferHeader.VALIDATE("Dimension Set ID", NewDimensionSetEntryNo);
                    TransferHeader.MODIFY();
                END;
            END ELSE
                IF LineDimensionSetEntryNo <> NewLineDimensionSetEntryNo THEN BEGIN
                    LineDimensionSetEntryNo := NewLineDimensionSetEntryNo;
                    TransferLine.GET(CreatedTransferOrderNo, LineNo);
                    TransferLine.VALIDATE("Dimension Set ID", NewLineDimensionSetEntryNo);
                    TransferLine.MODIFY();
                END;
        END;
    end;

    LOCAL procedure ProcessPositiveStockAdjustment()
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine2: Record "Item Journal Line";
        ItemJournalLine3: Record "Item Journal Line";
        ItemJournalBatch: Record "Item Journal Batch";
        LineNo2: Integer;
        TransferHeader: Record "Transfer Header";
        ReservationEntry: Record "Reservation Entry";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        Item: Record Item;
    begin
        GeneralInterfaceSetup.GET;
        ItemJournalBatch.GET(GeneralInterfaceSetup."IC Item Jnl Template", GeneralInterfaceSetup."IC Item Jnl Batch");

        IF TransferHeader.GET(CreatedTransferOrderNo) THEN
            CLEAR(ItemJournalLine);

        //Delete existing empty lines
        ItemJournalLine3.SETRANGE("Journal Template Name", GeneralInterfaceSetup."IC Item Jnl Template");
        ItemJournalLine3.SETRANGE("Journal Batch Name", GeneralInterfaceSetup."IC Item Jnl Batch");
        ItemJournalLine3.SETRANGE("Item No.", '');
        IF ItemJournalLine3.FINDFIRST() THEN
            ItemJournalLine3.DELETEALL();

        ItemJournalLine.INIT();
        ItemJournalLine.VALIDATE("Journal Template Name", GeneralInterfaceSetup."IC Item Jnl Template");
        ItemJournalLine.VALIDATE("Journal Batch Name", GeneralInterfaceSetup."IC Item Jnl Batch");

        ItemJournalLine2.RESET();
        ItemJournalLine2.SETRANGE("Journal Template Name", GeneralInterfaceSetup."IC Item Jnl Template");
        ItemJournalLine2.SETRANGE("Journal Batch Name", GeneralInterfaceSetup."IC Item Jnl Batch");
        IF ItemJournalLine2.FINDLAST() THEN
            LineNo2 := ItemJournalLine2."Line No." + 10000
        ELSE
            LineNo2 := 10000;
        ItemJournalLine.VALIDATE("Line No.", LineNo2);
        ItemJournalLine.INSERT(TRUE);
        ItemJournalLine.VALIDATE("Gen. Bus. Posting Group", BPG);
        ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::Purchase);
        //ItemJournalLine.VALIDATE("Posting Date",WORKDATE);
        ItemJournalLine.VALIDATE("Posting Date", PostingDate);
        ItemJournalLine.VALIDATE("Document No.", CreatedTransferOrderNo);
        ItemJournalLine.VALIDATE("Item No.", ItemNo);
        ItemJournalLine.VALIDATE("Location Code", TransferHeader."Transfer-from Code");
        ItemJournalLine.VALIDATE(Quantity, TransferQuantity);
        ItemJournalLine.VALIDATE("Unit of Measure Code", UoMCode);

        Item.GET(ItemNo);
        //HEI.04>>
        //IF Item."Base Unit of Measure" <> Item."Inventory Unit of Measure" THEN BEGIN
        IF Item."Base Unit of Measure" <> UoMCode THEN BEGIN
            //HEI.04<<
            ItemUnitofMeasure.RESET();
            ItemUnitofMeasure.SETRANGE("Item No.", ItemNo);
            ItemUnitofMeasure.SETRANGE(Code, UoMCode);
            IF ItemUnitofMeasure.FINDFIRST() THEN
                UnitAmount := UnitAmount * ItemUnitofMeasure."Qty. per Unit of Measure";
        END;

        ItemJournalLine.VALIDATE("Unit Amount", UnitAmount);
        //HEI.04>>
        ItemJournalLine."Unit Cost" := UnitAmount;
        //ItemJournalLine."Item Charge Value" := UnitAmount; // BC Upgrade SHUKLP03 << Blocked DIT field "Item Charge Value".
        //HEI.04<<

        //HEI.05>>
        ItemJournalLine."Reporting Type FND" := ItemJournalLine."Reporting Type FND"::"Interregional Transfer Inbound";
        //HEI.05<<

        // BC Upgrade SHUKLP03 >> Blocked code because dependency on DIT Fields "Strength Spec. Code", "Strength Spec. Value"
        // //Reservation Entries
        // ReservationEntry.SETRANGE("Source ID", CreatedTransferOrderNo);
        // ReservationEntry.SETRANGE("Item No.", ItemNo);
        // ReservationEntry.SETRANGE("Location Code", ItemJournalLine."Location Code");
        // ReservationEntry.SETRANGE("Source Ref. No.", LineNo); //HEI.03
        // IF ReservationEntry.FINDSET() THEN
        //     REPEAT
        //         CreateReservationEntry(ReservationEntry."Quantity (Base)", ReservationEntry."Qty. per Unit of Measure", DATABASE::"Item Journal Line", ItemJournalLine."Entry Type",
        //           ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name", ItemJournalLine."Line No.", ReservationEntry."Item No.", ItemJournalLine."Location Code",
        //           ItemJournalLine."Bin Code", ReservationEntry."Lot No.", ReservationEntry."Expiration Date", ReservationEntry."Strength Spec. Code", ReservationEntry."Strength Spec. Value");
        //     UNTIL ReservationEntry.NEXT() = 0;
        // BC Upgrade SHUKLP03 << Blocked code because dependency on DIT Fields "Strength Spec. Code", "Strength Spec. Value"

        ItemJournalLine.MODIFY(TRUE);

        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine);
        PositiveAdjustmentPosted := TRUE;
    end;

    LOCAL procedure CreateReservationEntry(SourceBaseQty: Decimal; SourceQtyPerUoM: Decimal; SourceType: Integer; SourceSubtype: Option "0","1","2","3","4","5","6","7","8","9","10"; SourceID: Code[20]; SourceBatch: Code[10]; SourceLineNo: Integer; SourceIntemNo: Code[20]; SourceLocationCode: Code[10]; SourceBin: Code[10]; SourceLotNo: Code[20]; ExpirationDate: Date; StrengthSpecCode: Code[20]; StrengthSpecValue: Decimal)
    var
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        LotNoInformation: Record "Lot No. Information";
    begin
        ReservationEntry.RESET();
        ReservationEntry.INIT();
        IF ReservationEntry2.FINDLAST() THEN
            ReservationEntry.VALIDATE("Entry No.", ReservationEntry2."Entry No." + 1);

        ReservationEntry."Source Type" := SourceType;
        ReservationEntry."Source Subtype" := SourceSubtype;
        ReservationEntry."Source ID" := SourceID;
        ReservationEntry."Source Batch Name" := SourceBatch;
        ReservationEntry."Source Ref. No." := SourceLineNo;
        //ReservationEntry."Creation Date" := WORKDATE;
        ReservationEntry."Creation Date" := PostingDate;
        ReservationEntry."Created By" := USERID;
        ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
        ReservationEntry.VALIDATE("Item No.", SourceIntemNo);
        ReservationEntry.VALIDATE("Location Code", SourceLocationCode);
        //ReservationEntry.VALIDATE("Bin Code", SourceBin);   // BC Upgrade SHUKLP03 << Blocked DIT field "Bin Code".
        ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
        ReservationEntry.VALIDATE("Lot No.", SourceLotNo);
        //ReservationEntry.VALIDATE("Expected Receipt Date",WORKDATE);
        ReservationEntry.VALIDATE("Expected Receipt Date", PostingDate);
        IF NewLot THEN
            ReservationEntry.VALIDATE("Expiration Date", ExpirationDate);
        ReservationEntry.VALIDATE(Quantity, -SourceBaseQty / SourceQtyPerUoM);
        //HEI.04>>
        //ReservationEntry.VALIDATE("Quantity (Base)",-SourceBaseQty);
        //ReservationEntry.VALIDATE("Qty. to Handle (Base)",ReservationEntry."Quantity (Base)");
        ReservationEntry."Quantity (Base)" := -SourceBaseQty;
        ReservationEntry."Qty. to Handle (Base)" := ReservationEntry."Quantity (Base)";
        ReservationEntry."Qty. to Invoice (Base)" := ReservationEntry."Quantity (Base)";
        ReservationEntry."Qty. per Unit of Measure" := SourceQtyPerUoM;
        //HEI.04<<
        ReservationEntry.Positive := ReservationEntry.Quantity > 0;
        // ReservationEntry."Strength Spec. Code" := StrengthSpecCode; // BC Upgrade SHUKLP03 << Blocked DIT field "Strength Spec. Code".
        // ReservationEntry."Strength Spec. Value" := StrengthSpecValue;  // BC Upgrade SHUKLP03 << Blocked DIT field "Strength Spec. Value".
        ReservationEntry.INSERT(TRUE);

        // BC Upgrade SHUKLP03 >> Blocked code because dependency on DIT field "Expiration Date".
        // IF NewLot THEN BEGIN
        //     LotNoInformation.RESET;
        //     LotNoInformation.SETRANGE("Lot No.", SourceLotNo);
        //     LotNoInformation.SETRANGE("Item No.", SourceIntemNo);
        //     IF LotNoInformation.FINDFIRST THEN
        //         IF LotNoInformation."Expiration Date" = 0D THEN BEGIN
        //             LotNoInformation."Expiration Date" := ReservationEntry."Expiration Date";
        //             LotNoInformation.MODIFY;
        //         END;
        // END;
        // BC Upgrade SHUKLP03 << Blocked code because dependency on DIT field "Expiration Date".

    end;


}
