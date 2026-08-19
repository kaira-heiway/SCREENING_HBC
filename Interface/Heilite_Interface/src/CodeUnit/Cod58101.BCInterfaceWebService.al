namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using Microsoft.EServices.EDocument;

codeunit 58101 "BC Interface Web Service"
{
    // HEI.01 CHG2020184 IBM POENAB02 26.06.2019
    //   # New codeunit for Bank Connectivity interface
    // HEI.02 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables

    // BC Upgrade SHUKLP03 >> Nav old Id - 50083

    var
        InterfaceNotEnabledErr: TextConst ENU = 'Interface %1 is not enabled.';

    procedure SendBankStatementCAMT053(VAR Request: BigText)
    var
        InterfaceSetup: Record "Interface Setup INT";
        BankConnInterfaceSetup: Record "Bank Conn. Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutputStream: OutStream;
        EntryNo1: Integer;
    begin
        //HEI.01>>
        BankConnInterfaceSetup.GET();
        BankConnInterfaceSetup.TESTFIELD("CAMT053 Inbound Interface");
        InterfaceSetup.GET(BankConnInterfaceSetup."CAMT053 Inbound Interface");
        IF NOT InterfaceSetup.Enabled THEN
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendBankStatementCAMT053';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT();
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //HEI.01<<

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendBankStatementMT940(VAR Request: BigText)
    var
        InterfaceSetup: Record "Interface Setup INT";
        BankConnInterfaceSetup: Record "Bank Conn. Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutputStream: OutStream;
    begin
        //HEI.01>>
        BankConnInterfaceSetup.GET();
        BankConnInterfaceSetup.TESTFIELD("MT940 Inbound Interface");
        InterfaceSetup.GET(BankConnInterfaceSetup."MT940 Inbound Interface");
        IF NOT InterfaceSetup.Enabled THEN
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendBankStatementMT940';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT();
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //HEI.01<<

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

}
