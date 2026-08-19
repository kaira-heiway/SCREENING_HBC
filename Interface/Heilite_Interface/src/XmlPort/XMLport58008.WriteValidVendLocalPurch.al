xmlport 58008 "Write/Valid. Vend. Local Purch"
{
    // Heilite Navision Old Id - 50009
    // version HEI.04

    // HEI.01 RFC253 IBM HORTOC01 21.05.2018 - new field
    // HEI.02 PURGAP028 IBM LAZARE02 23.10.2018 - new field Send to Maximo
    // HEI.03 BA-PURGAP03IBM HORTOC01 22.01.2019 new fields "VendorCategory" and LocalVendorType
    // HEI.04 FDD-HT545 IBM POSTOI01 27.11.2019
    //   # new node item for SelfBilling
    //   # modify VendorLocalPurch - Import::OnAfterAssignVariable()

    // BC Upgrade VAMSIU01 >>
    // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer); - Commented(Blocked temporarily as this function is dependent on Dotnet variables).
    // InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); - Added.
    // procedure GetTempBlob(var NewTempBlob: Record TempBlob); - Commented(BLocked as TempBlob Record is obsolete)
    // procedure GetTempBlob(var NewTempBlob: Codeunit ""Temp Blob"");" - Added.
    // TempBlob : Record TempBlob temporary; - Commented(BLocked as TempBlob Record is obsolete)
    // TempBlob: Codeunit "Temp Blob"; -Added
    // BC Upgrade VAMSIU01 <<

    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/WriteVendorLocalPurchasing';
    UseDefaultNamespace = true;

    schema
    {
        textelement(webVendorWriteLocalPurchasing)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            textelement(ValidateOnly)
            {
                MaxOccurs = Once;
                MinOccurs = Once;

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('webVendorWriteLocalPurchasing');
                    TempXMLBuffer.AddElement('ValidateOnly', ValidateOnly);
                end;
            }
            textelement(VendorLocalPurch)
            {
                MaxOccurs = Unbounded;
                MinOccurs = Zero;
                textelement(No)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PurchaserCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PhoneNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(FaxNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(EmailProcurement)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PaymentTermsCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PaymentMethodCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ApplicationMethod)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PartnerType)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ShipmentMethodCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ShipmentMethodDescription)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CurrencyCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(DepositPaymentTermsCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(DepositPaymentMethodCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CalculateItemCharges)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(BlockPaymentTolerance)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SendToMaximo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(VendorCategory)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(LocalVendorType)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SelfBilling)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(VendorOrderAddress)
                {
                    MaxOccurs = Unbounded;
                    MinOccurs = Zero;
                    textelement(vendorno_orderaddress)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        XmlName = 'VendorNo';
                    }
                    textelement(LocalNo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;

                        trigger OnAfterAssignVariable();
                        begin
                            OrderAddressCode := LocalNo;
                        end;
                    }

                    trigger OnAfterAssignVariable();
                    begin
                        if not VendorGroupElementCreated then begin
                            TempXMLBuffer.AddGroupElement('VendorLocalPurch');
                            VendorGroupElementCreated := true;
                        end;
                        TempXMLBuffer.AddGroupElement('VendorOrderAddress');
                        AddTempNameValueBuffer('VendorOrderAddress', 'VendorNo', VendorNo_OrderAddress);
                        AddTempNameValueBuffer('VendorOrderAddress', 'OrderAddressCode', OrderAddressCode);
                        AddTempNameValueBuffer('VendorOrderAddress', 'LocalNo', LocalNo);
                        AddXMLBufferElements('VendorOrderAddress');
                        TempXMLBuffer.GetParent();
                    end;
                }

                trigger OnAfterAssignVariable();
                begin
                    if not VendorGroupElementCreated then begin
                        TempXMLBuffer.AddGroupElement('VendorLocalPurch');
                        VendorGroupElementCreated := true;
                    end;
                    AddTempNameValueBuffer('VendorLocalPurch', 'No', No);
                    AddTempNameValueBuffer('VendorLocalPurch', 'PurchaserCode', PurchaserCode);
                    AddTempNameValueBuffer('VendorLocalPurch', 'PhoneNo', PhoneNo);
                    AddTempNameValueBuffer('VendorLocalPurch', 'FaxNo', FaxNo);
                    AddTempNameValueBuffer('VendorLocalPurch', 'EmailProcurement', EmailProcurement);
                    AddTempNameValueBuffer('VendorLocalPurch', 'PaymentTermsCode', PaymentTermsCode);
                    AddTempNameValueBuffer('VendorLocalPurch', 'PaymentMethodCode', PaymentMethodCode);
                    AddTempNameValueBuffer('VendorLocalPurch', 'ApplicationMethod', ApplicationMethod);
                    AddTempNameValueBuffer('VendorLocalPurch', 'PartnerType', PartnerType);
                    AddTempNameValueBuffer('VendorLocalPurch', 'ShipmentMethodCode', ShipmentMethodCode);
                    AddTempNameValueBuffer('VendorLocalPurch', 'ShipmentMethodDescription', ShipmentMethodDescription);
                    AddTempNameValueBuffer('VendorLocalPurch', 'CurrencyCode', CurrencyCode);
                    AddTempNameValueBuffer('VendorLocalPurch', 'DepositPaymentTermsCode', DepositPaymentTermsCode);
                    AddTempNameValueBuffer('VendorLocalPurch', 'DepositPaymentMethodCode', DepositPaymentMethodCode);
                    AddTempNameValueBuffer('VendorLocalPurch', 'CalculateItemCharges', CalculateItemCharges);
                    AddTempNameValueBuffer('VendorLocalPurch', 'BlockPaymentTolerance', BlockPaymentTolerance);//HEI.01
                    AddTempNameValueBuffer('VendorLocalPurch', 'SendToMaximo', SendToMaximo);//HEI.02
                    AddTempNameValueBuffer('VendorLocalPurch', 'VendorCategory', VendorCategory);//HEI.03
                    AddTempNameValueBuffer('VendorLocalPurch', 'LocalVendorType', LocalVendorType);//HEI.03
                    AddTempNameValueBuffer('VendorLocalPurch', 'SelfBilling', SelfBilling); //HEI.04
                    AddXMLBufferElements('VendorLocalPurch');
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
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        GlobalID: Integer;
        VendorGroupElementCreated: Boolean;
        OrderAddressCode: Text;

    local procedure AddTempNameValueBuffer(ParentName: Text; Name: Text; var Value: Text);
    begin
        GlobalID := GlobalID + 1;
        TempNameValueBuffer.ID := GlobalID;
        TempNameValueBuffer."Name 2 FND" := ParentName;
        TempNameValueBuffer.Name := Name;
        TempNameValueBuffer.Value := Value;
        TempNameValueBuffer.INSERT();
        Value := '';
    end;

    local procedure AddXMLBufferElements(ParentName: Text);
    begin
        TempNameValueBuffer.RESET();
        TempNameValueBuffer.SETRANGE("Name 2 FND", ParentName);
        if TempNameValueBuffer.findset() then
            repeat
                TempXMLBuffer.AddElement(TempNameValueBuffer.Name, TempNameValueBuffer.Value);
            until TempNameValueBuffer.NEXT() = 0;
        TempNameValueBuffer.DELETEALL();
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

