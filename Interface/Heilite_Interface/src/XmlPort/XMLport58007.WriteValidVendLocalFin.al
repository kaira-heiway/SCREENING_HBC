xmlport 58007 "Write/Valid. Vend. Local Fin."
{
    // Heilite Navision Old Id - 50008
    // version HEI.01

    // HEI.01 RFC254 IBM HORTOC01 21.05.2018 - new field

    // BC Upgrade VAMSIU01 >>
    // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer); - Commented(Blocked temporarily as this function is dependent on Dotnet variables).
    // InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); - Added.
    // procedure GetTempBlob(var NewTempBlob: Record TempBlob); - Commented(BLocked as TempBlob Record is obsolete)
    // procedure GetTempBlob(var NewTempBlob: Codeunit ""Temp Blob"");" - Added.
    // TempBlob : Record TempBlob temporary; - Commented(BLocked as TempBlob Record is obsolete)
    // TempBlob: Codeunit "Temp Blob"; -Added
    // BC Upgrade VAMSIU01 <<

    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/WriteVendorLocalFinance';
    UseDefaultNamespace = true;

    schema
    {
        textelement(webVendorWriteLocalFinance)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            textelement(ValidateOnly)
            {
                MaxOccurs = Once;
                MinOccurs = Once;

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('webVendorWriteLocalFinance');
                    TempXMLBuffer.AddElement('ValidateOnly', ValidateOnly);
                end;
            }
            textelement(VendorLocalFinance)
            {
                MaxOccurs = Unbounded;
                MinOccurs = Zero;
                textelement(No)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Blocked)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(BlockedReasonCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SensitiveBlock)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(EmailFinance)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(VendorPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(GenBusPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(VATBusPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(VendorDepositGroupCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(DepositVendorPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SplitDepositOnInvoice)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(GenBusPostingGroupFreeItem)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(WHTBusinessPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('VendorLocalFinance');
                    AddXMLBufferElements();
                    TempXMLBuffer.GetParent();
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort();
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
    begin
        CLEAR(TempBlob);
        InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); //BC Upgrade VAMSIU01 - Added
        // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer);  // BC Upgrade NANDIS03
    end;

    var
        TempXMLBuffer: Record "XML Buffer" temporary;
        //TempBlob : Record TempBlob temporary;  // BC Upgrade NANDIS03
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Added

    local procedure AddXMLBufferElements();
    begin
        TempXMLBuffer.AddElement('No', No);
        TempXMLBuffer.AddElement('Blocked', Blocked);
        TempXMLBuffer.AddElement('BlockedReasonCode', BlockedReasonCode);
        TempXMLBuffer.AddElement('SensitiveBlock', SensitiveBlock);
        TempXMLBuffer.AddElement('EmailFinance', EmailFinance);
        TempXMLBuffer.AddElement('VendorPostingGroup', VendorPostingGroup);
        TempXMLBuffer.AddElement('GenBusPostingGroup', GenBusPostingGroup);
        TempXMLBuffer.AddElement('VATBusPostingGroup', VATBusPostingGroup);
        TempXMLBuffer.AddElement('VendorDepositGroupCode', VendorDepositGroupCode);
        TempXMLBuffer.AddElement('DepositVendorPostingGroup', DepositVendorPostingGroup);
        TempXMLBuffer.AddElement('SplitDepositOnInvoice', SplitDepositOnInvoice);
        TempXMLBuffer.AddElement('GenBusPostingGroupFreeItem', GenBusPostingGroupFreeItem);
        TempXMLBuffer.AddElement('WHTBusinessPostingGroup', WHTBusinessPostingGroup);//HEI.01
        No := '';
        Blocked := '';
        BlockedReasonCode := '';
        SensitiveBlock := '';
        EmailFinance := '';
        VendorPostingGroup := '';
        GenBusPostingGroup := '';
        VATBusPostingGroup := '';
        VendorDepositGroupCode := '';
        DepositVendorPostingGroup := '';
        SplitDepositOnInvoice := '';
        GenBusPostingGroupFreeItem := '';
        WHTBusinessPostingGroup := '';//HEI.01
    end;

    procedure GetSimulateMode() SimulateMode: Boolean;
    begin
        EVALUATE(SimulateMode, ValidateOnly);
    end;

    // BC Upgrade NANDIS03 >> 
    //procedure GetTempBlob(var NewTempBlob: Record TempBlob);
    procedure GetTempBlob(var NewTempBlob: Codeunit "Temp Blob");
    // BC Upgrade NANDIS03 <<
    begin
        NewTempBlob := TempBlob;
    end;
}

