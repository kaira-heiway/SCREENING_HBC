xmlport 58005 "Write Vendor Global"
{
    // Heilite Navision Old Id - 50006
    // version HEI.04

    // HEI.01 IBM HORTOC01 26.02.2019 - change the caption of field VendorType to VendorAccountGroup
    // HEI.02 FDD-HT923 CHG2034529 IBM GUNERE01 30.10.2019 # GlobalVendorID - Import::OnAfterAssignVariable modified
    // HEI.03 CHG2162715 HB3020 NORRIQ KOROLA04 14.12.2022
    //   #CheckVendorSPL(), CreateVendorSPLRelation() - created
    // HEI.04 CHG2162715 HB3020 NORRIQ KOROLA04 19.12.2022 - Adding Production location in Purchase orders
    //   #CheckVendorSPL() - modified

    // BC Upgrade VAMSIU01 >>
    // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer); - Commented(Blocked temporarily as this function is dependent on Dotnet variables).
    // InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); - Added.
    // procedure GetTempBlob(var NewTempBlob: Record TempBlob); - Commented(BLocked as TempBlob Record is obsolete)
    // procedure GetTempBlob(var NewTempBlob: Codeunit ""Temp Blob"");" - Added.
    // TempBlob : Record TempBlob temporary; - Commented(BLocked as TempBlob Record is obsolete)
    // TempBlob: Codeunit "Temp Blob"; -Added
    // BC Upgrade VAMSIU01 <<

    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/WriteVendorGlobal';
    UseDefaultNamespace = true;

    schema
    {
        textelement(webVendorWriteGlobal)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            textelement(ValidateOnly)
            {
                MaxOccurs = Once;
                MinOccurs = Once;

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('webVendorWriteGlobal');
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
                        //>> HEI.02
                        SessionGlobals.SetVendorGlobalNo(GlobalVendorID);
                        //<< HEI.02
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

                        //HEI.03 >>
                        if ParentLegalEntity = '' then begin
                            AddTempNameValueBuffer('VendorDimension', 'VendorNo', VendorNo_Dim);
                            AddTempNameValueBuffer('VendorDimension', 'DimCode', DimCode);
                            AddTempNameValueBuffer('VendorDimension', 'DimValueCode', DimValueCode);
                            ValuePosting := '2';
                            AddTempNameValueBuffer('VendorDimension', 'ValuePosting', ValuePosting);
                        end;
                        //HEI.03 <<

                        AddXMLBufferElements('VendorDimension');
                        TempXMLBuffer.GetParent();
                    end;
                }

                trigger OnAfterAssignVariable();
                begin
                    if not VendorGroupElementCreated then begin
                        TempXMLBuffer.AddGroupElement('Vendor');
                        VendorGroupElementCreated := true;
                    end;

                    //HEI.03 >>
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
                        AddTempNameValueBuffer('Vendor', 'VendorAccountGroup', VendorAccountGroup);//HEI.01
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
                    end;
                    //HEI.31 <<

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
        ErrGlobalVendorID: Label 'GlobalID must not be empty!';
        Vendor: Record Vendor;
        ErrVendor: TextConst ENU = 'Vendor with Global Vendor Number = %1 has not been found!';
    begin
        //HEI.03 >>
        PurchSetup.GET();
        if not PurchSetup."SPL Active FND" then begin
            if ParentLegalEntity <> '' then
                ERROR(ErrParentLegalEntity);

            exit(false);
        end;

        //HEI.04 >>
        if (ParentLegalEntity = '') and (PurchSetup."SPL Account Group FND" <> IAccountGroup) then
            exit(false);
        //HEI.04 <<

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
        //HEI.03 <<
    end;

    local procedure CreateVendorSPLRelation();
    begin
        //HEI.03 >>
        TempXMLBuffer.AddGroupElement('VendorSPLRelation');
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
        AddTempNameValueBuffer('VendorSPLRelation', 'ParentLegalEntity', ParentLegalEntity);
        AddXMLBufferElements('VendorSPLRelation');
        TempXMLBuffer.GetParent();
        //HEI.03 <<
    end;
}

