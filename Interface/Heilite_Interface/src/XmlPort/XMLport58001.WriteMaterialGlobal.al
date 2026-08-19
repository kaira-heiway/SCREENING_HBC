xmlport 58001 "Write Material Global"
{
    // Heilite Navision Old Id - 50002
    // version HEI.14

    // HEI.01 FDD-GAPID001 IBM LAZARE02 28.06.2017 # New xmlport for importing material from Mendix
    // HEI.02 FDD-MZ-PRDGAP001 IBM LAZARE02 25.07.2018 # Save global no.
    // HEI.03 FDD BRDHT393 IBM BULIMC01 24.06.2019 #delete field "Inventory Value zero"
    // HEI.04 FDD-HB564 IBM GUNERE01 20.08.2019 # ReturnReasonCode element added, Item - Import::OnAfterAssignVariable modified
    // HEI.05 CHG2013123 IBM.LS 14.05.2020
    //   # Following fields added and code added.
    //   # 1) SugarByVolume
    //   # 2) ArtificallySweetened
    // HEI.06 CHG2112882 IBM.LS      02.06.2021
    //   # Added CccCode Field and Added Code
    // HEI.07 CHG2130815 IBM.LS      18.10.2021
    //   # Commented Code and removed CccCode Field
    // HEI.08 CHG2143164 IBM.LS      14.03.2022
    //   # Added the StrengthSpecValue field and Code
    // HEI.10 IBM.AK INC4184710/CHG2168809 12.08.22
    // # Bug Fix: Strengthspeccode need to fill with N/A for Global request
    // HEI.09 CHG2147491 HB2802 KOROLA04 26.07.2022
    //   # Added ItemDimension part and Added Code on ItemCrossReferences - Import::OnAfterAssignVariable()
    // HEI.10 IBM.AK INC4184710/CHG2168809 12.08.22
    //   # Bug Fix: Strengthspeccode need to fill with N/A for Global request
    // HEI.11 CHG2147491 HB2802 NORRIQ KOROLA04 22.09.2022
    //   # HEI.09 - has been removed
    //   # WHMaterialGroup - added to Item Attributes
    // HEI.12 CHG2202557/INC4640449 IBM.PRASAA03 27.04.2023 Sync Issue Mendix to Heilite
    //   # Minimum Occurance Property changed to 0 for field "StrengthSpecCode"
    //   # Maximum Occurance Property changed to 0 for field "StrengthSpecCode"
    // HEI.13 CHG2202557/INC4640449 IBM.PRASAA03 15.05.2023 Sync Issue Mendix to Heilite
    //   # Checking the Strength Specific Code Validation is causing the issue
    // HEI.14 CHG2202557/INC4640449 IBM.PRASAA03 16.05.2023 Sync Issue Mendix to Heilite
    //   # Removing HEI.13 Vesrion Code.

    // BC Upgrade VAMSIU01 >>
    // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer); - Commented(Blocked temporarily as this function is dependent on Dotnet variables).
    // InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); - Added.
    // procedure GetTempBlob(var NewTempBlob: Record TempBlob); - Commented(BLocked as TempBlob Record is obsolete)
    // procedure GetTempBlob(var NewTempBlob: Codeunit ""Temp Blob"");" - Added.
    // TempBlob : Record TempBlob temporary; - Commented(BLocked as TempBlob Record is obsolete)
    // TempBlob: Codeunit "Temp Blob"; -Added
    // BC Upgrade VAMSIU01 <<

    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/WriteMaterialGlobal';
    UseDefaultNamespace = true;

    schema
    {
        textelement(webMaterialWriteGlobal)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            textelement(ValidateOnly)
            {
                MaxOccurs = Once;
                MinOccurs = Once;

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('webMaterialWriteGlobal');
                    TempXMLBuffer.AddElement('ValidateOnly', ValidateOnly);
                end;
            }
            textelement(Item)
            {
                MaxOccurs = Unbounded;
                MinOccurs = Zero;
                textelement(No)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(No2)
                {
                    MaxOccurs = Once;
                    MinOccurs = Once;

                    trigger OnAfterAssignVariable();
                    begin
                        //HEI.02>>
                        SessionGlobals.SetItemGlobalNo(No2);
                        //HEI.02<<
                    end;
                }
                textelement(Description)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable();
                    begin
                        Description2 := Description;
                    end;
                }
                textelement(BaseUoM)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Type)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PriceProfitCalculation)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Blocked)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CrossPlantMaterialStatus)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CountryRegionOfOriginCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ItemCategoryCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ProductGroupCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ExpirationCalculation)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ReturnReasonCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(StrengthSpecValue)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable();
                    begin
                        //HEI.08>>
                        if StrengthSpecValue = '0' then
                            StrengthSpecValue := ''
                        else
                          //HEI.10>>
                          begin
                            if StrengthSpecCode = '' then
                                StrengthSpecCode := 'N/A';
                            //HEI.10<<
                            StrengthSpecValue := FORMAT(StrengthSpecValue);
                        end;
                        //HEI.08<<
                    end;
                }
                textelement(StrengthSpecCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ItemUnitsOfMeasure)
                {
                    MaxOccurs = Unbounded;
                    MinOccurs = Zero;
                    textelement(itemno_uom)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        XmlName = 'ItemNo';
                    }
                    textelement(Code)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                    }
                    textelement(QtyPerUnitOfMeasure)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(Length)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(Width)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(Height)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(UnitOfDimension)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(Weight)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(UnitOfWeight)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(NetWeight)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }

                    trigger OnAfterAssignVariable();
                    begin
                        if not ItemGroupElementCreated then begin
                            TempXMLBuffer.AddGroupElement('Item');
                            ItemGroupElementCreated := true;
                        end;
                        TempXMLBuffer.AddGroupElement('ItemUnitsOfMeasure');
                        AddTempNameValueBuffer('ItemUnitsOfMeasure', 'ItemNo', ItemNo_UoM);
                        AddTempNameValueBuffer('ItemUnitsOfMeasure', 'Code', Code);
                        AddTempNameValueBuffer('ItemUnitsOfMeasure', 'QtyPerUnitOfMeasure', QtyPerUnitOfMeasure);
                        AddTempNameValueBuffer('ItemUnitsOfMeasure', 'Length', Length);
                        AddTempNameValueBuffer('ItemUnitsOfMeasure', 'Width', Width);
                        AddTempNameValueBuffer('ItemUnitsOfMeasure', 'Height', Height);
                        AddTempNameValueBuffer('ItemUnitsOfMeasure', 'UnitOfDimension', UnitOfDimension);
                        AddTempNameValueBuffer('ItemUnitsOfMeasure', 'Weight', Weight);
                        AddTempNameValueBuffer('ItemUnitsOfMeasure', 'UnitOfWeight', UnitOfWeight);
                        AddTempNameValueBuffer('ItemUnitsOfMeasure', 'NetWeight', NetWeight);
                        AddXMLBufferElements('ItemUnitsOfMeasure');
                        TempXMLBuffer.GetParent();
                    end;
                }
                textelement(ItemTranslations)
                {
                    MaxOccurs = Unbounded;
                    MinOccurs = Zero;
                    textelement(itemno_itemtranslation)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        XmlName = 'ItemNo';
                    }
                    textelement(LanguageCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                    }
                    textelement(description_itemtranslation)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        XmlName = 'Description';
                    }

                    trigger OnAfterAssignVariable();
                    begin
                        if not ItemGroupElementCreated then begin
                            TempXMLBuffer.AddGroupElement('Item');
                            ItemGroupElementCreated := true;
                        end;
                        TempXMLBuffer.AddGroupElement('ItemTranslations');
                        AddTempNameValueBuffer('ItemTranslations', 'ItemNo', ItemNo_ItemTranslation);
                        AddTempNameValueBuffer('ItemTranslations', 'LanguageCode', LanguageCode);
                        AddTempNameValueBuffer('ItemTranslations', 'Description', Description_ItemTranslation);
                        AddXMLBufferElements('ItemTranslations');
                        TempXMLBuffer.GetParent();
                    end;
                }
                textelement(ItemCrossReferences)
                {
                    MaxOccurs = Unbounded;
                    MinOccurs = Zero;
                    textelement(itemno_itemcrossref)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        XmlName = 'ItemNo';
                    }
                    textelement(UnitOfMeasure)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                    }
                    textelement(CrossReferenceNo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(EANCategory)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }

                    trigger OnAfterAssignVariable();
                    begin
                        if not ItemGroupElementCreated then begin
                            TempXMLBuffer.AddGroupElement('Item');
                            ItemGroupElementCreated := true;
                        end;
                        TempXMLBuffer.AddGroupElement('ItemCrossReferences');
                        AddTempNameValueBuffer('ItemCrossReferences', 'ItemNo', ItemNo_ItemCrossRef);
                        AddTempNameValueBuffer('ItemCrossReferences', 'UnitOfMeasure', UnitOfMeasure);
                        AddTempNameValueBuffer('ItemCrossReferences', 'CrossReferenceNo', CrossReferenceNo);
                        AddTempNameValueBuffer('ItemCrossReferences', 'EANCategory', EANCategory);
                        AddXMLBufferElements('ItemCrossReferences');
                        TempXMLBuffer.GetParent();
                    end;
                }
                textelement(ItemAttributes)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    textelement(CommonMaterialGroup)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable();
                        begin
                            CMGDim := CommonMaterialGroup;
                        end;
                    }
                    textelement(BrandCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable();
                        begin
                            BrandDim := BrandCode;
                        end;
                    }
                    textelement(LineExtension)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable();
                        begin
                            LineExtensionDim := LineExtension;
                        end;
                    }
                    textelement(ProductGroup)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable();
                        begin
                            ProductGroupDim := ProductGroup;
                        end;
                    }
                    textelement(ProductType)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable();
                        begin
                            ProductTypeDim := ProductType;
                        end;
                    }
                    textelement(GroupComp3rdParty)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable();
                        begin
                            GroupComp3rdPartyDim := GroupComp3rdParty;
                        end;
                    }
                    textelement(PrimaryPackType)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable();
                        begin
                            PrimaryPackTypeDim := PrimaryPackType;
                        end;
                    }
                    textelement(PrimaryPackTypeGroup)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable();
                        begin
                            PrimaryPackTypeGroupDim := PrimaryPackTypeGroup;
                        end;
                    }
                    textelement(PrimaryPackSize)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable();
                        begin
                            PrimaryPackSizeDim := PrimaryPackSize;
                        end;
                    }
                    textelement(SPTOuterLayer)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable();
                        begin
                            SPTOuterLayerDim := SPTOuterLayer;
                        end;
                    }
                    textelement(SPTUnitPerOuter)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(SPTInBetwLayer)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(SPTUnitsPerInBetw)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(AlcoholByVolume)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(AlcoholByWeight)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(ReturnableIndicator)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable();
                        begin
                            ReturnableIndicatorDim := ReturnableIndicator;
                        end;
                    }
                    textelement(SparklingStill)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(WineCategory)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(Denomination)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(RegionOfOrigin)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(SugarByVolume)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(ArtificallySweetened)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(WHMaterialGroup)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable();
                        begin
                            WHMaterialGroupDim := WHMaterialGroup;//HEI.11
                        end;
                    }

                    trigger OnAfterAssignVariable();
                    begin
                        if not ItemGroupElementCreated then begin
                            TempXMLBuffer.AddGroupElement('Item');
                            ItemGroupElementCreated := true;
                        end;
                        GetGeneralInterfaceSetup();
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."CMG Attribute ID"), CommonMaterialGroup);
                        AddTempNameValueBuffer('ItemDimensions', GeneralInterfaceSetup."CMG Dimension Code", CMGDim);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Brand Attribute ID"), BrandCode);
                        AddTempNameValueBuffer('ItemDimensions', GeneralInterfaceSetup."Brand Dim. Code", BrandDim);
                        //HEI.06>>
                        //HEI.07>>
                        //AddTempNameValueBuffer('ItemAttributes',GetAttributeNameFromID(GeneralInterfaceSetup."Ccc Code Attribute ID"),CccCode);
                        //AddTempNameValueBuffer('ItemDimensions',GeneralInterfaceSetup."Cost Center Dimension Code",CccCodeDim);
                        //HEI.07<<
                        //HEI.06<<
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Line Extension Attr. ID"), LineExtension);
                        AddTempNameValueBuffer('ItemDimensions', GeneralInterfaceSetup."Line Extension Dim. Code", LineExtensionDim);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Product Group Attr. ID"), ProductGroup);
                        AddTempNameValueBuffer('ItemDimensions', GeneralInterfaceSetup."Product Group Dim. Code", ProductGroupDim);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Product Type Attr. ID"), ProductType);
                        AddTempNameValueBuffer('ItemDimensions', GeneralInterfaceSetup."Product Type  Dim. Code", ProductTypeDim);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Group 3rdParty Attr. ID"), GroupComp3rdParty);
                        AddTempNameValueBuffer('ItemDimensions', GeneralInterfaceSetup."Group 3rdParty Dim. Code", GroupComp3rdPartyDim);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Primary Pack Type Attr. ID"), PrimaryPackType);
                        AddTempNameValueBuffer('ItemDimensions', GeneralInterfaceSetup."Primary Pack Type Dim. Code", PrimaryPackTypeDim);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Primary PT Group Attr. ID"), PrimaryPackTypeGroup);
                        AddTempNameValueBuffer('ItemDimensions', GeneralInterfaceSetup."Primary PT Group Dim. Code", PrimaryPackTypeGroupDim);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Primary Pack Size Attr. ID"), PrimaryPackSize);
                        AddTempNameValueBuffer('ItemDimensions', GeneralInterfaceSetup."Primary Pack Size Dim. Code", PrimaryPackSizeDim);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."SPT Outer Layer Attr. ID"), SPTOuterLayer);
                        AddTempNameValueBuffer('ItemDimensions', GeneralInterfaceSetup."SPT Outer Layer Dim. Code", SPTOuterLayerDim);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."SPT Unit Per Outer Attr. ID"), SPTUnitPerOuter);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."SPT In Betw. Layer Attr. ID"), SPTInBetwLayer);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."SPT Units In Betw. Attr. ID"), SPTUnitsPerInBetw);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Alcohol By Volume Attr. ID"), AlcoholByVolume);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Alcohol By Weight Attr. ID"), AlcoholByWeight);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Returnable Indicat. Attr. ID"), ReturnableIndicator);
                        AddTempNameValueBuffer('ItemDimensions', GeneralInterfaceSetup."Returnable Indicator Dim. Code", ReturnableIndicatorDim);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Sparkling Still Attr. ID"), SparklingStill);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Wine Category Attr. ID"), WineCategory);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Denomination Attr. ID"), Denomination);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Region Of Origin Attr. ID"), RegionOfOrigin);
                        //HEI.05>>
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Sugar by Volume Attr ID"), SugarByVolume);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Artificially Sweetened Attr ID"), ArtificallySweetened);
                        //HEI.05<<
                        //HEI.11 >>
                        AddTempNameValueBuffer('ItemDimensions', GeneralInterfaceSetup."WH Material Group Dim. Code", WHMaterialGroupDim);
                        //HEI.11 <<
                        CreateAttributeXmlBuffer('ItemAttributes', No);
                        CreateDimensionXmlBuffer('ItemDimensions', No);
                    end;
                }

                trigger OnAfterAssignVariable();
                begin
                    if not ItemGroupElementCreated then begin
                        TempXMLBuffer.AddGroupElement('Item');
                        ItemGroupElementCreated := true;
                    end;
                    AddTempNameValueBuffer('Item', 'No', No);
                    AddTempNameValueBuffer('Item', 'No2', No2);
                    AddTempNameValueBuffer('Item', 'Description', Description);
                    AddTempNameValueBuffer('Item', 'Description2', Description2);
                    AddTempNameValueBuffer('Item', 'BaseUoM', BaseUoM);
                    AddTempNameValueBuffer('Item', 'Type', Type);
                    AddTempNameValueBuffer('Item', 'PriceProfitCalculation', PriceProfitCalculation);
                    AddTempNameValueBuffer('Item', 'Blocked', Blocked);
                    AddTempNameValueBuffer('Item', 'CrossPlantMaterialStatus', CrossPlantMaterialStatus);
                    AddTempNameValueBuffer('Item', 'CountryRegionOfOriginCode', CountryRegionOfOriginCode);
                    AddTempNameValueBuffer('Item', 'ItemCategoryCode', ItemCategoryCode);
                    AddTempNameValueBuffer('Item', 'ProductGroupCode', ProductGroupCode);
                    AddTempNameValueBuffer('Item', 'ExpirationCalculation', ExpirationCalculation);
                    AddTempNameValueBuffer('Item', 'ReturnReasonCode', ReturnReasonCode); //HEI.04 FDD-HB564
                    //HEI.08>>
                    AddTempNameValueBuffer('Item', 'StrengthSpecValue', StrengthSpecValue);
                    //HEI.08<<
                    //HEI.10>>
                    AddTempNameValueBuffer('Item', 'StrengthSpecCode', StrengthSpecCode);
                    //HEI.10<<
                    AddXMLBufferElements('Item');
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
        COMMIT();
        CLEAR(TempBlob);
        InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); //BC Upgrade VAMSIU01 - Added
        //InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer); // BC Upgrade NANDIS03 
    end;

    var
        TempXMLBuffer: Record "XML Buffer" temporary;
        //TempBlob : Record TempBlob temporary;  // BC Upgrade NANDIS03
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Added
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        SessionGlobals: Codeunit "Session Globals";
        GeneralInterfaceSetupRead: Boolean;
        GlobalID: Integer;
        ItemGroupElementCreated: Boolean;
        Description2: Text;
        CMGDim: Text;
        BrandDim: Text;
        LineExtensionDim: Text;
        ProductGroupDim: Text;
        ProductTypeDim: Text;
        GroupComp3rdPartyDim: Text;
        PrimaryPackTypeDim: Text;
        PrimaryPackTypeGroupDim: Text;
        PrimaryPackSizeDim: Text;
        SPTOuterLayerDim: Text;
        ReturnableIndicatorDim: Text;
        CccCodeDim: Text;
        WHMaterialGroupDim: Text;

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

    local procedure CreateAttributeXmlBuffer(ParentName: Text; ItemNo: Code[20]);
    var
        ItemAttribute: Record "Item Attribute";
        ItemAttributeValue: Record "Item Attribute Value";
    begin
        TempNameValueBuffer.RESET();
        TempNameValueBuffer.SETRANGE("Name 2 FND", ParentName);
        TempNameValueBuffer.SETFILTER(Name, '<>%1', '');
        if TempNameValueBuffer.findset() then
            repeat
                ItemAttribute.SETRANGE(Name, TempNameValueBuffer.Name);
                ItemAttribute.FINDFIRST();
                CheckInsertItemAttributeValue(ItemAttribute.ID, TempNameValueBuffer.Value, ItemAttributeValue);
                TempXMLBuffer.AddGroupElement('ItemAttributes');
                TempXMLBuffer.AddElement('TableID', FORMAT(DATABASE::Item));
                TempXMLBuffer.AddElement('ItemNo', ItemNo);
                TempXMLBuffer.AddElement('AttributeID', FORMAT(ItemAttribute.ID));
                TempXMLBuffer.AddElement('AttributeValueID', FORMAT(ItemAttributeValue.ID));
                TempXMLBuffer.GetParent();
            until TempNameValueBuffer.NEXT() = 0;
        TempNameValueBuffer.DELETEALL();
    end;

    local procedure CreateDimensionXmlBuffer(ParentName: Text; ItemNo: Code[20]);
    begin
        TempNameValueBuffer.RESET();
        TempNameValueBuffer.SETRANGE("Name 2 FND", ParentName);
        TempNameValueBuffer.SETFILTER(Name, '<>%1', '');
        if TempNameValueBuffer.findset() then
            repeat
                TempXMLBuffer.AddGroupElement('ItemDimensions');
                TempXMLBuffer.AddElement('TableID', FORMAT(DATABASE::Item));
                TempXMLBuffer.AddElement('ItemNo', ItemNo);
                TempXMLBuffer.AddElement('DimensionCode', TempNameValueBuffer.Name);
                TempXMLBuffer.AddElement('DimensionValueCode', TempNameValueBuffer.Value);
                TempXMLBuffer.AddElement('ValuePosting', '0');
                TempXMLBuffer.GetParent();
            until TempNameValueBuffer.NEXT() = 0;
        TempNameValueBuffer.DELETEALL();
    end;

    local procedure GetAttributeNameFromID(ID: Integer): Text;
    var
        ItemAttribute2: Record "Item Attribute";
    begin
        if ItemAttribute2.GET(ID) then
            exit(ItemAttribute2.Name);
    end;

    local procedure CheckInsertItemAttributeValue(AttributeID: Integer; Value: Text; var ItemAttributeValue: Record "Item Attribute Value");
    var
        ItemAttribute: Record "Item Attribute";
        ItemAttributeValueSelection: Record "Item Attribute Value Selection";
        TempItemAttributeValueSelection: Record "Item Attribute Value Selection" temporary;
        ValDecimal: Decimal;
    begin
        ItemAttribute.GET(AttributeID);
        CLEAR(TempItemAttributeValueSelection);
        TempItemAttributeValueSelection."Attribute Name" := ItemAttribute.Name;
        TempItemAttributeValueSelection."Attribute ID" := ItemAttribute.ID;
        TempItemAttributeValueSelection."Attribute Type" := ItemAttribute.Type;
        TempItemAttributeValueSelection.Value := Value;
        TempItemAttributeValueSelection.INSERT();

        ItemAttributeValue.RESET();
        ItemAttributeValue.SETRANGE("Attribute ID", ItemAttribute.ID);
        case ItemAttribute.Type of
            ItemAttribute.Type::Option,
          ItemAttribute.Type::Text,
          ItemAttribute.Type::Integer:
                ItemAttributeValue.SETRANGE(Value, TempItemAttributeValueSelection.Value);
            ItemAttribute.Type::Decimal:
                begin
                    if TempItemAttributeValueSelection.Value <> '' then
                        EVALUATE(ValDecimal, TempItemAttributeValueSelection.Value);
                    if ItemAttribute."Value Format FND" = '' then
                        ItemAttributeValue.SETRANGE(Value, FORMAT(ValDecimal, 0, 9))
                    else
                        ItemAttributeValue.SETRANGE(Value, FORMAT(ValDecimal, 0, ItemAttribute."Value Format FND"));
                end;
        end;
        if not ItemAttributeValue.FINDFIRST() then
            ItemAttributeValueSelection.InsertItemAttributeValue(ItemAttributeValue, TempItemAttributeValueSelection);
    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        if not GeneralInterfaceSetupRead then
            GeneralInterfaceSetup.GET();
        GeneralInterfaceSetupRead := true;
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

