xmlport 58009 "Write Customer"
{
    // Heilite Navision Old Id - 50026
    // version HEI.18

    // HEI.01 FDD-SLSGAP020 IBM HORTOC01 #new xmlport - customer mendix interface
    // HEI.02 IBM HORTOC01 # align READ/WRITE ws
    // HEI.03 IBM HORTOC01 08.03.2019 # add customerddepositgroupcode
    // HEI.04 IBM HORTOC01 20.03.2019 # add new field "Vendor No"
    // HEI.05 IBM NASTAA02 26.08.2019 # Added new Fields
    //   # "Deposit Limit" and "Deposit Limit (LCY)" from Customer Table
    //   # "Payment Valid from", "Payment Valid to", "License Valid from" and "License Valid to" from Customer Attributes Table
    // HEI.06 IBM BULIMC01 14/10/2019 # Added new Field: "ClassificationFND"
    // HEI.07 IBM BULIMC01 15/11/2019 #Code added for Customer Code Sharing
    // HEI.08 FDD-HT BULIMC01 IBM 18.11.2019# New field added: "Contract Type"
    // HEI.09 FDD-HT788 IBM GAVANM01 27.04.2020 #Customer Code Sharing
    //   - New code added: Account Group and VAT Registration No. added to the concatenation
    // HEI.10 CHG2068464 IBM.GAVANM01 23.07.2020 Intercompany billing
    //   # New fields added: "Purchasing code" and "Send Document"
    // HEI.11 CHG2073953 IBM.GAVANM01 16.09.2020 Interface fields geo coordinates and delivery windows
    //   # New fields added: LatitudeCoordinates, LongitudeCoordinates and Delivery Times fields
    // HEI.12 CHG2099832 HB2080 IBM.GAVANM01 05.03.2021 #Add Customer Tax Group field to Mendix-Heilite Interface
    //   # New field added: CustomerTaxGroup
    // HEI.13 CHG2129700 INC3758798 IBM GAVANM01 06.10.2021 #SEM ID is not available for Mendix
    //   # New field added: SEMId
    // HEI.14 CHG2132219 HB2607 IBM GAVANM01 25.01.2022 #Customer Creation Integration with Mendix (SEPA)
    //   # New fields added: SEPA,CustBankAcc,ValidFrom,ValidTo,DateOfSignature,TypeOfPayment,IsBlocked,ExpectedNoOfDebits,Closed
    // HEI.15 CHG2132219 HB2607 IBM GAVANM01 08.02.2022 #Customer Creation Integration with Mendix (SEPA)
    //   # New field added: ID
    // HEI.17 CHG2132219 HB2607 IBM BHANDS01 23.06.2022 #Customer Creation Integration with Mendix (SEPA)
    //   # New field added: TransitNo in CustomerBankAccount
    //   # Clearing up of Temporary Variables
    // HEI.18 CHG2178940 HB2899 IBM COSTES04 16.01.2023 #Add "Required Freshness" field to Mendix-Heilite Interface
    //   # New field added: RequiredFreshness
    // HEI.16 CHG2154294 HB2899 IBM BHANDS01 02.06.2022 #Add "Trading End Date" field to Mendix-Heilite Interface
    //   # New field added: TradingEndDate

    // BC Upgrade VAMSIU01 >>
    // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer); - Commented(Blocked temporarily as this function is dependent on Dotnet variables).
    // InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); - Added.
    // procedure GetTempBlob(var NewTempBlob: Record TempBlob); - Commented(BLocked as TempBlob Record is obsolete)
    // procedure GetTempBlob(var NewTempBlob: Codeunit ""Temp Blob"");" - Added.
    // TempBlob : Record TempBlob temporary; - Commented(BLocked as TempBlob Record is obsolete)
    // TempBlob: Codeunit "Temp Blob"; -Added
    // BC Upgrade VAMSIU01 <<

    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/WriteCustomer';
    UseDefaultNamespace = true;

    schema
    {
        textelement(webCustomerWrite)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            textelement(ValidateOnly)
            {
                MaxOccurs = Once;
                MinOccurs = Once;

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('webCustomerWrite');
                    TempXMLBuffer.AddElement('ValidateOnly', ValidateOnly);
                end;
            }
            textelement(Customer)
            {
                MaxOccurs = Unbounded;
                MinOccurs = Once;
                textelement(AccountGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(No)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Name1)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SearchName)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Name2)
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
                textelement(PostalCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(City)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CreditLimitLCY)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SalesPersonCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CountryRegionCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Blocked)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(County)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ServiceZoneCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CreditLimit)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CustomerTemplateCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CustomerPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CustomerDDepositGroupCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ContractCustPostGrRent)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ContractCustPostGrLoan)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ContractCustPostGrLoanU)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ContractCustPostGrMaint)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ContractCustPostGrOther)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ContractCustPostGrPlant)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(LoanInterestCustPostGrp)
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
                textelement(Email)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CustomerPriceGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(InvoiceDiscCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(InvoiceCopies)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(BillToCustNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PriceInclVAT)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(GenBusPostingGr)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(GLN)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(VatBusPostingGr)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PrepaymentPercent)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(AllowLineDisc)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(RiskCategory)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ReturnOrderMandatory)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(InvoiceMethod)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(InvoicePeriod)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(EmptyGoodsStatementOn)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ExtDocNoMandatory)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PaymentTermsCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(FinChargeTermsCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(LastStatementNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PrintStatement)
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
                textelement(ReminderTermsCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(BlockPaymentTolerance)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PartnerType)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PreferredBankAccount)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CashFlowPaymentTermsCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CustomerBalanceLCY)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CurrencyCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Language)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(VATRegistrationNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SplitDepositOnInvoice)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(AutomItemCharge)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(TaxRegistrationNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(FiscalRepresentativeNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(GenBusPostingGrFree)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(FreeItemPostingType)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(FreeItem)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(FreeReasonCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Exclusivity)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(WHTBusPostingGr)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ShortcutProperty1Code)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ShortcutProperty2Code)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ShortcutDim1Code)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ShortcutDim2Code)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(LocationCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(TaxAreaCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(TaxLiable)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ApprovalForAlcohol)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(BlockedReasonCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(RiskScores)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(RPMExposure)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PackagingCreditValue)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CheckFFEBalSecurityAmt)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(AdditionalRPMReturn)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ShipmentMethodCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ShippingAgentCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CombineShipments)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Reserve)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ShippingAdvice)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ShippingTime)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ShippingAgentServiceCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(BaseCalendarCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(TruckZone)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ShipmentDateFormula)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Require2Drivers)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CustomerDeliveryType)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Distance)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Route)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(DeliveryNoteCopies)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(DeliverySequence)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PickingType)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(EmptyReturnedItemBased)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SalesRoutes)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Contact)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(VendorNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(DepositLimit)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(DepositLimitLCY)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ContractType)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PurchasingCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SendDocument)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(LongitudeCoordinates)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(LatitudeCoordinates)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CustomerTaxGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SEMId)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(TradingEndDate)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(RequiredFreshness)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CustomerAttributes)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    textelement(StrategicIndicator)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(LocalKeyAccount)
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
                    textelement(HouseNo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(HouseNoSupplement)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
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
                    textelement(SearchTerm)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(Search2)
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
                    textelement(FlagForDeletion)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(COName)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(CompanyPostalCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(NumberOFDeliveryService)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(OtherCity)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(OtherRegion)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(OtherCountry)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(POBoxNo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(POBoxPostalCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(POBoWoNo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(TyprOfDeliveryService)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(TaxNumber1)
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
                    textelement(InvoiceEmailAddress)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(LicenseNo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(LicenseType)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(BusinessSegment)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(BusinesOrganizationalSegment)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(CustomerType)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(CustomerSubTypeChannel)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(LocalCustomerSubTypeChannel)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(TradingPartner)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(RegistreDeCommerce)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(ArticleDImposition)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(NIS)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(NIF)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(VisitDay)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(LegalFrom)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(MarketType)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(PaymentValidFrom)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(PaymentValidTo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(LicenseValidFrom)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(LicenseValidTo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(ClassificationFND)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }

                    trigger OnAfterAssignVariable();
                    begin
                        if not CustomerGroupElementCreated then begin
                            TempXMLBuffer.AddGroupElement('Customer');
                            CustomerGroupElementCreated := true;
                        end;
                        CustomerDescription := POBoxNo + HouseNo + Street3 + Street4 + Street5;
                        CLEAR(CustNo);
                        CustNo := No;
                        TempXMLBuffer.AddGroupElement('CustomerAttributes');
                        AddTempNameValueBuffer('CustomerAttributes', 'CustomerNo', CustNo);
                        AddTempNameValueBuffer('CustomerAttributes', 'StrategicIndicator', StrategicIndicator);
                        AddTempNameValueBuffer('CustomerAttributes', 'LocalKeyAccount', LocalKeyAccount);
                        AddTempNameValueBuffer('CustomerAttributes', 'DifferentCity', DifferentCity);
                        AddTempNameValueBuffer('CustomerAttributes', 'District', District);
                        AddTempNameValueBuffer('CustomerAttributes', 'HouseNo', HouseNo);
                        AddTempNameValueBuffer('CustomerAttributes', 'HouseNoSupplement', HouseNoSupplement);
                        AddTempNameValueBuffer('CustomerAttributes', 'Name3', Name3);
                        AddTempNameValueBuffer('CustomerAttributes', 'Name4', Name4);
                        AddTempNameValueBuffer('CustomerAttributes', 'SearchTerm', SearchTerm);
                        AddTempNameValueBuffer('CustomerAttributes', 'Street3', Street3);
                        AddTempNameValueBuffer('CustomerAttributes', 'Street4', Street4);
                        AddTempNameValueBuffer('CustomerAttributes', 'Street5', Street5);
                        AddTempNameValueBuffer('CustomerAttributes', 'FlagForDeletion', FlagForDeletion);
                        AddTempNameValueBuffer('CustomerAttributes', 'COName', COName);
                        AddTempNameValueBuffer('CustomerAttributes', 'CompanyPostalCode', CompanyPostalCode);
                        AddTempNameValueBuffer('CustomerAttributes', 'NumberOFDeliveryService', NumberOFDeliveryService);
                        AddTempNameValueBuffer('CustomerAttributes', 'OtherCity', OtherCity);
                        AddTempNameValueBuffer('CustomerAttributes', 'OtherCountry', OtherCountry);
                        AddTempNameValueBuffer('CustomerAttributes', 'OtherRegion', OtherRegion);
                        AddTempNameValueBuffer('CustomerAttributes', 'POBoxNo', POBoxNo);
                        AddTempNameValueBuffer('CustomerAttributes', 'POBoxPostalCode', POBoxPostalCode);
                        AddTempNameValueBuffer('CustomerAttributes', 'POBoWoNo', POBoWoNo);
                        AddTempNameValueBuffer('CustomerAttributes', 'TyprOfDeliveryService', TyprOfDeliveryService);
                        AddTempNameValueBuffer('CustomerAttributes', 'TaxNumber2', TaxNumber2);
                        AddTempNameValueBuffer('CustomerAttributes', 'TaxNumber3', TaxNumber3);
                        AddTempNameValueBuffer('CustomerAttributes', 'TaxNumber4', TaxNumber4);
                        AddTempNameValueBuffer('CustomerAttributes', 'InvoiceEmailAddress', InvoiceEmailAddress);
                        AddTempNameValueBuffer('CustomerAttributes', 'LicenseNo', LicenseNo);
                        AddTempNameValueBuffer('CustomerAttributes', 'LicenseType', LicenseType);
                        AddTempNameValueBuffer('CustomerAttributes', 'BusinessSegment', BusinessSegment);
                        AddTempNameValueBuffer('CustomerAttributes', 'BusinesOrganizationalSegment', BusinesOrganizationalSegment);
                        AddTempNameValueBuffer('CustomerAttributes', 'CustomerType', CustomerType);
                        AddTempNameValueBuffer('CustomerAttributes', 'CustomerSubTypeChannel', CustomerSubTypeChannel);
                        AddTempNameValueBuffer('CustomerAttributes', 'LocalCustomerSubTypeChannel', LocalCustomerSubTypeChannel);
                        AddTempNameValueBuffer('CustomerAttributes', 'TradingPartner', TradingPartner);
                        AddTempNameValueBuffer('CustomerAttributes', 'RegistreDeCommerce', RegistreDeCommerce);
                        AddTempNameValueBuffer('CustomerAttributes', 'ArticleDImposition', ArticleDImposition);
                        AddTempNameValueBuffer('CustomerAttributes', 'NIS', NIS);
                        AddTempNameValueBuffer('CustomerAttributes', 'NIF', NIF);
                        AddTempNameValueBuffer('CustomerAttributes', 'VisitDay', VisitDay);
                        AddTempNameValueBuffer('CustomerAttributes', 'LegalFrom', LegalFrom);
                        AddTempNameValueBuffer('CustomerAttributes', 'MarketType', MarketType);
                        //HEI.05>>
                        AddTempNameValueBuffer('CustomerAttributes', 'PaymentValidFrom', PaymentValidFrom);
                        AddTempNameValueBuffer('CustomerAttributes', 'PaymentValidTo', PaymentValidTo);
                        AddTempNameValueBuffer('CustomerAttributes', 'LicenseValidFrom', LicenseValidFrom);
                        AddTempNameValueBuffer('CustomerAttributes', 'LicenseValidTo', LicenseValidTo);
                        //HEI.05<<
                        //HEI.02>>
                        AddTempNameValueBuffer('CustomerAttributes', 'TaxNumber1', TaxNumber1);
                        AddTempNameValueBuffer('CustomerAttributes', 'Search2', Search2);
                        //HEI.02<<
                        AddTempNameValueBuffer('CustomerAttributes', 'ClassificationFND', ClassificationFND); //HEI.06
                        AddXMLBufferElements('CustomerAttributes');
                        TempXMLBuffer.GetParent();
                    end;
                }
                textelement(CustomerBankAccount)
                {
                    MaxOccurs = Unbounded;
                    MinOccurs = Zero;
                    textelement(CustBankAccCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(CustBankAccName)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(CustBankAccCity)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(CustBankAccPostCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(CustBankAccBankBranchNo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(CustBankAccBankAccountNo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(CustBankAccCurrencyCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(CustBankAccCountryRegionCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(CustBankAccIban)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(CustBankAccSwiftCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(TransitNo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }

                    trigger OnAfterAssignVariable();
                    begin
                        if not CustomerGroupElementCreated then begin
                            TempXMLBuffer.AddGroupElement('Customer');
                            CustomerGroupElementCreated := true;
                        end;
                        CLEAR(CustBankAccCustNo);
                        CustBankAccCustNo := No;
                        TempXMLBuffer.AddGroupElement('CustomerBankAccount');
                        AddTempNameValueBuffer('CustomerBankAccount', 'CustBankAccCustomerNo', CustBankAccCustNo);
                        AddTempNameValueBuffer('CustomerBankAccount', 'CustBankAccCode', CustBankAccCode);
                        AddTempNameValueBuffer('CustomerBankAccount', 'CustBankAccName', CustBankAccName);
                        AddTempNameValueBuffer('CustomerBankAccount', 'CustBankAccCity', CustBankAccCity);
                        AddTempNameValueBuffer('CustomerBankAccount', 'CustBankAccPostCode', CustBankAccPostCode);
                        AddTempNameValueBuffer('CustomerBankAccount', 'CustBankAccBankBranchNo', CustBankAccBankBranchNo);
                        AddTempNameValueBuffer('CustomerBankAccount', 'CustBankAccBankAccountNo', CustBankAccBankAccountNo);
                        AddTempNameValueBuffer('CustomerBankAccount', 'CustBankAccCurrencyCode', CustBankAccCurrencyCode);
                        AddTempNameValueBuffer('CustomerBankAccount', 'CustBankAccCountryRegionCode', CustBankAccCountryRegionCode);
                        AddTempNameValueBuffer('CustomerBankAccount', 'CustBankAccIban', CustBankAccIban);
                        AddTempNameValueBuffer('CustomerBankAccount', 'CustBankAccSwiftCode', CustBankAccSwiftCode);
                        AddTempNameValueBuffer('CustomerBankAccount', 'TransitNo', TransitNo);  //HEI.17
                        AddXMLBufferElements('CustomerBankAccount');
                        TempXMLBuffer.GetParent();
                    end;
                }
                textelement(DeliveryTimes)
                {
                    MaxOccurs = Unbounded;
                    MinOccurs = Zero;
                    textelement(DayOfTheWeek)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(DeliveryTime1From)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(DeliveryTime1To)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(DeliveryTime2From)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(DeliveryTime2To)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }

                    trigger OnAfterAssignVariable();
                    begin
                        //<<HEI.11
                        if not CustomerGroupElementCreated then begin
                            TempXMLBuffer.AddGroupElement('Customer');
                            CustomerGroupElementCreated := true;
                        end;
                        CLEAR(DeliveryCustomerNo);
                        DeliveryCustomerNo := No;
                        SourceType := '0';  //type customer
                        TempXMLBuffer.AddGroupElement('DeliveryTimes');
                        AddTempNameValueBuffer('DeliveryTimes', 'SourceType', SourceType);
                        AddTempNameValueBuffer('DeliveryTimes', 'CustomerNumber', DeliveryCustomerNo);
                        AddTempNameValueBuffer('DeliveryTimes', 'DayOfTheWeek', DayOfTheWeek);
                        AddTempNameValueBuffer('DeliveryTimes', 'DeliveryTime1From', DeliveryTime1From);
                        AddTempNameValueBuffer('DeliveryTimes', 'DeliveryTime1To', DeliveryTime1To);
                        AddTempNameValueBuffer('DeliveryTimes', 'DeliveryTime2From', DeliveryTime2From);
                        AddTempNameValueBuffer('DeliveryTimes', 'DeliveryTime2To', DeliveryTime2To);
                        AddXMLBufferElements('DeliveryTimes');
                        TempXMLBuffer.GetParent();
                        //>>HEI.11
                    end;
                }
                textelement(SEPA)
                {
                    MinOccurs = Zero;
                    textelement(ID)
                    {
                    }
                    textelement(CustBankAcc)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(ValidFrom)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(ValidTo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(DateOfSignature)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(TypeOfPayment)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(IsBlocked)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(ExpectedNoOfDebits)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(Closed)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }

                    trigger OnAfterAssignVariable();
                    begin
                        //HEI.14<<
                        if not CustomerGroupElementCreated then begin
                            TempXMLBuffer.AddGroupElement('Customer');
                            CustomerGroupElementCreated := true;
                        end;
                        CLEAR(SEPACustNo);
                        SEPACustNo := No;
                        TempXMLBuffer.AddGroupElement('SEPA');
                        AddTempNameValueBuffer('SEPA', 'CustomerNo', SEPACustNo);
                        AddTempNameValueBuffer('SEPA', 'ID', ID);   //HEI.15
                        AddTempNameValueBuffer('SEPA', 'CustBankAcc', CustBankAcc);
                        AddTempNameValueBuffer('SEPA', 'ValidFrom', ValidFrom);
                        AddTempNameValueBuffer('SEPA', 'ValidTo', ValidTo);
                        AddTempNameValueBuffer('SEPA', 'DateOfSignature', DateOfSignature);
                        AddTempNameValueBuffer('SEPA', 'TypeOfPayment', TypeOfPayment);
                        AddTempNameValueBuffer('SEPA', 'IsBlocked', IsBlocked);
                        AddTempNameValueBuffer('SEPA', 'ExpectedNoOfDebits', ExpectedNoOfDebits);
                        AddTempNameValueBuffer('SEPA', 'Closed', Closed);
                        AddXMLBufferElements('SEPA');
                        TempXMLBuffer.GetParent();
                        //HEI.14>>
                    end;
                }

                trigger OnAfterAssignVariable();
                begin
                    if not CustomerGroupElementCreated then begin
                        TempXMLBuffer.AddGroupElement('Customer');
                        CustomerGroupElementCreated := true;
                    end;

                    //CustomerDescription += Name1 + Address + Address2 + City;             //commented by HEI.09
                    CustomerDescription += Name1 + Address + Address2 + City + AccountGroup + VATRegistrationNo;      //HEI.09
                    CustomerDescription := DELCHR(CustomerDescription, '=', ' ');
                    //HEI.07<<
                    SessionGlobals.SetCustomerGlobalNo(CustomerDescription);
                    //HEI.07>>

                    AddTempNameValueBuffer('Customer', 'AccountGroup', AccountGroup);
                    AddTempNameValueBuffer('Customer', 'No', No);
                    AddTempNameValueBuffer('Customer', 'Name1', Name1);
                    AddTempNameValueBuffer('Customer', 'SearchName', SearchName);
                    AddTempNameValueBuffer('Customer', 'Name2', Name2);
                    AddTempNameValueBuffer('Customer', 'Address', Address);
                    AddTempNameValueBuffer('Customer', 'Address2', Address2);
                    AddTempNameValueBuffer('Customer', 'PostalCode', PostalCode);
                    AddTempNameValueBuffer('Customer', 'City', City);
                    AddTempNameValueBuffer('Customer', 'CreditLimitLCY', CreditLimitLCY);
                    AddTempNameValueBuffer('Customer', 'SalesPersonCode', SalesPersonCode);
                    AddTempNameValueBuffer('Customer', 'CountryRegionCode', CountryRegionCode);
                    AddTempNameValueBuffer('Customer', 'Blocked', Blocked);
                    AddTempNameValueBuffer('Customer', 'County', County);
                    AddTempNameValueBuffer('Customer', 'ServiceZoneCode', ServiceZoneCode);
                    AddTempNameValueBuffer('Customer', 'CreditLimit', CreditLimit);
                    AddTempNameValueBuffer('Customer', 'CustomerTemplateCode', CustomerTemplateCode);
                    AddTempNameValueBuffer('Customer', 'CustomerPostingGroup', CustomerPostingGroup);
                    AddTempNameValueBuffer('Customer', 'CustomerDDepositGroupCode', CustomerDDepositGroupCode);//HEI.03
                    AddTempNameValueBuffer('Customer', 'ContractCustPostGrRent', ContractCustPostGrRent);
                    AddTempNameValueBuffer('Customer', 'ContractCustPostGrLoan', ContractCustPostGrLoan);
                    AddTempNameValueBuffer('Customer', 'ContractCustPostGrLoanU', ContractCustPostGrLoanU);
                    AddTempNameValueBuffer('Customer', 'ContractCustPostGrMaint', ContractCustPostGrMaint);
                    AddTempNameValueBuffer('Customer', 'ContractCustPostGrOther', ContractCustPostGrOther);
                    AddTempNameValueBuffer('Customer', 'ContractCustPostGrPlant', ContractCustPostGrPlant);
                    AddTempNameValueBuffer('Customer', 'LoanInterestCustPostGrp', LoanInterestCustPostGrp);
                    AddTempNameValueBuffer('Customer', 'PhoneNo', PhoneNo);
                    AddTempNameValueBuffer('Customer', 'FaxNo', FaxNo);
                    AddTempNameValueBuffer('Customer', 'Email', Email);
                    AddTempNameValueBuffer('Customer', 'CustomerPriceGroup', CustomerPriceGroup);
                    AddTempNameValueBuffer('Customer', 'InvoiceDiscCode', InvoiceDiscCode);
                    AddTempNameValueBuffer('Customer', 'InvoiceCopies', InvoiceCopies);
                    AddTempNameValueBuffer('Customer', 'BillToCustNo', BillToCustNo);
                    AddTempNameValueBuffer('Customer', 'PriceInclVAT', PriceInclVAT);
                    AddTempNameValueBuffer('Customer', 'GenBusPostingGr', GenBusPostingGr);
                    AddTempNameValueBuffer('Customer', 'GLN', GLN);
                    AddTempNameValueBuffer('Customer', 'VatBusPostingGr', VatBusPostingGr);
                    AddTempNameValueBuffer('Customer', 'PrepaymentPercent', PrepaymentPercent);
                    AddTempNameValueBuffer('Customer', 'AllowLineDisc', AllowLineDisc);
                    AddTempNameValueBuffer('Customer', 'RiskCategory', RiskCategory);
                    AddTempNameValueBuffer('Customer', 'ReturnOrderMandatory', ReturnOrderMandatory);
                    AddTempNameValueBuffer('Customer', 'InvoiceMethod', InvoiceMethod);
                    AddTempNameValueBuffer('Customer', 'InvoicePeriod', InvoicePeriod);
                    AddTempNameValueBuffer('Customer', 'EmptyGoodsStatementOn', EmptyGoodsStatementOn);
                    AddTempNameValueBuffer('Customer', 'ExtDocNoMandatory', ExtDocNoMandatory);
                    AddTempNameValueBuffer('Customer', 'PaymentTermsCode', PaymentTermsCode);
                    AddTempNameValueBuffer('Customer', 'FinChargeTermsCode', FinChargeTermsCode);
                    AddTempNameValueBuffer('Customer', 'LastStatementNo', LastStatementNo);
                    AddTempNameValueBuffer('Customer', 'PrintStatement', PrintStatement);
                    AddTempNameValueBuffer('Customer', 'PaymentMethodCode', PaymentMethodCode);
                    AddTempNameValueBuffer('Customer', 'ApplicationMethod', ApplicationMethod);
                    AddTempNameValueBuffer('Customer', 'ReminderTermsCode', ReminderTermsCode);
                    AddTempNameValueBuffer('Customer', 'BlockPaymentTolerance', BlockPaymentTolerance);
                    AddTempNameValueBuffer('Customer', 'PartnerType', PartnerType);
                    AddTempNameValueBuffer('Customer', 'PreferredBankAccount', PreferredBankAccount);
                    AddTempNameValueBuffer('Customer', 'CashFlowPaymentTermsCode', CashFlowPaymentTermsCode);
                    AddTempNameValueBuffer('Customer', 'CustomerBalanceLCY', CustomerBalanceLCY);
                    AddTempNameValueBuffer('Customer', 'CurrencyCode', CurrencyCode);
                    AddTempNameValueBuffer('Customer', 'Language', Language);
                    AddTempNameValueBuffer('Customer', 'VATRegistrationNo', VATRegistrationNo);
                    AddTempNameValueBuffer('Customer', 'SplitDepositOnInvoice', SplitDepositOnInvoice);
                    AddTempNameValueBuffer('Customer', 'AutomItemCharge', AutomItemCharge);
                    AddTempNameValueBuffer('Customer', 'TaxRegistrationNo', TaxRegistrationNo);
                    AddTempNameValueBuffer('Customer', 'FiscalRepresentativeNo', FiscalRepresentativeNo);
                    AddTempNameValueBuffer('Customer', 'GenBusPostingGrFree', GenBusPostingGrFree);
                    AddTempNameValueBuffer('Customer', 'FreeItemPostingType', FreeItemPostingType);
                    AddTempNameValueBuffer('Customer', 'FreeItem', FreeItem);
                    AddTempNameValueBuffer('Customer', 'FreeReasonCode', FreeReasonCode);
                    AddTempNameValueBuffer('Customer', 'Exclusivity', Exclusivity);
                    AddTempNameValueBuffer('Customer', 'WHTBusPostingGr', WHTBusPostingGr);
                    AddTempNameValueBuffer('Customer', 'DepositLimit', DepositLimit); //HEI.05
                    AddTempNameValueBuffer('Customer', 'DepositLimitLCY', DepositLimitLCY); //HEI.05
                    //HEI.02>>
                    AddTempNameValueBuffer('Customer', 'ShortcutProperty1Code', ShortcutProperty1Code);
                    AddTempNameValueBuffer('Customer', 'ShortcutProperty2Code', ShortcutProperty2Code);
                    AddTempNameValueBuffer('Customer', 'ShipmentMethodCode', ShipmentMethodCode);
                    AddTempNameValueBuffer('Customer', 'ShippingAgentCode', ShippingAgentCode);
                    AddTempNameValueBuffer('Customer', 'CombineShipments', CombineShipments);
                    AddTempNameValueBuffer('Customer', 'Reserve', Reserve);
                    AddTempNameValueBuffer('Customer', 'ShippingAdvice', ShippingAdvice);
                    AddTempNameValueBuffer('Customer', 'ShippingTime', ShippingTime);
                    AddTempNameValueBuffer('Customer', 'ShippingAgentServiceCode', ShippingAgentServiceCode);
                    AddTempNameValueBuffer('Customer', 'BaseCalendarCode', BaseCalendarCode);
                    AddTempNameValueBuffer('Customer', 'TruckZone', TruckZone);
                    AddTempNameValueBuffer('Customer', 'ShipmentDateFormula', ShipmentDateFormula);
                    AddTempNameValueBuffer('Customer', 'Require2Drivers', Require2Drivers);
                    AddTempNameValueBuffer('Customer', 'Distance', Distance);
                    AddTempNameValueBuffer('Customer', 'Route', Route);
                    AddTempNameValueBuffer('Customer', 'DeliveryNoteCopies', DeliveryNoteCopies);
                    AddTempNameValueBuffer('Customer', 'DeliverySequence', DeliverySequence);
                    AddTempNameValueBuffer('Customer', 'PickingType', PickingType);
                    AddTempNameValueBuffer('Customer', 'EmptyReturnedItemBased', EmptyReturnedItemBased);
                    AddTempNameValueBuffer('Customer', 'SalesRoutes', SalesRoutes);
                    AddTempNameValueBuffer('Customer', 'Contact', Contact);
                    AddTempNameValueBuffer('Customer', 'VendorNo', VendorNo);//HEI.04
                    //HEI.02<<
                    AddTempNameValueBuffer('Customer', 'ShortcutDim1Code', ShortcutDim1Code);
                    AddTempNameValueBuffer('Customer', 'ShortcutDim2Code', ShortcutDim2Code);
                    AddTempNameValueBuffer('Customer', 'LocationCode', LocationCode);
                    AddTempNameValueBuffer('Customer', 'TaxAreaCode', TaxAreaCode);
                    AddTempNameValueBuffer('Customer', 'TaxLiable', TaxLiable);
                    AddTempNameValueBuffer('Customer', 'ApprovalForAlcohol', ApprovalForAlcohol);
                    AddTempNameValueBuffer('Customer', 'BlockedReasonCode', BlockedReasonCode);
                    AddTempNameValueBuffer('Customer', 'RiskScores', RiskScores);
                    AddTempNameValueBuffer('Customer', 'RPMExposure', RPMExposure);
                    //AddTempNameValueBuffer('Customer','FFESecurityAmount',FFESecurityAmount); // flowfield
                    //AddTempNameValueBuffer('Customer','InterestRateACreditAmount',InterestRateACreditAmount);// flowfield
                    AddTempNameValueBuffer('Customer', 'PackagingCreditValue', PackagingCreditValue);
                    AddTempNameValueBuffer('Customer', 'CheckFFEBalSecurityAmt', CheckFFEBalSecurityAmt);
                    AddTempNameValueBuffer('Customer', 'AdditionalRPMReturn', AdditionalRPMReturn);
                    AddTempNameValueBuffer('Customer', 'CustomerDeliveryType', CustomerDeliveryType);
                    AddTempNameValueBuffer('Customer', 'CustomerDescription', CustomerDescription);
                    AddTempNameValueBuffer('Customer', 'ContractType', ContractType); //HEI.08
                    //HEI.10>>
                    AddTempNameValueBuffer('Customer', 'PurchasingCode', PurchasingCode);
                    AddTempNameValueBuffer('Customer', 'SendDocument', SendDocument);
                    //HEI.10<<
                    //HEI.11>>
                    AddTempNameValueBuffer('Customer', 'LongitudeCoordinates', LongitudeCoordinates);
                    AddTempNameValueBuffer('Customer', 'LatitudeCoordinates', LatitudeCoordinates);
                    //HEI.11<<
                    AddTempNameValueBuffer('Customer', 'CustomerTaxGroup', CustomerTaxGroup);  //HEI.12
                    AddTempNameValueBuffer('Customer', 'SEMId', SEMId);  //HEI.13
                    AddTempNameValueBuffer('Customer', 'TradingEndDate', TradingEndDate);//HEI.16
                    AddTempNameValueBuffer('Customer', 'RequiredFreshness', RequiredFreshness);    //HEI.18
                    AddXMLBufferElements('Customer');
                    TempXMLBuffer.GetParent();
                    CLEAR(CustomerDescription);
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
    begin
        CLEAR(TempBlob);
        // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer);  // BC Upgrade NANDIS03
        InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); //BC Upgrade VAMSIU01 - Added
        //HEI.17 >>
        CLEAR(TempXMLBuffer);
        CLEAR(TempNameValueBuffer);
        //HEI.17 <<
    end;

    var
        GlobalID: Integer;
        //TempBlob : Record TempBlob temporary;  // BC Upgrade NANDIS03
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Added
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        TempXMLBuffer: Record "XML Buffer" temporary;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        CustomerGroupElementCreated: Boolean;
        CustNo: Text;
        CustomerDescription: Text;
        CustBankAccCustNo: Text;
        SessionGlobals: Codeunit "Session Globals";
        SourceType: Text;
        DeliveryCustomerNo: Text;
        SEPACustNo: Text;

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

