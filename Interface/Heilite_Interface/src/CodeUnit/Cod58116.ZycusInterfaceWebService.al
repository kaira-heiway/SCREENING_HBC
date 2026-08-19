codeunit 58116 "Zycus Interface Web Service"
{
    // version HEI.05

    // HEI.01 CHG2210794 SAHAL01 03.09.2024 Zycus - BASE HL Integration with Transaction PO, GR, POSM GR
    //   # Created New Codeunit: 50207 - Zycus Interface Web Service
    //   # Created New Functions - GetCompanyInformation_Zycus
    //                           - GetGeneralInterfaceSetup_Zycus
    //                           - GetZycusInterfaceSetup_Zycus
    //                           - ValidateInterfaceSetup_Zycus
    // HEI.02 CHG2210794 SAHAL01 03.09.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Created New Function - ProcessPurchaseOrder_Zycus
    // HEI.03 CHG2210794 SAHAL01 03.09.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Created New Functions - ProcessGoodsReceipt_Zycus
    //                           - ProcessGoodsReceiptCancellation_Zycus
    //                           - ProcessLimitGoodsReceipt_Zycus
    //                           - ProcessLimitGoodsReceiptCancellation_Zycus
    // HEI.04 CHG2210794 VERMAA03 14.06.2024 Zycus -BASE integration with POSM GR
    //   # Created New Functions - ProcessPOSMGRConfirmation
    // HEI.05 CHG2210794 SAHAL01 03.09.2024 Zycus - BASE HL Integration with Transaction POSM GR
    //   # Added Code

    //BC UPGRADE KUMARR78 >>
    //
    // 1.Old Codeunit Id and Name - 50207 ("Zycus Interface Web Service")
    //
    // 2. Converting Record Id's and Codeunit ID's in variable to Variables Name.
    //    . Old  
    //            Codeunit 50098
    //            Record   133
    //
    //    . New 
    //            Codeunit "Zycus Interface Web Service"
    //            Record   "Incoming Document Attachment"
    //
    //BC UPGRADE KUMARR78 <<

    trigger OnRun();
    begin
    end;

    var
        CompanyInformation: Record "Company Information";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        ZycusInterfaceSetup: Record "Zycus Interface Setup INT";
        CompanyInformationRead: Boolean;
        GeneralInterfaceSetupRead: Boolean;
        ZycusInterfaceSetupRead: Boolean;
        Text000: Label 'Interface ''%1'' is not enabled.';

    local procedure GetCompanyInformation_Zycus();
    begin
        //HEI.01>>
        if not CompanyInformationRead then begin
            CompanyInformation.Get();
            CompanyInformationRead := true;
        end;
        //HEI.01<<
    end;

    local procedure GetGeneralInterfaceSetup_Zycus();
    begin
        //HEI.01>>
        if not GeneralInterfaceSetupRead then begin
            GeneralInterfaceSetup.Get();
            GeneralInterfaceSetupRead := true;
        end;
        //HEI.01<<
    end;

    local procedure GetZycusInterfaceSetup_Zycus();
    begin
        //HEI.01>>
        if not ZycusInterfaceSetupRead then begin
            if ZycusInterfaceSetup.Get() and ZycusInterfaceSetup."Enabled Zycus Integration" then
                ZycusInterfaceSetupRead := true;
        end;
        //HEI.01<<
    end;

    local procedure ValidateInterfaceSetup_Zycus(InterfaceCode: Code[20]);
    var
        InterfaceSetupL: Record "Interface Setup INT";
    begin
        //HEI.01>>
        InterfaceSetupL.Get(InterfaceCode);
        if not InterfaceSetupL.Enabled then
            Error(Text000, InterfaceSetupL.Code);
        //HEI.01<<
    end;
    // BC Upgrade BHARDA11 >>
    procedure ReplaceSpecialCurrencySymbols_Zycus(var Request: BigText)
    var
        Payjour: Page "Payment Journal Tree CBN";
        RequestTextL: Text;
        TempBigTextL: BigText;
        CurrencySymbolMappingL: Record "Currency Symbol Mapping INT";
    begin
        Request.GetSubText(RequestTextL, 1, Request.Length());
        if CurrencySymbolMappingL.FindSet() then
            repeat
                if CurrencySymbolMappingL."Symbol" <> '' then
                    RequestTextL := RequestTextL.Replace(
                        CurrencySymbolMappingL."Symbol",
                        CurrencySymbolMappingL."HTML Code"
                    );

            until CurrencySymbolMappingL.Next() = 0;

        Clear(TempBigTextL);
        TempBigTextL.AddText(RequestTextL);
        Request := TempBigTextL;
    end;
    // BC Upgrade BHARDA11 <<

    procedure ProcessPurchaseOrder_Zycus(var Request: BigText);
    var
        TempIncomingDocumentAttachmentL: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMappingL: Codeunit "Inbound Interface Mapping VIP";
        Text000L: Label 'Interface ''%1'' is not enabled.';
        OutputStreamL: OutStream;
    begin
        // BC Upgrade BHARDA11 >>
        ReplaceSpecialCurrencySymbols_Zycus(Request);
        // BC Upgrade BHARAD11 <<
        //HEI.02>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            Clear(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate PO Interface" then begin
            Clear(ZycusInterfaceSetup);
            Clear(ZycusInterfaceSetupRead);
            exit;
        end;
        ZycusInterfaceSetup.TestField("Zycus PO Creation Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus PO Creation Interface");
        TempIncomingDocumentAttachmentL.Init();
        TempIncomingDocumentAttachmentL."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachmentL."Line No." := 1;
        TempIncomingDocumentAttachmentL.Name := 'ZycusProcessPO';
        TempIncomingDocumentAttachmentL.Type := TempIncomingDocumentAttachmentL.Type::XML;
        TempIncomingDocumentAttachmentL."Document No." := ZycusInterfaceSetup."Zycus PO Creation Interface";
        TempIncomingDocumentAttachmentL.Content.CreateOutStream(OutputStreamL);
        Request.Write(OutputStreamL);
        TempIncomingDocumentAttachmentL.Insert();
        InboundInterfaceMappingL.Run(TempIncomingDocumentAttachmentL);
        Clear(ZycusInterfaceSetup);
        Clear(ZycusInterfaceSetupRead);
        //HEI.02<<
    end;

    procedure ProcessGoodsReceipt_Zycus(var Request: BigText);
    var
        TempIncomingDocumentAttachmentL: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMappingL: Codeunit "Inbound Interface Mapping VIP";
        Text000L: Label 'Interface ''%1'' is not enabled.';
        OutputStreamL: OutStream;
    begin
        // BC Upgrade BHARDA11 >>
        ReplaceSpecialCurrencySymbols_Zycus(Request);
        // BC Upgrade BHARAD11 <<
        //HEI.03>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            Clear(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate GR Interface" then begin
            Clear(ZycusInterfaceSetup);
            Clear(ZycusInterfaceSetupRead);
            exit;
        end;
        ZycusInterfaceSetup.TestField("Zycus GR Creation Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus GR Creation Interface");
        TempIncomingDocumentAttachmentL.Init();
        TempIncomingDocumentAttachmentL."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachmentL."Line No." := 1;
        TempIncomingDocumentAttachmentL.Name := 'ZycusProcessGR';
        TempIncomingDocumentAttachmentL.Type := TempIncomingDocumentAttachmentL.Type::XML;
        TempIncomingDocumentAttachmentL."Document No." := ZycusInterfaceSetup."Zycus GR Creation Interface";
        TempIncomingDocumentAttachmentL.Content.CreateOutStream(OutputStreamL);
        Request.Write(OutputStreamL);
        TempIncomingDocumentAttachmentL.Insert();
        InboundInterfaceMappingL.Run(TempIncomingDocumentAttachmentL);
        Clear(ZycusInterfaceSetup);
        Clear(ZycusInterfaceSetupRead);
        //HEI.03<<
    end;

    procedure ProcessGoodsReceiptCancellation_Zycus(var Request: BigText);
    var
        TempIncomingDocumentAttachmentL: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMappingL: Codeunit "Inbound Interface Mapping VIP";
        Text000L: Label 'Interface ''%1'' is not enabled.';
        OutputStreamL: OutStream;
    begin
        // BC Upgrade BHARDA11 >>
        ReplaceSpecialCurrencySymbols_Zycus(Request);
        // BC Upgrade BHARAD11 <<
        //HEI.03>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            Clear(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate GR Interface" then begin
            Clear(ZycusInterfaceSetup);
            Clear(ZycusInterfaceSetupRead);
            exit;
        end;
        ZycusInterfaceSetup.TestField("Zycus GR Cancel Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus GR Cancel Interface");
        TempIncomingDocumentAttachmentL.Init();
        TempIncomingDocumentAttachmentL."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachmentL."Line No." := 1;
        TempIncomingDocumentAttachmentL.Name := 'ZycusProcessGRCancellation';
        TempIncomingDocumentAttachmentL.Type := TempIncomingDocumentAttachmentL.Type::XML;
        TempIncomingDocumentAttachmentL."Document No." := ZycusInterfaceSetup."Zycus GR Cancel Interface";
        TempIncomingDocumentAttachmentL.Content.CreateOutStream(OutputStreamL);
        Request.Write(OutputStreamL);
        TempIncomingDocumentAttachmentL.Insert();
        InboundInterfaceMappingL.Run(TempIncomingDocumentAttachmentL);
        Clear(ZycusInterfaceSetup);
        Clear(ZycusInterfaceSetupRead);
        //HEI.03<<
    end;

    procedure ProcessLimitGoodsReceipt_Zycus(var Request: BigText);
    var
        TempIncomingDocumentAttachmentL: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMappingL: Codeunit "Inbound Interface Mapping VIP";
        Text000L: Label 'Interface ''%1'' is not enabled.';
        OutputStreamL: OutStream;
    begin
        // BC Upgrade BHARDA11 >>
        ReplaceSpecialCurrencySymbols_Zycus(Request);
        // BC Upgrade BHARAD11 <<
        //HEI.03>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            Clear(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate GR Interface" then begin
            Clear(ZycusInterfaceSetup);
            Clear(ZycusInterfaceSetupRead);
            exit;
        end;
        ZycusInterfaceSetup.TestField("Zycus LPO GR CreationInterface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus LPO GR CreationInterface");
        TempIncomingDocumentAttachmentL.Init();
        TempIncomingDocumentAttachmentL."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachmentL."Line No." := 1;
        TempIncomingDocumentAttachmentL.Name := 'ZycusProcessLimitGR';
        TempIncomingDocumentAttachmentL.Type := TempIncomingDocumentAttachmentL.Type::XML;
        TempIncomingDocumentAttachmentL."Document No." := ZycusInterfaceSetup."Zycus LPO GR CreationInterface";
        TempIncomingDocumentAttachmentL.Content.CreateOutStream(OutputStreamL);
        Request.Write(OutputStreamL);
        TempIncomingDocumentAttachmentL.Insert();
        InboundInterfaceMappingL.Run(TempIncomingDocumentAttachmentL);
        Clear(ZycusInterfaceSetup);
        Clear(ZycusInterfaceSetupRead);
        //HEI.03<<
    end;

    procedure ProcessLimitGoodsReceiptCancellation_Zycus(var Request: BigText);
    var
        TempIncomingDocumentAttachmentL: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMappingL: Codeunit "Inbound Interface Mapping VIP";
        Text000L: Label 'Interface ''%1'' is not enabled.';
        OutputStreamL: OutStream;
    begin
        // BC Upgrade BHARDA11 >>
        ReplaceSpecialCurrencySymbols_Zycus(Request);
        // BC Upgrade BHARAD11 <<
        //HEI.03>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            Clear(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate GR Interface" then begin
            Clear(ZycusInterfaceSetup);
            Clear(ZycusInterfaceSetupRead);
            exit;
        end;
        ZycusInterfaceSetup.TestField("Zycus LPO GR Cancel Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus LPO GR Cancel Interface");
        TempIncomingDocumentAttachmentL.Init();
        TempIncomingDocumentAttachmentL."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachmentL."Line No." := 1;
        TempIncomingDocumentAttachmentL.Name := 'ZycusProcessLimitGRCancellation';
        TempIncomingDocumentAttachmentL.Type := TempIncomingDocumentAttachmentL.Type::XML;
        TempIncomingDocumentAttachmentL."Document No." := ZycusInterfaceSetup."Zycus LPO GR Cancel Interface";
        TempIncomingDocumentAttachmentL.Content.CreateOutStream(OutputStreamL);
        Request.Write(OutputStreamL);
        TempIncomingDocumentAttachmentL.Insert();
        InboundInterfaceMappingL.Run(TempIncomingDocumentAttachmentL);
        Clear(ZycusInterfaceSetup);
        Clear(ZycusInterfaceSetupRead);
        //HEI.03<<
    end;

    procedure ProcessPOSMGRConfirmation_Zycus(var Request: BigText);
    var
        TempIncomingDocumentAttachmentL: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMappingVIP: Codeunit "Inbound Interface Mapping VIP";
        InputStream: InStream;
        OutputStream: OutStream;
        ReceiverBusinessSystemID: Variant;
        SenderBusinessSystemID: Variant;
    begin
        // BC Upgrade BHARDA11 >>
        ReplaceSpecialCurrencySymbols_Zycus(Request);
        // BC Upgrade BHARAD11 <<
        //HEI.04>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            Clear(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate POSM GR Interface" then begin
            Clear(ZycusInterfaceSetup);
            //HEI.05>>
            Clear(ZycusInterfaceSetupRead);
            //HEI.05<<
            exit;
        end;
        ZycusInterfaceSetup.TestField("POSM GR Confirmation Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."POSM GR Confirmation Interface");
        Clear(TempIncomingDocumentAttachmentL);
        TempIncomingDocumentAttachmentL."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachmentL."Line No." := 1;
        TempIncomingDocumentAttachmentL.Name := 'ZycusPOSMGRConfirmation';
        TempIncomingDocumentAttachmentL.Type := TempIncomingDocumentAttachmentL.Type::XML;
        TempIncomingDocumentAttachmentL."Document No." := ZycusInterfaceSetup."POSM GR Confirmation Interface";
        TempIncomingDocumentAttachmentL.Content.CreateOutStream(OutputStream);
        Request.Write(OutputStream);
        TempIncomingDocumentAttachmentL.Insert();
        InboundInterfaceMappingVIP.Run(TempIncomingDocumentAttachmentL);
        Clear(ZycusInterfaceSetup);
        //HEI.05>>
        Clear(ZycusInterfaceSetupRead);
        //HEI.05<<
        //HEI.04<<
    end;
}

