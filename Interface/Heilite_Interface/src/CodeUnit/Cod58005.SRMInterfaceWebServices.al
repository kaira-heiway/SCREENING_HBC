codeunit 58005 "SRM Interface Web Services"
{
    // Heilite Navision Old Id - 50013
    // version HEI.07

    // HEI.01 FDD-HLSRM01-05 IBM LAZARE02 13.07.2017 # New codeunit to handle received SRM messages
    // HEI.02 CHG2041871 IBM PANDES01 24-01-2020.
    //  # Modify the  code related to SRM interface.
    // HEI.03 CHG2095187 IBM SAXENA03 18.02.2021
    //   # Code written for Paraller Request
    //   # Peace of code commented and added new code to replace FINDLAST with Entry No. in Function SendItemRequest()
    //   # Peace of code commented and added new code to replace FINDLAST with Entry No. in Function SendPOValidationRequest()
    // HEI.04 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables
    // HEI.05 CHG2148350 FDD-HB2777 IBM NANDIS01 16.02.2023 # develop confirmation check interface for HL
    //   # New Interface for synchronous GR Validation
    // HEI.06 CHG2190299 FDD-HB3316 IBM NANDIS01 24.05.2023 # POSM eshop SRM- HL interface
    //   # New function - SendPOSMGRConfirmation created for POSM GR Confirmation
    // HEI.07 CHG2190299 FDD-HB3316 IBM NANDIS01 04.08.2023 # POSM eshop SRM- HL interface
    //   # Field name mismatch fixed


    trigger OnRun();
    begin
    end;

    var
        SimulateModeErr: Label 'Simulate Mode';
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';

    procedure SendItemRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        SRMInterfaceManagement: Codeunit "SRM Interface Management";
        //ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument;
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        SRMInterfaceSetup: Record "SRM Interface Setup INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    begin
        //HEI.02>>
        //GeneralInterfaceSetup.Get;
        //GeneralInterfaceSetup.TestField("SRM Material Request Interface");
        //GeneralInterfaceSetup.TestField("SRM Material Response Interf.");
        //InterfaceSetup.Get(GeneralInterfaceSetup."SRM Material Request Interface");
        //HEI.02<<
        //HEI.02>>
        SRMInterfaceSetup.Get();
        SRMInterfaceSetup.TestField("SRM Material Request Interface");
        SRMInterfaceSetup.TestField("SRM Material Response Interf.");
        InterfaceSetup.Get(SRMInterfaceSetup."SRM Material Request Interface");
        //HEI.02>>
        InterfaceSetup.TestField("Call Type", InterfaceSetup."Call Type"::Synchronous);
        if not InterfaceSetup.Enabled then
            Error(InterfaceNotEnabledErr, InterfaceSetup.Code);

        Clear(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'MaterialRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CreateOutStream(OutputStream);
        Request.Write(OutputStream);
        TempIncomingDocumentAttachment.Insert();
        //<<HEI.03
        /*

        InboundInterfaceMapping.SetSimulateMode(TRUE);
        IF NOT InboundInterfaceMapping.Run(TempIncomingDocumentAttachment) THEN
          IF GetLastErrorText <> SimulateModeErr THEN BEGIN
            ErrorOccurred := TRUE;
            ErrorMessage := GetLastErrorText;
          END;

        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FindSet THEN
          REPEAT
            //HEI.02>>
            //SRMInterfaceManagement.CreateMaterialResponse(InterfaceEntryHeader,InterfaceEntryHeaderOut,GeneralInterfaceSetup."SRM Material Response Interf.");
            SRMInterfaceManagement.CreateMaterialResponse(InterfaceEntryHeader,InterfaceEntryHeaderOut,SRMInterfaceSetup."SRM Material Response Interf.");
            //HEI.02<<
            CODEUNIT.Run(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
            DataExch.Get(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.Get(DataExch."Parent Data Exch. No.");
            DataExch2.CalcFields("File Content");
            DataExch2."File Content".CreateInStream(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            Clear(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.Next = 0;
        */

        InboundInterfaceMapping.SetSimulateMode(true);
        if not InboundInterfaceMapping.Run(TempIncomingDocumentAttachment) then
            if GetLastErrorText() <> SimulateModeErr then begin
                ErrorOccurred := true;
                ErrorMessage := GetLastErrorText();
            end;

        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.findset(false) then
            repeat
                if InterfaceEntryHeader.Get(TempInboundEntryHdr."Entry No.") then begin
                    //HEI.02>>
                    //SRMInterfaceManagement.CreateMaterialResponse(InterfaceEntryHeader,InterfaceEntryHeaderOut,GeneralInterfaceSetup."SRM Material Response Interf.");
                    SRMInterfaceManagement.CreateMaterialResponse(InterfaceEntryHeader, InterfaceEntryHeaderOut, SRMInterfaceSetup."SRM Material Response Interf.");
                    //HEI.02<<
                    CODEUNIT.Run(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);
                    DataExch.Get(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.Get(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CalcFields("File Content");
                    DataExch2."File Content".CreateInStream(InputStream);
                    //BC upgrade POENAB02 >>
                    //ResponseXML := ResponseXML.XmlDocument;
                    //ResponseXML.Load(InputStream);
                    ResponseXML := XmlDocument.Create();
                    ResponseXML.Add(InputStream);
                    //BC upgrade POENAB02 <<

                    Clear(Request);
                    // BC upgrade POENAB02 >>
                    //Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);

                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    RespIn.ReadText(RespText);

                    Request.AddText(RespText);
                    // BC upgrade POENAB02 <<
                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
                end;
            until TempInboundEntryHdr.Next() = 0;
        TempInboundEntryHdr.DeleteAll();
        //>>HEI.03

        //HEI.04>>
        Clear(TempIncomingDocumentAttachment);
        Clear(InboundInterfaceMapping);
        Clear(ResponseXML);
        Clear(OutputStream);
        Clear(InputStream);
        //HEI.04<<

    end;

    procedure SendVendorRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        SRMInterfaceSetup: Record "SRM Interface Setup INT";
    begin
        //HEI.02>>
        //GeneralInterfaceSetup.Get;
        //GeneralInterfaceSetup.TestField("SRM Vendor Request Interface");
        //InterfaceSetup.Get(GeneralInterfaceSetup."SRM Vendor Request Interface");
        //HEI.02<<
        SRMInterfaceSetup.Get();
        SRMInterfaceSetup.TestField("SRM Vendor Request Interface");
        InterfaceSetup.Get(SRMInterfaceSetup."SRM Vendor Request Interface");
        //HEI.02<<
        if not InterfaceSetup.Enabled then
            Error(InterfaceNotEnabledErr, InterfaceSetup.Code);

        Clear(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SRMVendorRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CreateOutStream(OutputStream);
        Request.Write(OutputStream);
        TempIncomingDocumentAttachment.Insert();

        InboundInterfaceMapping.Run(TempIncomingDocumentAttachment);

        //HEI.04>>
        Clear(TempIncomingDocumentAttachment);
        Clear(InboundInterfaceMapping);
        Clear(OutputStream);
        Clear(InputStream);
        //HEI.04<<
    end;

    procedure SendContractCreation(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        SRMInterfaceSetup: Record "SRM Interface Setup INT";
    begin
        //HEI.02>>
        //GeneralInterfaceSetup.Get;
        //GeneralInterfaceSetup.TestField("Contract Creation Interface");
        //InterfaceSetup.Get(GeneralInterfaceSetup."Contract Creation Interface");
        //HEI.02<<
        //HEI.02>>
        SRMInterfaceSetup.Get();
        SRMInterfaceSetup.TestField("Contract Creation Interface");
        InterfaceSetup.Get(SRMInterfaceSetup."Contract Creation Interface");
        //HEI.02<<
        if not InterfaceSetup.Enabled then
            Error(InterfaceNotEnabledErr, InterfaceSetup.Code);

        Clear(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SRMContractCreation';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CreateOutStream(OutputStream);
        Request.Write(OutputStream);
        TempIncomingDocumentAttachment.Insert();
        InboundInterfaceMapping.Run(TempIncomingDocumentAttachment);

        //HEI.04>>
        Clear(TempIncomingDocumentAttachment);
        Clear(InboundInterfaceMapping);
        Clear(OutputStream);
        Clear(InputStream);
        //HEI.04<<
    end;

    procedure SendPOValidationRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        SRMInterfaceManagement: Codeunit "SRM Interface Management";
        ResponseXML: XmlDocument;
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        SRMInterfaceSetup: Record "SRM Interface Setup INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        ErrorText: Text;
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    begin
        //HEI.02>>
        //GeneralInterfaceSetup.Get;
        //GeneralInterfaceSetup.TestField("PO Validation Req. Interface");
        //GeneralInterfaceSetup.TestField("PO Validation Resp. Interface");
        //InterfaceSetup.Get(GeneralInterfaceSetup."PO Validation Req. Interface");
        //HEI.02<<
        //HEI.02>>
        SRMInterfaceSetup.Get();
        SRMInterfaceSetup.TestField("PO Validation Req. Interface");
        SRMInterfaceSetup.TestField("PO Validation Resp. Interface");
        InterfaceSetup.Get(SRMInterfaceSetup."PO Validation Req. Interface");
        //HEI.02<<
        InterfaceSetup.TestField("Call Type", InterfaceSetup."Call Type"::Synchronous);
        if not InterfaceSetup.Enabled then
            Error(InterfaceNotEnabledErr, InterfaceSetup.Code);

        Clear(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'POValidationRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CreateOutStream(OutputStream);
        Request.Write(OutputStream);
        TempIncomingDocumentAttachment.Insert();
        //<<HEI.03
        /*
        InboundInterfaceMapping.SetSimulateMode(TRUE);
        IF NOT InboundInterfaceMapping.Run(TempIncomingDocumentAttachment) THEN
          IF GetLastErrorText <> SimulateModeErr THEN BEGIN
            ErrorOccurred := TRUE;
            ErrorMessage := GetLastErrorText;
          END;

        InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
        IF InterfaceEntryHeader.FindSet THEN
          REPEAT
            //HEI.02>>
            //SRMInterfaceManagement.CreatePOValidationResponse(InterfaceEntryHeader,InterfaceEntryHeaderOut,GeneralInterfaceSetup."PO Validation Resp. Interface",
                                                              //ErrorOccurred,ErrorMessage);
            SRMInterfaceManagement.CreatePOValidationResponse(InterfaceEntryHeader,InterfaceEntryHeaderOut,SRMInterfaceSetup."PO Validation Resp. Interface",
                                                              ErrorOccurred,ErrorMessage);
            //HEI.02<<
            CODEUNIT.Run(CODEUNIT::"Outbound Interface Processing",InterfaceEntryHeaderOut);
            DataExch.Get(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.Get(DataExch."Parent Data Exch. No.");
            DataExch2.CalcFields("File Content");
            DataExch2."File Content".CreateInStream(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            Clear(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeader.Next = 0;
          */

        InboundInterfaceMapping.SetSimulateMode(true);
        if not InboundInterfaceMapping.Run(TempIncomingDocumentAttachment) then
            if GetLastErrorText <> SimulateModeErr then begin
                ErrorOccurred := true;
                ErrorMessage := GetLastErrorText;
            end;

        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.findset(false) then
            repeat
                if InterfaceEntryHeader.Get(TempInboundEntryHdr."Entry No.") then begin
                    SRMInterfaceManagement.CreatePOValidationResponse(InterfaceEntryHeader, InterfaceEntryHeaderOut, SRMInterfaceSetup."PO Validation Resp. Interface",
                                                                      ErrorOccurred, ErrorMessage);
                    //HEI.02<<
                    CODEUNIT.Run(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);
                    DataExch.Get(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.Get(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CalcFields("File Content");
                    DataExch2."File Content".CreateInStream(InputStream);
                    // BC upgrade POENAB02 >>
                    //ResponseXML := ResponseXML.XmlDocument;
                    //ResponseXML.Load(InputStream);
                    // BC Upgrade BHARDA11 >>-- Comment old code and add new code 
                    // ResponseXML := XmlDocument.Create();
                    // ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC Upgrade BHARDA11 <<-- Comment old code and add new code 
                    //BC upgrade POENAB02 <<

                    Clear(Request);

                    //BC upgrade POENAB02 >>
                    //Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);

                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    //BC Upgrade ATHUKS01 >>
                    //RespIn.ReadText(RespText);
                    RespText := ResponseData(RespIn);
                    //BC Upgrade ATHUKS01 >>
                    Request.AddText(RespText);
                    // BC upgrade POENAB02<<    
                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);

                end;
            until TempInboundEntryHdr.Next() = 0;
        TempInboundEntryHdr.DeleteAll();
        //>>HEI.03

        //HEI.04>>
        Clear(TempIncomingDocumentAttachment);
        Clear(InboundInterfaceMapping);
        Clear(ResponseXML);
        Clear(OutputStream);
        Clear(InputStream);
        //HEI.04<<

    end;

    procedure SendPOCreation(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        SRMInterfaceSetup: Record "SRM Interface Setup INT";
    begin
        //HEI.02>>
        //GeneralInterfaceSetup.Get;
        //GeneralInterfaceSetup.TestField("PO Creation Interface");
        //InterfaceSetup.Get(GeneralInterfaceSetup."PO Creation Interface");
        //HEI.02<<
        //HEI.02>>
        SRMInterfaceSetup.Get();
        SRMInterfaceSetup.TestField("PO Creation Interface");
        InterfaceSetup.Get(SRMInterfaceSetup."PO Creation Interface");
        //HEI.02<<
        if not InterfaceSetup.Enabled then
            Error(InterfaceNotEnabledErr, InterfaceSetup.Code);

        Clear(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendPOCreation';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CreateOutStream(OutputStream);
        Request.Write(OutputStream);
        TempIncomingDocumentAttachment.Insert();
        InboundInterfaceMapping.Run(TempIncomingDocumentAttachment);

        //HEI.04>>
        Clear(TempIncomingDocumentAttachment);
        Clear(InboundInterfaceMapping);
        Clear(OutputStream);
        Clear(InputStream);
        //HEI.04<<
    end;

    procedure SendGRCreation(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        SRMInterfaceSetup: Record "SRM Interface Setup INT";
    begin
        //HEI.02>>
        //GeneralInterfaceSetup.Get;
        //GeneralInterfaceSetup.TestField("GR Creation Interface");
        //InterfaceSetup.Get(GeneralInterfaceSetup."GR Creation Interface");
        //HEI.02<<

        //HEI.02>>
        SRMInterfaceSetup.Get();
        SRMInterfaceSetup.TestField("GR Creation Interface");
        InterfaceSetup.Get(SRMInterfaceSetup."GR Creation Interface");
        //HEI.02<<
        if not InterfaceSetup.Enabled then
            Error(InterfaceNotEnabledErr, InterfaceSetup.Code);

        Clear(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendGRCreation';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CreateOutStream(OutputStream);
        Request.Write(OutputStream);
        TempIncomingDocumentAttachment.Insert();
        InboundInterfaceMapping.Run(TempIncomingDocumentAttachment);

        //HEI.04>>
        Clear(TempIncomingDocumentAttachment);
        Clear(InboundInterfaceMapping);
        Clear(OutputStream);
        Clear(InputStream);
        //HEI.04<<
    end;

    procedure SendGRValidationRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        SRMInterfaceManagement: Codeunit "SRM Interface Management";
        ResponseXML: XmlDocument;
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        SRMInterfaceSetup: Record "SRM Interface Setup INT";
        TempInboundEntryHdr: Record "Interface Entry Header INT" temporary;
        ErrorText: Text;
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
    begin
        //HEI.05>>
        SRMInterfaceSetup.Get();
        SRMInterfaceSetup.TestField("GR Validation Req Interface");
        SRMInterfaceSetup.TestField("GR Validation Res Interface");
        InterfaceSetup.Get(SRMInterfaceSetup."GR Validation Req Interface");
        InterfaceSetup.TestField("Call Type", InterfaceSetup."Call Type"::Synchronous);
        if not InterfaceSetup.Enabled then
            Error(InterfaceNotEnabledErr, InterfaceSetup.Code);

        Clear(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'GRValidationRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CreateOutStream(OutputStream);
        Request.Write(OutputStream);
        TempIncomingDocumentAttachment.Insert();

        InboundInterfaceMapping.SetSimulateMode(true);
        if not InboundInterfaceMapping.Run(TempIncomingDocumentAttachment) then
            if (GetLastErrorText <> SimulateModeErr) AND (GetLastErrorText <> '') then begin // BC Upgrade BHARAD11
                ErrorOccurred := true;
                ErrorMessage := GetLastErrorText;
            end;

        InboundInterfaceMapping.GetCopyToTempInterfaceInboundEntry(TempInboundEntryHdr);
        if TempInboundEntryHdr.findset() then
            repeat
                if InterfaceEntryHeader.Get(TempInboundEntryHdr."Entry No.") then begin
                    SRMInterfaceManagement.CreateGRValidationResponse(InterfaceEntryHeader, InterfaceEntryHeaderOut, SRMInterfaceSetup."GR Validation Res Interface",
                                                                      ErrorOccurred, ErrorMessage);
                    CODEUNIT.Run(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeaderOut);
                    DataExch.Get(InterfaceEntryHeaderOut."Data Exch. Entry No.");
                    DataExch2.Get(DataExch."Parent Data Exch. No. FND");
                    DataExch2.CalcFields("File Content");
                    DataExch2."File Content".CreateInStream(InputStream);
                    //BC upgrade POENAB02 >>
                    //ResponseXML := ResponseXML.XmlDocument;
                    //ResponseXML.Load(InputStream);
                    // BC Upgrade BHARDA11 >>-- Comment old code and add new code 
                    // ResponseXML := XmlDocument.Create();
                    // ResponseXML.Add(InputStream);
                    ResponseXML := XmlDocument.Create();
                    XmlDocument.ReadFrom(InputStream, ResponseXML);
                    // BC Upgrade BHARDA11 <<-- Comment old code and add new code 
                    //BC upgrade POENAB02 <<

                    Clear(Request);

                    //BC upgrade POENAB02 >>
                    //Request.ADDTEXT(ResponseXML.InnerXml);
                    RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
                    ResponseXML.WriteTo(RespOut);
                    RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
                    //BC Upgrade ATHUKS01 >>
                    //RespIn.ReadText(RespText);
                    RespText := ResponseData(RespIn);
                    //BC Upgrade ATHUKS01 >>
                    Request.AddText(RespText);
                    //BC upgrade POENAB02 <<
                    InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
                    InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);

                end;
            until TempInboundEntryHdr.Next() = 0;
        TempInboundEntryHdr.DeleteAll();

        Clear(TempIncomingDocumentAttachment);
        Clear(InboundInterfaceMapping);
        Clear(ResponseXML);
        Clear(OutputStream);
        Clear(InputStream);
        //HEI.05<<
    end;

    procedure SendPOSMGRConfirmation(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        SRMInterfaceSetup: Record "SRM Interface Setup INT";
    begin
        //HEI.06>>
        SRMInterfaceSetup.Get();
        //SRMInterfaceSetup.TestField("POSM GR Creation");  //HEI.07
        //InterfaceSetup.Get(SRMInterfaceSetup."POSM GR Creation");  //HEI.07
        SRMInterfaceSetup.TestField("POSM GR Confirmation");  //HEI.07
        InterfaceSetup.Get(SRMInterfaceSetup."POSM GR Confirmation");  //HEI.07
        if not InterfaceSetup.Enabled then
            Error(InterfaceNotEnabledErr, InterfaceSetup.Code);

        Clear(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendPOSMGRConfirmation';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CreateOutStream(OutputStream);
        Request.Write(OutputStream);
        TempIncomingDocumentAttachment.Insert();
        InboundInterfaceMapping.Run(TempIncomingDocumentAttachment);

        Clear(TempIncomingDocumentAttachment);
        Clear(InboundInterfaceMapping);
        Clear(OutputStream);
        Clear(InputStream);
        //HEI.06<<
    end;

    //BC UPGRADE BHARDA11 >> 14July2026
    procedure ResponseData(ResInstream: InStream): Text
    var
        RespTextChunk: Text;
        RespTextData: Text;
    begin
        while not ResInstream.EOS do begin
            RespTextChunk := '';
            ResInstream.ReadText(RespTextChunk);
            RespTextData += RespTextChunk;
        end;
        exit(RespTextData);
    end;
    //BC UPGRADE BHARDA11 >>  14July2026
}

