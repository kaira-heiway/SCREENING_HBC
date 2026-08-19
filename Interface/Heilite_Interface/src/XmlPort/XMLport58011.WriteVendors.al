xmlport 58011 "Write Vendors"
{
    // Heilite Navision Old Id - 50038
    // version HEI.06,HEI.10

    // HEI.01 BA-PURGAP03IBM HORTOC01 22.01.2019 new fields "VendorCategory" and LocalVendorType
    // HEI.02 IBM HORTOC01 26.02.2019 - change the caption of field VendorType to VendorAccountGroup
    // HEI.03 CHG0270793 IBM HORTOC01 04.03.2019 - add field VendorCategory
    // /HEI.04 CHG0246561 HORTOC01 - add field sendtomaximo
    // HEI.05 FDD-HT923 CHG2034529 IBM GUNERE01 30.10.2019 # GlobalVendorID - Import::OnAfterAssignVariable modified
    // HEI.06 FDD-HT545 IBM POSTOI01 27.11.2019
    //   # Self-Billing-Import::OnAfterAssignVariable modified
    //   # new node item in the XMLPort definition
    // HEI.07 CHG2091418 UGMA 17.12.2020 - Corrective change
    //   # Change parameter in line "VendorCategory" from "VendorLocalPurch" to "Vendor" in order to allow receipt and pdate Vendor car through interface with mendix
    //   # Change parameter in line "LocalVendorType" from "VendorLocalPurch" to "Vendor" in order to allow receipt and pdate Vendor car through interface with mendix
    // HEI.08 CHG2162715 HB3020 NORRIQ KOROLA04 14.12.2022
    //   #CheckVendorSPL(), CreateVendorSPLRelation() - created
    // HEI.09 CHG2162715 HB3020 NORRIQ KOROLA04 19.12.2022 - Adding Production location in Purchase orders
    //   #CheckVendorSPL() - modified
    // HEI.10 CHG2162715 HB3020 NORRIQ KOROLA04 19.12.2022 - Adding Production location in Purchase orders
    //   #CheckVendorSPL() - modified


    // BC Upgrade VAMSIU01 >>
    // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer); - Commented(Blocked temporarily as this function is dependent on Dotnet variables).
    // InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); - Added.
    // procedure GetTempBlob(var NewTempBlob: Record TempBlob); - Commented(BLocked as TempBlob Record is obsolete)
    // procedure GetTempBlob(var NewTempBlob: Codeunit ""Temp Blob"");" - Added.
    // TempBlob : Record TempBlob temporary; - Commented(BLocked as TempBlob Record is obsolete)
    // TempBlob: Codeunit "Temp Blob"; -Added
    // BC Upgrade VAMSIU01 <<

    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/WriteVendor';
    UseDefaultNamespace = true;

    schema
    {
        textelement(webVendorWrite)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            textelement(ValidateOnly)
            {
                MaxOccurs = Once;
                MinOccurs = Once;

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('webVendorWrite');
                    TempXMLBuffer.AddElement('ValidateOnly', ValidateOnly);
                end;
            }
            textelement(Vendor)
            {
                MaxOccurs = Unbounded;
                MinOccurs = Zero;
                textelement(No)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Name)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SearchName)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Address)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Address2)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(City)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CountryCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(GLN)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PostCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Name2)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(COName)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(DifferentCity)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(District)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(HouseNumber)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(HouseNumberSupplement)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Street3)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Street4)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Street5)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(VendorAccountGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(FlagForDeletion)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(GlobalVendorID)
                {
                    MaxOccurs = Once;
                    MinOccurs = Once;

                    trigger OnAfterAssignVariable();
                    begin
                        //>> HEI.05
                        SessionGlobals.SetVendorGlobalNo(GlobalVendorID);
                        //<< HEI.05
                    end;
                }
                textelement(Name3)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Name4)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CompanyPostalCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(TypeOfDeliveryService)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(NumberOfDeliveryService)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(POBoxCity)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(POBoxCountry)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(POBoxRegion)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(POBox)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(POBoxPostalCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(POBoxWONo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Region)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(VATRegistrationNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CorporateVendorGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CreditInformationNumber)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ExternalManufacturerCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(IndustryKey)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ReferenceCodeICAndPlant)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(TaxNumber2)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(TaxNumber3)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(TaxNumber4)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(TaxJurisdiction)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(StandardCarrierAccessCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(TaxLiable)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PartnerType)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(LanguageCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(TaxRegistrationNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Profession)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(DateOfBirth)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PlaceOfBirth)
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
                textelement(RentVendorPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(WHTBusinessPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(LoanInterestVendPostGrp)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(LoanVendorPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(LoanInUseVendorPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(MaintenanceVendorPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(OtherVendorPostingGroup)
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
                textelement(ParentLegalEntity)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(VendorDimension)
                {
                    MaxOccurs = Unbounded;
                    MinOccurs = Zero;
                    textelement(vendorno_dim)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        XmlName = 'VendorNo';
                    }
                    textelement(DimCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                    }
                    textelement(DimValueCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }

                    trigger OnAfterAssignVariable();
                    var
                        TableNo: Text;
                        ValuePosting: Text;
                    begin
                        if not VendorGroupElementCreated then begin
                            TempXMLBuffer.AddGroupElement('Vendor');
                            VendorGroupElementCreated := true;
                        end;
                        TempXMLBuffer.AddGroupElement('VendorDimension');
                        TableNo := FORMAT(DATABASE::Vendor);
                        AddTempNameValueBuffer('VendorDimension', 'TableID', TableNo);
                        AddTempNameValueBuffer('VendorDimension', 'VendorNo', VendorNo_Dim);
                        AddTempNameValueBuffer('VendorDimension', 'DimCode', DimCode);
                        AddTempNameValueBuffer('VendorDimension', 'DimValueCode', DimValueCode);
                        ValuePosting := '2';
                        AddTempNameValueBuffer('VendorDimension', 'ValuePosting', ValuePosting);
                        AddXMLBufferElements('VendorDimension');
                        TempXMLBuffer.GetParent();
                    end;
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
                            TempXMLBuffer.AddGroupElement('Vendor');
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
                textelement(VendorBank)
                {
                    MaxOccurs = Unbounded;
                    MinOccurs = Zero;
                    textelement(vendorno_bankacc)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        XmlName = 'VendorNo';
                    }
                    textelement(Code)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(BankBranchNo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(BankAccountNo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(BankAccCurrencyCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(IBAN)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(BankAccName)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(BankAccAddress)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(BankAccCity)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(CountryRegionCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(SWIFTCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(AccountType)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }

                    trigger OnAfterAssignVariable();
                    begin
                        if not VendorGroupElementCreated then begin
                            TempXMLBuffer.AddGroupElement('Vendor');
                            VendorGroupElementCreated := true;
                        end;
                        TempXMLBuffer.AddGroupElement('VendorBank');
                        AddTempNameValueBuffer('VendorBank', 'VendorNo', VendorNo_BankAcc);
                        AddTempNameValueBuffer('VendorBank', 'Code', Code);
                        AddTempNameValueBuffer('VendorBank', 'BankBranchNo', BankBranchNo);
                        AddTempNameValueBuffer('VendorBank', 'BankAccountNo', BankAccountNo);
                        AddTempNameValueBuffer('VendorBank', 'BankAccCurrencyCode', BankAccCurrencyCode);
                        AddTempNameValueBuffer('VendorBank', 'IBAN', IBAN);
                        AddTempNameValueBuffer('VendorBank', 'BankAccName', BankAccName);
                        AddTempNameValueBuffer('VendorBank', 'BankAccAddress', BankAccAddress);
                        AddTempNameValueBuffer('VendorBank', 'BankAccCity', BankAccCity);
                        AddTempNameValueBuffer('VendorBank', 'CountryRegionCode', CountryRegionCode);
                        AddTempNameValueBuffer('VendorBank', 'SWIFTCode', SWIFTCode);
                        AddTempNameValueBuffer('VendorBank', 'AccountType', AccountType);
                        AddXMLBufferElements('VendorBank');
                        TempXMLBuffer.GetParent();
                    end;
                }

                trigger OnAfterAssignVariable();
                begin
                    if not VendorGroupElementCreated then begin
                        TempXMLBuffer.AddGroupElement('Vendor');
                        VendorGroupElementCreated := true;
                    end;

                    //HEI.08 >>
                    if CheckVendorSPL(VendorAccountGroup) then
                        CreateVendorSPLRelation()
                    else begin
                        AddTempNameValueBuffer('Vendor', 'No', No);
                        AddTempNameValueBuffer('Vendor', 'Name', Name);
                        AddTempNameValueBuffer('Vendor', 'SearchName', SearchName);
                        AddTempNameValueBuffer('Vendor', 'Address', Address);
                        AddTempNameValueBuffer('Vendor', 'Address2', Address2);
                        AddTempNameValueBuffer('Vendor', 'City', City);
                        AddTempNameValueBuffer('Vendor', 'CountryCode', CountryCode);
                        AddTempNameValueBuffer('Vendor', 'GLN', GLN);
                        AddTempNameValueBuffer('Vendor', 'PostCode', PostCode);
                        AddTempNameValueBuffer('Vendor', 'Name2', Name2);
                        AddTempNameValueBuffer('Vendor', 'COName', COName);
                        AddTempNameValueBuffer('Vendor', 'DifferentCity', DifferentCity);
                        AddTempNameValueBuffer('Vendor', 'District', District);
                        AddTempNameValueBuffer('Vendor', 'HouseNumber', HouseNumber);
                        AddTempNameValueBuffer('Vendor', 'HouseNumberSupplement', HouseNumberSupplement);
                        AddTempNameValueBuffer('Vendor', 'Street3', Street3);
                        AddTempNameValueBuffer('Vendor', 'Street4', Street4);
                        AddTempNameValueBuffer('Vendor', 'Street5', Street5);
                        AddTempNameValueBuffer('Vendor', 'VendorAccountGroup', VendorAccountGroup);//HEI.02
                        AddTempNameValueBuffer('Vendor', 'FlagForDeletion', FlagForDeletion);
                        AddTempNameValueBuffer('Vendor', 'GlobalVendorID', GlobalVendorID);
                        AddTempNameValueBuffer('Vendor', 'Name3', Name3);
                        AddTempNameValueBuffer('Vendor', 'Name4', Name4);
                        AddTempNameValueBuffer('Vendor', 'CompanyPostalCode', CompanyPostalCode);
                        AddTempNameValueBuffer('Vendor', 'TypeOfDeliveryService', TypeOfDeliveryService);
                        AddTempNameValueBuffer('Vendor', 'NumberOfDeliveryService', NumberOfDeliveryService);
                        AddTempNameValueBuffer('Vendor', 'POBoxCity', POBoxCity);
                        AddTempNameValueBuffer('Vendor', 'POBoxCountry', POBoxCountry);
                        AddTempNameValueBuffer('Vendor', 'POBoxRegion', POBoxRegion);
                        AddTempNameValueBuffer('Vendor', 'POBox', POBox);
                        AddTempNameValueBuffer('Vendor', 'POBoxPostalCode', POBoxPostalCode);
                        AddTempNameValueBuffer('Vendor', 'POBoxWONo', POBoxWONo);
                        AddTempNameValueBuffer('Vendor', 'Region', Region);
                        AddTempNameValueBuffer('Vendor', 'VATRegistrationNo', VATRegistrationNo);
                        AddTempNameValueBuffer('Vendor', 'CorporateVendorGroup', CorporateVendorGroup);
                        AddTempNameValueBuffer('Vendor', 'CreditInformationNumber', CreditInformationNumber);
                        AddTempNameValueBuffer('Vendor', 'ExternalManufacturerCode', ExternalManufacturerCode);
                        AddTempNameValueBuffer('Vendor', 'IndustryKey', IndustryKey);
                        AddTempNameValueBuffer('Vendor', 'ReferenceCodeICAndPlant', ReferenceCodeICAndPlant);
                        AddTempNameValueBuffer('Vendor', 'TaxNumber2', TaxNumber2);
                        AddTempNameValueBuffer('Vendor', 'TaxNumber3', TaxNumber3);
                        AddTempNameValueBuffer('Vendor', 'TaxNumber4', TaxNumber4);
                        AddTempNameValueBuffer('Vendor', 'TaxJurisdiction', TaxJurisdiction);
                        AddTempNameValueBuffer('Vendor', 'StandardCarrierAccessCode', StandardCarrierAccessCode);
                        AddTempNameValueBuffer('Vendor', 'TaxLiable', TaxLiable);
                        AddTempNameValueBuffer('Vendor', 'PartnerType', PartnerType);
                        AddTempNameValueBuffer('Vendor', 'LanguageCode', LanguageCode);
                        AddTempNameValueBuffer('Vendor', 'TaxRegistrationNo', TaxRegistrationNo);
                        AddTempNameValueBuffer('Vendor', 'Profession', Profession);
                        AddTempNameValueBuffer('Vendor', 'DateOfBirth', DateOfBirth);
                        AddTempNameValueBuffer('Vendor', 'PlaceOfBirth', PlaceOfBirth);

                        //OneXml_Finance>>
                        AddTempNameValueBuffer('Vendor', 'Blocked', Blocked);
                        AddTempNameValueBuffer('Vendor', 'BlockedReasonCode', BlockedReasonCode);
                        AddTempNameValueBuffer('Vendor', 'SensitiveBlock', SensitiveBlock);
                        AddTempNameValueBuffer('Vendor', 'EmailFinance', EmailFinance);
                        AddTempNameValueBuffer('Vendor', 'VendorPostingGroup', VendorPostingGroup);
                        AddTempNameValueBuffer('Vendor', 'GenBusPostingGroup', GenBusPostingGroup);
                        AddTempNameValueBuffer('Vendor', 'VATBusPostingGroup', VATBusPostingGroup);
                        AddTempNameValueBuffer('Vendor', 'VendorDepositGroupCode', VendorDepositGroupCode);
                        AddTempNameValueBuffer('Vendor', 'DepositVendorPostingGroup', DepositVendorPostingGroup);
                        AddTempNameValueBuffer('Vendor', 'SplitDepositOnInvoice', SplitDepositOnInvoice);
                        AddTempNameValueBuffer('Vendor', 'GenBusPostingGroupFreeItem', GenBusPostingGroupFreeItem);
                        AddTempNameValueBuffer('Vendor', 'RentVendorPostingGroup', RentVendorPostingGroup);
                        AddTempNameValueBuffer('Vendor', 'WHTBusinessPostingGroup', WHTBusinessPostingGroup);
                        AddTempNameValueBuffer('Vendor', 'LoanInterestVendPostGrp', LoanInterestVendPostGrp);
                        AddTempNameValueBuffer('Vendor', 'LoanVendorPostingGroup', LoanVendorPostingGroup);
                        AddTempNameValueBuffer('Vendor', 'LoanInUseVendorPostingGroup', LoanInUseVendorPostingGroup);
                        AddTempNameValueBuffer('Vendor', 'MaintenanceVendorPostingGroup', MaintenanceVendorPostingGroup);
                        AddTempNameValueBuffer('Vendor', 'OtherVendorPostingGroup', OtherVendorPostingGroup);
                        //OneXml_Finance<<

                        //OneXml_Purch>>
                        AddTempNameValueBuffer('Vendor', 'PurchaserCode', PurchaserCode);
                        AddTempNameValueBuffer('Vendor', 'PhoneNo', PhoneNo);
                        AddTempNameValueBuffer('Vendor', 'FaxNo', FaxNo);
                        AddTempNameValueBuffer('Vendor', 'EmailProcurement', EmailProcurement);
                        AddTempNameValueBuffer('Vendor', 'PaymentTermsCode', PaymentTermsCode);
                        AddTempNameValueBuffer('Vendor', 'PaymentMethodCode', PaymentMethodCode);
                        AddTempNameValueBuffer('Vendor', 'ApplicationMethod', ApplicationMethod);
                        AddTempNameValueBuffer('Vendor', 'ShipmentMethodCode', ShipmentMethodCode);
                        AddTempNameValueBuffer('Vendor', 'ShipmentMethodDescription', ShipmentMethodDescription);
                        AddTempNameValueBuffer('Vendor', 'CurrencyCode', CurrencyCode);
                        AddTempNameValueBuffer('Vendor', 'DepositPaymentTermsCode', DepositPaymentTermsCode);
                        AddTempNameValueBuffer('Vendor', 'DepositPaymentMethodCode', DepositPaymentMethodCode);
                        AddTempNameValueBuffer('Vendor', 'CalculateItemCharges', CalculateItemCharges);
                        AddTempNameValueBuffer('Vendor', 'BlockPaymentTolerance', BlockPaymentTolerance);
                        AddTempNameValueBuffer('Vendor', 'SendToMaximo', SendToMaximo);
                        AddTempNameValueBuffer('Vendor', 'SelfBilling', SelfBilling); //HEI.06
                        AddTempNameValueBuffer('Vendor', 'VendorCategory', VendorCategory);//HEI.01 HEI.07
                        AddTempNameValueBuffer('Vendor', 'LocalVendorType', LocalVendorType);//HEI.01 HEI.07
                        AddTempNameValueBuffer('VendorLocalPurch', 'SelfBilling', SelfBilling); //HEI.06
                                                                                                //OneXml_Purch<<
                    end;
                    //HEI.08 <<

                    AddXMLBufferElements('Vendor');
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
        InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); //BC Upgrade VAMSIU01 - Added.
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
        SessionGlobals: Codeunit "Session Globals";

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

    local procedure CheckVendorSPL(IAccountGroup: Text[30]): Boolean;
    var
        PurchSetup: Record "Purchases & Payables Setup";
        ErrParentLegalEntity: Label 'Tag ParentLegalEntity must be empty. Vendor SPL is not active.';
        ErrParentLegalEntityIsEmpty: Label 'Tag ParentLegalEntity must not be empty.';
        Vendor: Record Vendor;
        ErrGlobalVendorID: Label 'GlobalID must not be empty!';
        ErrVendor: TextConst ENU = 'Vendor with Global Vendor Number = %1 has not been found!';
    begin
        //HEI.08 >>
        PurchSetup.GET();
        if not PurchSetup."SPL Active FND" then begin
            if ParentLegalEntity <> '' then
                ERROR(ErrParentLegalEntity);

            exit(false);
        end;

        //HEI.10 >>
        if (ParentLegalEntity = '') and (PurchSetup."SPL Account Group FND" <> IAccountGroup) then
            exit(false);
        //HEI.10 <<

        PurchSetup.TESTFIELD("SPL Account Group FND");
        if ParentLegalEntity = '' then
            ERROR(ErrParentLegalEntityIsEmpty);

        if IAccountGroup = PurchSetup."SPL Account Group FND" then begin
            Vendor.SETRANGE("Global Vendor Number FND", ParentLegalEntity);
            if Vendor.ISEMPTY then
                ERROR(ErrVendor, ParentLegalEntity);

            if GlobalVendorID = '' then
                ERROR(ErrGlobalVendorID);
            exit(true);
        end;

        exit(false);
        //HEI.08 <<
    end;

    local procedure CreateVendorSPLRelation();
    begin
        //HEI.08 >>
        TempXMLBuffer.AddGroupElement('VendorSPLRelation');//HEI.09
        AddTempNameValueBuffer('VendorSPLRelation', 'No', No);
        AddTempNameValueBuffer('VendorSPLRelation', 'Name', Name);
        AddTempNameValueBuffer('VendorSPLRelation', 'SearchName', SearchName);
        AddTempNameValueBuffer('VendorSPLRelation', 'Address', Address);
        AddTempNameValueBuffer('VendorSPLRelation', 'Address2', Address2);
        AddTempNameValueBuffer('VendorSPLRelation', 'City', City);
        AddTempNameValueBuffer('VendorSPLRelation', 'CountryCode', CountryCode);
        AddTempNameValueBuffer('VendorSPLRelation', 'GLN', GLN);
        AddTempNameValueBuffer('VendorSPLRelation', 'PostCode', PostCode);
        AddTempNameValueBuffer('VendorSPLRelation', 'Name2', Name2);
        AddTempNameValueBuffer('VendorSPLRelation', 'COName', COName);
        AddTempNameValueBuffer('VendorSPLRelation', 'DifferentCity', DifferentCity);
        AddTempNameValueBuffer('VendorSPLRelation', 'District', District);
        AddTempNameValueBuffer('VendorSPLRelation', 'HouseNumber', HouseNumber);
        AddTempNameValueBuffer('VendorSPLRelation', 'HouseNumberSupplement', HouseNumberSupplement);
        AddTempNameValueBuffer('VendorSPLRelation', 'Street3', Street3);
        AddTempNameValueBuffer('VendorSPLRelation', 'Street4', Street4);
        AddTempNameValueBuffer('VendorSPLRelation', 'Street5', Street5);
        AddTempNameValueBuffer('VendorSPLRelation', 'VendorAccountGroup', VendorAccountGroup);
        AddTempNameValueBuffer('VendorSPLRelation', 'FlagForDeletion', FlagForDeletion);
        AddTempNameValueBuffer('VendorSPLRelation', 'GlobalVendorID', GlobalVendorID);
        AddTempNameValueBuffer('VendorSPLRelation', 'Name3', Name3);
        AddTempNameValueBuffer('VendorSPLRelation', 'Name4', Name4);
        AddTempNameValueBuffer('VendorSPLRelation', 'CompanyPostalCode', CompanyPostalCode);
        AddTempNameValueBuffer('VendorSPLRelation', 'TypeOfDeliveryService', TypeOfDeliveryService);
        AddTempNameValueBuffer('VendorSPLRelation', 'NumberOfDeliveryService', NumberOfDeliveryService);
        AddTempNameValueBuffer('VendorSPLRelation', 'POBoxCity', POBoxCity);
        AddTempNameValueBuffer('VendorSPLRelation', 'POBoxCountry', POBoxCountry);
        AddTempNameValueBuffer('VendorSPLRelation', 'POBoxRegion', POBoxRegion);
        AddTempNameValueBuffer('VendorSPLRelation', 'POBox', POBox);
        AddTempNameValueBuffer('VendorSPLRelation', 'POBoxPostalCode', POBoxPostalCode);
        AddTempNameValueBuffer('VendorSPLRelation', 'POBoxWONo', POBoxWONo);
        AddTempNameValueBuffer('VendorSPLRelation', 'Region', Region);
        AddTempNameValueBuffer('VendorSPLRelation', 'VATRegistrationNo', VATRegistrationNo);
        AddTempNameValueBuffer('VendorSPLRelation', 'CorporateVendorGroup', CorporateVendorGroup);
        AddTempNameValueBuffer('VendorSPLRelation', 'CreditInformationNumber', CreditInformationNumber);
        AddTempNameValueBuffer('VendorSPLRelation', 'ExternalManufacturerCode', ExternalManufacturerCode);
        AddTempNameValueBuffer('VendorSPLRelation', 'IndustryKey', IndustryKey);
        AddTempNameValueBuffer('VendorSPLRelation', 'ReferenceCodeICAndPlant', ReferenceCodeICAndPlant);
        AddTempNameValueBuffer('VendorSPLRelation', 'TaxNumber2', TaxNumber2);
        AddTempNameValueBuffer('VendorSPLRelation', 'TaxNumber3', TaxNumber3);
        AddTempNameValueBuffer('VendorSPLRelation', 'TaxNumber4', TaxNumber4);
        AddTempNameValueBuffer('VendorSPLRelation', 'TaxJurisdiction', TaxJurisdiction);
        AddTempNameValueBuffer('VendorSPLRelation', 'StandardCarrierAccessCode', StandardCarrierAccessCode);
        AddTempNameValueBuffer('VendorSPLRelation', 'TaxLiable', TaxLiable);
        AddTempNameValueBuffer('VendorSPLRelation', 'PartnerType', PartnerType);
        AddTempNameValueBuffer('VendorSPLRelation', 'LanguageCode', LanguageCode);
        AddTempNameValueBuffer('VendorSPLRelation', 'TaxRegistrationNo', TaxRegistrationNo);
        AddTempNameValueBuffer('VendorSPLRelation', 'Profession', Profession);
        AddTempNameValueBuffer('VendorSPLRelation', 'DateOfBirth', DateOfBirth);
        AddTempNameValueBuffer('VendorSPLRelation', 'PlaceOfBirth', PlaceOfBirth);
        AddTempNameValueBuffer('VendorSPLRelation', 'ParentLegalEntity', ParentLegalEntity);
        AddXMLBufferElements('VendorSPLRelation');
        TempXMLBuffer.GetParent();
        //HEI.08 <<
    end;
}

