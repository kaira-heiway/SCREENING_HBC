codeunit 58002 "Mendix Interface Web Services"
{
    // Heilite Navision Old Id - 50006

    // version HEI.05

    // HEI.01 FDD-GAPID043 IBM LAZARE02 29.06.2017 # New codeunit to handle received messages
    // HEI.02 FDD-SLSGAP020 IBM HORTOC01 23.10.2018 # Customer Interface
    // HEI.03 IBM HORTOC01 04.12.2018 # Material OneXml
    // HEI.04 IBM HORTOC01 04.12.2018 # Vendor OneXml
    // HEI.05 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables


    trigger OnRun();
    begin
    end;

    var
        SimulateModeErr: Label 'Simulate Mode';
        NoItemsInterfaceSetupErr: Label 'No interface setup exists for processing items.';
        NoVendorsInterfaceSetupErr: Label 'No interface setup exists for processing vendors.';
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';
        TempCust: Record "Aging Band Buffer" temporary;
        CustomerFilter: Text;

    procedure WriteMaterialGlobal(var webResult: XMLport "Write/Validate Result"; var webMaterialWriteGlobal: XMLport "Write Material Global") ReturnXml: Text;
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        //TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked as TempBlb Record type is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Opened
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutStr: OutStream;
        InStr: InStream;
        ReturnValue: Text;
        ErrorMessage: Text;
        ErrorOccurred: Boolean;
    begin
        GeneralInterfaceSetup.GET();
        if InterfaceSetup.GET(GeneralInterfaceSetup."Items Global Interface") then begin
            if not InterfaceSetup.Enabled then
                ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);
            if not webMaterialWriteGlobal.IMPORT() then
                ReturnValue := GETLASTERRORTEXT
            else begin
                CLEAR(TempBlob);
                webMaterialWriteGlobal.GetTempBlob(TempBlob);
                //TempBlob.Blob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                TempBlob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                CLEAR(TempIncomingDocumentAttachment);
                TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
                TempIncomingDocumentAttachment."Line No." := 1;
                TempIncomingDocumentAttachment.Name := 'webMaterialWriteGlobal';
                TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
                TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
                TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutStr);
                COPYSTREAM(OutStr, InStr);
                TempIncomingDocumentAttachment.INSERT();
                InboundInterfaceMapping.SetSimulateMode(webMaterialWriteGlobal.GetSimulateMode());
                if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then
                    ErrorMessage := GETLASTERRORTEXT
                else
                    ReturnValue := InboundInterfaceMapping.GetReturnValue();
            end;
        end else
            ErrorMessage := NoItemsInterfaceSetupErr;

        if ErrorMessage = SimulateModeErr then
            ErrorMessage := '';

        if ErrorMessage <> '' then begin
            ErrorOccurred := true;
            ReturnValue := ErrorMessage;
        end;
        webResult.SetValues(ErrorOccurred, ReturnValue);

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(TempBlob);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutStr);
        CLEAR(InStr);
        //HEI.05<<
    end;

    procedure WriteValidateMaterialLocalFinance(var webMaterialWriteLocalFinance: XMLport "Write/Validate Local Finance") ReturnValue: Text;
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        //TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked as TempBlb Record type is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Opened
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutStr: OutStream;
        InStr: InStream;
    begin
        GeneralInterfaceSetup.GET();
        if InterfaceSetup.GET(GeneralInterfaceSetup."Items Local Finance Interface") then begin
            if not InterfaceSetup.Enabled then
                ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);
            if not webMaterialWriteLocalFinance.IMPORT() then
                ReturnValue := GETLASTERRORTEXT
            else begin
                CLEAR(TempBlob);
                webMaterialWriteLocalFinance.GetTempBlob(TempBlob);
                //TempBlob.Blob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                TempBlob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                CLEAR(TempIncomingDocumentAttachment);
                TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
                TempIncomingDocumentAttachment."Line No." := 1;
                TempIncomingDocumentAttachment.Name := 'webMaterialWriteLocalFinance';
                TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
                TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
                TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutStr);
                COPYSTREAM(OutStr, InStr);
                TempIncomingDocumentAttachment.INSERT();
                InboundInterfaceMapping.SetSimulateMode(webMaterialWriteLocalFinance.GetSimulateMode());
                if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then
                    ReturnValue := GETLASTERRORTEXT
                else
                    ReturnValue := InboundInterfaceMapping.GetReturnValue();
            end;
        end else
            ReturnValue := NoItemsInterfaceSetupErr;

        if ReturnValue = SimulateModeErr then
            ReturnValue := '';

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(TempBlob);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutStr);
        CLEAR(InStr);
        //HEI.05<<
    end;

    procedure WriteValidateMaterialLocalPlanning(var webMaterialWriteLocalPlanning: XMLport "Write/Validate Local Planning") ReturnValue: Text;
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        //TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked as TempBlb Record type is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Opened
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutStr: OutStream;
        InStr: InStream;
    begin
        GeneralInterfaceSetup.GET();
        if InterfaceSetup.GET(GeneralInterfaceSetup."Items Local Planning Interface") then begin
            if not InterfaceSetup.Enabled then
                ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);
            if not webMaterialWriteLocalPlanning.IMPORT() then
                ReturnValue := GETLASTERRORTEXT
            else begin
                CLEAR(TempBlob);
                webMaterialWriteLocalPlanning.GetTempBlob(TempBlob);
                //TempBlob.Blob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                TempBlob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                CLEAR(TempIncomingDocumentAttachment);
                TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
                TempIncomingDocumentAttachment."Line No." := 1;
                TempIncomingDocumentAttachment.Name := 'webMaterialWriteLocalPlanning';
                TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
                TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
                TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutStr);
                COPYSTREAM(OutStr, InStr);
                TempIncomingDocumentAttachment.INSERT();
                InboundInterfaceMapping.SetSimulateMode(webMaterialWriteLocalPlanning.GetSimulateMode());
                if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then
                    ReturnValue := GETLASTERRORTEXT
                else
                    ReturnValue := InboundInterfaceMapping.GetReturnValue();
            end;
        end else
            ReturnValue := NoItemsInterfaceSetupErr;

        if ReturnValue = SimulateModeErr then
            ReturnValue := '';

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(TempBlob);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutStr);
        CLEAR(InStr);
        //HEI.05<<
    end;

    procedure WriteValidateMaterialLocalSite(var webMaterialWriteLocalSite: XMLport "Write/Validate Local Site") ReturnValue: Text;
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        //TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked as TempBlb Record type is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Opened
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutStr: OutStream;
        InStr: InStream;
    begin
        GeneralInterfaceSetup.GET();
        if InterfaceSetup.GET(GeneralInterfaceSetup."Items Local Site Interface") then begin
            if not InterfaceSetup.Enabled then
                ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);
            if not webMaterialWriteLocalSite.IMPORT() then
                ReturnValue := GETLASTERRORTEXT
            else begin
                CLEAR(TempBlob);
                webMaterialWriteLocalSite.GetTempBlob(TempBlob);
                //TempBlob.Blob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                TempBlob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                CLEAR(TempIncomingDocumentAttachment);
                TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
                TempIncomingDocumentAttachment."Line No." := 1;
                TempIncomingDocumentAttachment.Name := 'webMaterialWriteLocalSite';
                TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
                TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
                TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutStr);
                COPYSTREAM(OutStr, InStr);
                TempIncomingDocumentAttachment.INSERT();
                InboundInterfaceMapping.SetSimulateMode(webMaterialWriteLocalSite.GetSimulateMode());
                if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then
                    ReturnValue := GETLASTERRORTEXT
                else
                    ReturnValue := InboundInterfaceMapping.GetReturnValue();
            end;
        end else
            ReturnValue := NoItemsInterfaceSetupErr;

        if ReturnValue = SimulateModeErr then
            ReturnValue := '';

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(TempBlob);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutStr);
        CLEAR(InStr);
        //HEI.05<<
    end;

    procedure WriteVendorGlobal(var webResult: XMLport "Write/Validate Result"; var webVendorWriteGlobal: XMLport "Write Vendor Global") ReturnXml: Text;
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        //TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked as TempBlb Record type is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Opened
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutStr: OutStream;
        InStr: InStream;
        ReturnValue: Text;
        ErrorMessage: Text;
        ErrorOccurred: Boolean;
    begin
        GeneralInterfaceSetup.GET();
        if InterfaceSetup.GET(GeneralInterfaceSetup."Vendors Global Interface") then begin
            if not InterfaceSetup.Enabled then
                ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);
            if not webVendorWriteGlobal.IMPORT() then
                ReturnValue := GETLASTERRORTEXT
            else begin
                CLEAR(TempBlob);
                webVendorWriteGlobal.GetTempBlob(TempBlob);
                //TempBlob.Blob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                TempBlob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                CLEAR(TempIncomingDocumentAttachment);
                TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
                TempIncomingDocumentAttachment."Line No." := 1;
                TempIncomingDocumentAttachment.Name := 'webVendorWriteGlobal';
                TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
                TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
                TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutStr);
                COPYSTREAM(OutStr, InStr);
                TempIncomingDocumentAttachment.INSERT();
                InboundInterfaceMapping.SetSimulateMode(webVendorWriteGlobal.GetSimulateMode());
                if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then
                    ErrorMessage := GETLASTERRORTEXT
                else
                    ReturnValue := InboundInterfaceMapping.GetReturnValue();
            end;
        end else
            ErrorMessage := NoItemsInterfaceSetupErr;

        if ErrorMessage = SimulateModeErr then
            ErrorMessage := '';

        if ErrorMessage <> '' then begin
            ErrorOccurred := true;
            ReturnValue := ErrorMessage;
        end;
        webResult.SetValues(ErrorOccurred, ReturnValue);

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(TempBlob);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutStr);
        CLEAR(InStr);
        //HEI.05<<
    end;

    procedure WriteValidateVendorBank(var webVendorWriteBank: XMLport "Write Vendor Bank") ReturnValue: Text;
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        //TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked as TempBlb Record type is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Opened
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutStr: OutStream;
        InStr: InStream;
    begin
        GeneralInterfaceSetup.GET();
        if InterfaceSetup.GET(GeneralInterfaceSetup."Vendor Bank Interface") then begin
            if not InterfaceSetup.Enabled then
                ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);
            if not webVendorWriteBank.IMPORT() then
                ReturnValue := GETLASTERRORTEXT
            else begin
                CLEAR(TempBlob);
                webVendorWriteBank.GetTempBlob(TempBlob);
                //TempBlob.Blob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                TempBlob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                CLEAR(TempIncomingDocumentAttachment);
                TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
                TempIncomingDocumentAttachment."Line No." := 1;
                TempIncomingDocumentAttachment.Name := 'webVendorWriteBank';
                TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
                TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
                TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutStr);
                COPYSTREAM(OutStr, InStr);
                TempIncomingDocumentAttachment.INSERT();
                InboundInterfaceMapping.SetSimulateMode(webVendorWriteBank.GetSimulateMode());
                if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then
                    ReturnValue := GETLASTERRORTEXT
                else
                    ReturnValue := InboundInterfaceMapping.GetReturnValue();
            end;
        end else
            ReturnValue := NoItemsInterfaceSetupErr;

        if ReturnValue = SimulateModeErr then
            ReturnValue := '';

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(TempBlob);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutStr);
        CLEAR(InStr);
        //HEI.05<<
    end;

    procedure WriteValidateVendorLocalFinance(var webVendorWriteLocalFinance: XMLport "Write/Valid. Vend. Local Fin.") ReturnValue: Text;
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        //TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked as TempBlb Record type is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Opened
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutStr: OutStream;
        InStr: InStream;
    begin
        GeneralInterfaceSetup.GET();
        if InterfaceSetup.GET(GeneralInterfaceSetup."Vend. Local Finance Interface") then begin
            if not InterfaceSetup.Enabled then
                ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);
            if not webVendorWriteLocalFinance.IMPORT() then
                ReturnValue := GETLASTERRORTEXT
            else begin
                CLEAR(TempBlob);
                webVendorWriteLocalFinance.GetTempBlob(TempBlob);
                //TempBlob.Blob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                TempBlob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                CLEAR(TempIncomingDocumentAttachment);
                TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
                TempIncomingDocumentAttachment."Line No." := 1;
                TempIncomingDocumentAttachment.Name := 'webVendorWriteLocalFinance';
                TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
                TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
                TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutStr);
                COPYSTREAM(OutStr, InStr);
                TempIncomingDocumentAttachment.INSERT();
                InboundInterfaceMapping.SetSimulateMode(webVendorWriteLocalFinance.GetSimulateMode());
                if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then
                    ReturnValue := GETLASTERRORTEXT
                else
                    ReturnValue := InboundInterfaceMapping.GetReturnValue();
            end;
        end else
            ReturnValue := NoItemsInterfaceSetupErr;

        if ReturnValue = SimulateModeErr then
            ReturnValue := '';

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(TempBlob);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutStr);
        CLEAR(InStr);
        //HEI.05<<
    end;

    procedure WriteValidateVendorLocalPurchasing(var webVendorWriteLocalPurchasing: XMLport "Write/Valid. Vend. Local Purch") ReturnValue: Text;
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        //TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked as TempBlb Record type is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Opened
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutStr: OutStream;
        InStr: InStream;
    begin
        GeneralInterfaceSetup.GET();
        if InterfaceSetup.GET(GeneralInterfaceSetup."Vend. Local Purch. Interface") then begin
            if not InterfaceSetup.Enabled then
                ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);
            if not webVendorWriteLocalPurchasing.IMPORT() then
                ReturnValue := GETLASTERRORTEXT
            else begin
                CLEAR(TempBlob);
                webVendorWriteLocalPurchasing.GetTempBlob(TempBlob);
                //TempBlob.Blob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                TempBlob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                CLEAR(TempIncomingDocumentAttachment);
                TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
                TempIncomingDocumentAttachment."Line No." := 1;
                TempIncomingDocumentAttachment.Name := 'webVendorWriteLocalPurchasing';
                TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
                TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
                TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutStr);
                COPYSTREAM(OutStr, InStr);
                TempIncomingDocumentAttachment.INSERT();
                InboundInterfaceMapping.SetSimulateMode(webVendorWriteLocalPurchasing.GetSimulateMode());
                if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then
                    ReturnValue := GETLASTERRORTEXT
                else
                    ReturnValue := InboundInterfaceMapping.GetReturnValue();
            end;
        end else
            ReturnValue := NoItemsInterfaceSetupErr;

        if ReturnValue = SimulateModeErr then
            ReturnValue := '';

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(TempBlob);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutStr);
        CLEAR(InStr);
        //HEI.05<<
    end;

    procedure WriteCustomer(var webResult: XMLport "Write/Validate Result"; var webCustomerWrite: XMLport "Write Customer") ReturnXml: Text;
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        //TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked as TempBlb Record type is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Opened
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutStr: OutStream;
        InStr: InStream;
        ReturnValue: Text;
        ErrorMessage: Text;
        ErrorOccurred: Boolean;
    begin
        //HEI.02>>
        GeneralInterfaceSetup.GET();
        if InterfaceSetup.GET(GeneralInterfaceSetup."Customer Interface") then begin
            if not InterfaceSetup.Enabled then
                ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);
            if not webCustomerWrite.IMPORT() then
                ReturnValue := GETLASTERRORTEXT
            else begin
                CLEAR(TempBlob);
                webCustomerWrite.GetTempBlob(TempBlob);
                //TempBlob.Blob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                TempBlob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                CLEAR(TempIncomingDocumentAttachment);
                TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
                TempIncomingDocumentAttachment."Line No." := 1;
                TempIncomingDocumentAttachment.Name := 'webCustomerWrite';
                TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
                TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
                TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutStr);
                COPYSTREAM(OutStr, InStr);
                TempIncomingDocumentAttachment.INSERT();
                InboundInterfaceMapping.SetSimulateMode(webCustomerWrite.GetSimulateMode());
                if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then
                    ErrorMessage := GETLASTERRORTEXT
                else
                    ReturnValue := InboundInterfaceMapping.GetReturnValue();
            end;
        end else
            ErrorMessage := NoItemsInterfaceSetupErr;

        if ErrorMessage = SimulateModeErr then
            ErrorMessage := '';

        if ErrorMessage <> '' then begin
            ErrorOccurred := true;
            ReturnValue := ErrorMessage;
        end;
        webResult.SetValues(ErrorOccurred, ReturnValue);
        //HEI.02<<

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(TempBlob);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutStr);
        CLEAR(InStr);
        //HEI.05<<
    end;

    procedure CheckCustomerDuplicates(var webResult: XMLport "Check Cust. Duplicates Result"; var webCustomerCheckDuplicates: XMLport "Check Customer Duplicates") ReturnXml: Text;
    var
        ReturnValue: Text;
        ErrorMessage: Text;
        ErrorOccurred: Boolean;
        DuplicateResult: Text;
        CustNoFilter: Text;
        HeinekenGlobal: Codeunit "Heineken Global";
        CustomerDescription: Text;
        Customer: Record Customer;
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        CustDuplicateDistance: Decimal;
        VatRegNo: Text;
        TaxNumber1: Text;
        TaxNumber2: Text;
        CustomerAttributes: Record "Customer Attributes FND";
        LevenshteinCompare: Codeunit "Levenshtein Compare CBN";
        CustDuplicateDistance2: Integer;
    begin
        //HEI.02>>
        if not webCustomerCheckDuplicates.IMPORT() then
            ERROR(GETLASTERRORTEXT);

        TempCust.RESET();
        TempCust.DELETEALL();

        GeneralInterfaceSetup.GET();
        GeneralInterfaceSetup.TESTFIELD("Duplicate Check Limit Distance");

        CustomerDescription := webCustomerCheckDuplicates.GetCustomerDescription();
        VatRegNo := webCustomerCheckDuplicates.GetVatRegNo();
        TaxNumber1 := webCustomerCheckDuplicates.GetTaxNumber1();
        TaxNumber2 := webCustomerCheckDuplicates.GetTaxNumber2();

        Customer.RESET();
        //Customer.SETFILTER("Customer Description",'<>%1','');
        //Customer.SETFILTER(Address,'Calle Principal');
        //Customer.SETFILTER("No.",'0010000011|0010000353|0010000903|0010002638|0010003510|0010004050');
        //Customer.SETFILTER("No.",'0010000353');

        if Customer.findset() then
            repeat
                if CustomerAttributes.GET(Customer."No.") then;
                //IF CustomerDescription <> '' THEN
                //CustDuplicateDistance := HeinekenGlobal.DamerauLevenshtein(CustomerDescription,Customer."Customer Description");
                CustDuplicateDistance := HeinekenGlobal.CheckSimilarities(CustomerDescription, Customer."Customer Description FND", GeneralInterfaceSetup."Duplicate Check Limit Distance");
                CustDuplicateDistance2 := ROUND(CustDuplicateDistance, 1, '=');
                if (CustDuplicateDistance2 >= GeneralInterfaceSetup."Duplicate Check Limit Distance") and (CustomerDescription <> '') then
                    InsertTempCust(Customer."No.", CustDuplicateDistance2, 1);
                if (VatRegNo <> '') and (Customer."VAT Registration No." = VatRegNo) then
                    InsertTempCust(Customer."No.", 0, 2);
                if (TaxNumber1 <> '') and (CustomerAttributes."Tax Number 1" = TaxNumber1) then
                    InsertTempCust(Customer."No.", 0, 3);
                if (TaxNumber2 <> '') and (CustomerAttributes."Tax Number 2" = TaxNumber2) then
                    InsertTempCust(Customer."No.", 0, 4);
            until Customer.NEXT() = 0;

        if CustomerFilter = '' then
            ERROR('No duplicates found!');
        //ERROR('test: ' + CustomerFilter);

        webResult.SetValues(CustomerFilter, TempCust);
        //HEI.02<<
    end;

    procedure WriteMaterial(var webResult: XMLport "Write/Validate Result"; var webMaterialWrite: XMLport "Write Materials") ReturnXml: Text;
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        //TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked as TempBlb Record type is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Opened
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutStr: OutStream;
        InStr: InStream;
        ReturnValue: Text;
        ErrorMessage: Text;
        ErrorOccurred: Boolean;
    begin
        //HEI.03>>
        GeneralInterfaceSetup.GET();
        if InterfaceSetup.GET(GeneralInterfaceSetup."Material Interface") then begin
            if not InterfaceSetup.Enabled then
                ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);
            if not webMaterialWrite.IMPORT() then
                ReturnValue := GETLASTERRORTEXT
            else begin
                CLEAR(TempBlob);
                webMaterialWrite.GetTempBlob(TempBlob);
                //TempBlob.Blob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                TempBlob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                CLEAR(TempIncomingDocumentAttachment);
                TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
                TempIncomingDocumentAttachment."Line No." := 1;
                TempIncomingDocumentAttachment.Name := 'webMaterialWrite';
                TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
                TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
                TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutStr);
                COPYSTREAM(OutStr, InStr);
                TempIncomingDocumentAttachment.INSERT();
                InboundInterfaceMapping.SetSimulateMode(webMaterialWrite.GetSimulateMode());
                if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then
                    ErrorMessage := GETLASTERRORTEXT
                else
                    ReturnValue := InboundInterfaceMapping.GetReturnValue();
            end;
        end else
            ErrorMessage := NoItemsInterfaceSetupErr;

        if ErrorMessage = SimulateModeErr then
            ErrorMessage := '';

        if ErrorMessage <> '' then begin
            ErrorOccurred := true;
            ReturnValue := ErrorMessage;
        end;
        webResult.SetValues(ErrorOccurred, ReturnValue);
        //HEI.03<<

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(TempBlob);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutStr);
        CLEAR(InStr);
        //HEI.05<<
    end;

    procedure WriteVendor(var webResult: XMLport "Write/Validate Result"; var webVendorWrite: XMLport "Write Vendors") ReturnXml: Text;
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        //TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked as TempBlb Record type is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Opened
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        OutStr: OutStream;
        InStr: InStream;
        ReturnValue: Text;
        ErrorMessage: Text;
        ErrorOccurred: Boolean;
    begin
        //HEI.04>>
        GeneralInterfaceSetup.GET();
        if InterfaceSetup.GET(GeneralInterfaceSetup."Vendor Interface") then begin
            if not InterfaceSetup.Enabled then
                ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);
            if not webVendorWrite.IMPORT() then
                ReturnValue := GETLASTERRORTEXT
            else begin
                CLEAR(TempBlob);
                webVendorWrite.GetTempBlob(TempBlob);
                //TempBlob.Blob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                TempBlob.CREATEINSTREAM(InStr);  // BC Upgrade NANDIS03 - Blocked as TempBlob record is obsolete
                CLEAR(TempIncomingDocumentAttachment);
                TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
                TempIncomingDocumentAttachment."Line No." := 1;
                TempIncomingDocumentAttachment.Name := 'webVendorWrite';
                TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
                TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
                TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutStr);
                COPYSTREAM(OutStr, InStr);
                TempIncomingDocumentAttachment.INSERT();
                InboundInterfaceMapping.SetSimulateMode(webVendorWrite.GetSimulateMode());
                if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then
                    ErrorMessage := GETLASTERRORTEXT
                else
                    ReturnValue := InboundInterfaceMapping.GetReturnValue();
            end;
        end else
            ErrorMessage := NoItemsInterfaceSetupErr;

        if ErrorMessage = SimulateModeErr then
            ErrorMessage := '';

        if ErrorMessage <> '' then begin
            ErrorOccurred := true;
            ReturnValue := ErrorMessage;
        end;
        webResult.SetValues(ErrorOccurred, ReturnValue);
        //HEI.04<<

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(TempBlob);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutStr);
        CLEAR(InStr);
        //HEI.05<<
    end;

    // BC Upgrade NANDIS03 - Blocked as this function used no where >>
    // local procedure BuildXmlResult(ErrorMessage: Text; ReturnValue: Text) ReturnXml: Text;
    // var
    //     TempBlob: Record TempBlob temporary;
    //     WriteValidateResult: XMLport "Write/Validate Result";
    //     ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
    //     XMLNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     OutStr: OutStream;
    //     InStr: InStream;
    //     ErrorOccurred: Boolean;
    // begin
    //     if ErrorMessage <> '' then begin
    //         ErrorOccurred := true;
    //         ReturnValue := ErrorMessage;
    //     end;
    //     CLEAR(TempBlob);
    //     TempBlob.Blob.CREATEOUTSTREAM(OutStr);
    //     WriteValidateResult.SetValues(ErrorOccurred, ReturnValue);
    //     WriteValidateResult.SETDESTINATION(OutStr);
    //     WriteValidateResult.EXPORT;
    //     TempBlob.Blob.CREATEINSTREAM(InStr);
    //     ResponseXML := ResponseXML.XmlDocument;
    //     ResponseXML.Load(InStr);
    //     XMLNode := ResponseXML.FirstChild;
    //     ResponseXML.RemoveChild(XMLNode);
    //     ReturnXml := ReplaceString(ResponseXML.InnerXml, '![CDATA[', '');
    //     ReturnXml := ReplaceString(ReturnXml, ']]', '');

    //     //HEI.05>>
    //     CLEAR(ResponseXML);
    //     CLEAR(XMLNode);
    //     CLEAR(OutStr);
    //     CLEAR(InStr);
    //     //HEI.05<<
    // end;  
    // BC Upgrade NANDIS03 - Blocked as this function used no where <<

    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text;
    begin
        while STRPOS(String, FindWhat) > 0 do
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    local procedure InsertTempCust(CustNo: Code[20]; Distance: Integer; MessageID: Integer);
    begin
        if STRPOS(CustomerFilter, CustNo) = 0 then begin
            TempCust.INIT();
            TempCust."Currency Code" := CustNo;
            TempCust."Column 1 Amt." := Distance;
            TempCust."Column 2 Amt." := MessageID;
            TempCust.INSERT();

            if CustomerFilter = '' then
                CustomerFilter := CustNo
            else
                CustomerFilter += '|' + CustNo;
        end;
    end;
}

