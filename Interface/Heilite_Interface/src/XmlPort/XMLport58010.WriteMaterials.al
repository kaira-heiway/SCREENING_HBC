xmlport 58010 "Write Materials"
{
    // Heilite Navision Old Id - 50036
    // version HEI.14

    // HEI.02 IBM HORTOC01 28.02.2019 - new fields
    // HEI.03 FDD-BA-GAPLOG09 IBM HORTOC01 15.04.2019
    //   # New field "BackOrder Type
    // HEI.04 FDD PBRD HT401 BULIMC01 IBM 20.05.2019 - added new field Sales Price Warning
    // HEI.05 CHG2013123 TUDOSG01 IBM 11.03.2020 - added new fields: StrengthMethod, StrengthSpecificCode, StrengthSpecValue
    // HEI.06 CHG2013123 IBM.LS 16.03.2020
    //   # Corrected the following 3 fields property values;
    //   # 1) StrengthMethod
    //   # 2) StrengthSpecificCode
    //   # 3) StrengthSpecValue
    // HEI.07 CHG2060049 HT1098 IBM.GUNERE01 10/04/2020 # Commodity Code field added
    // HEI.08 CHG2013123 IBM.LS 07.05.2020
    //   # Following fields added and code added.
    //   # 1) SugarByVolume
    //   # 2) ArtificallySweetened
    // HEI.09 CHG2063089 HB1343 IBM.KUMARN15 16/06/2020
    //   # ItemTaxGroupCode node added, code added
    // HEI.10 CHG2112882 IBM.LS      02.06.2021
    //   # Added CccCode Field and Added Code
    // HEI.11 CHG2142222-HT2493 BHANDS01 24.12.2021
    //   # Added CCCDimCode Field and Added Code on ItemLocalSite
    // HEI.12 CHG2140629 HB2723 BHANDS01 20.01.2022
    //   # Added "Deposit Value Method","Deposit Value" and Added Code on Item - Import::OnAfterAssignVariable()
    // HEI.13 CHG2147491 HB2802 KOROLA04 26.07.2022
    //   # Added ItemDimension part and Added Code on ItemCrossReferences - Import::OnAfterAssignVariable()
    // HEI.14 CHG2147491 HB2802 NORRIQ KOROLA04 22.09.2022
    //   # HEI.13 - has been removed
    //   # WHMaterialGroup - added to Item Attributes

    // BC Upgrade VAMSIU01 >>
    // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer); - Commented(Blocked temporarily as this function is dependent on Dotnet variables).
    // InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); - Added.
    // procedure GetTempBlob(var NewTempBlob: Record TempBlob); - Commented(BLocked as TempBlob Record is obsolete)
    // procedure GetTempBlob(var NewTempBlob: Codeunit ""Temp Blob"");" - Added.
    // TempBlob : Record TempBlob temporary; - Commented(BLocked as TempBlob Record is obsolete)
    // TempBlob: Codeunit "Temp Blob"; -Added
    // BC Upgrade VAMSIU01 <<

    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/WriteMaterial';
    UseDefaultNamespace = true;

    schema
    {
        textelement(webMaterialWrite)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            textelement(ValidateOnly)
            {
                MaxOccurs = Once;
                MinOccurs = Once;

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('webMaterialWrite');
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
                textelement(InventoryValueZero)
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
                textelement(InventoryPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(AllowInvoiceDiscount)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CostingMethod)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PriceIncludesVAT)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(GenProdPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(VATProdPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ItemDepositGroupCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SplitDepositOnInvoice)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(AllowVATCalculationFree)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(GenProdPostingGroupFreeItem)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CalculatePriceOnFree)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(FreeItem)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(WHTProductPostingGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Reserve)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SalesUoM)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PurchUoM)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ItemTrackingCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(LotNos)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ReturnReasonCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(MancoSurplusTolerance)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(GiftBoxItem)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(BatchNumberingPolicy)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SerialNos)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ServiceItemGroup)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ItemSegmentation)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(CertificationRequired)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(RotatingItem)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(MachineReferenceNumber)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(RoundingPrecision)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(RPMSolution)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ProductionUoM)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(InventoryUoM)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(OrderTrackingPolicy)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SalesPriceWarning)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(StrengthMethod)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(StrengthSpecificCode)
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
                            StrengthSpecValue := FORMAT(StrengthSpecValue);
                        //HEI.08<<
                    end;
                }
                textelement(CommodityCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ItemTaxGroupCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(DepositValueMethod)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(DepositValue)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ItemLocalSite)
                {
                    MaxOccurs = Unbounded;
                    MinOccurs = Zero;
                    textelement(itemno_sku)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        XmlName = 'ItemNo';
                    }
                    textelement(LocationCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(blocked_sku)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        XmlName = 'Blocked';
                    }
                    textelement(PlantSpecificMaterialStatus)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(StandardCost)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(LotSize)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(FlushingMethod)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(ReplenishmentSystem)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(PhysInvtCountingPeriodCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(Scrap)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(OverheadRate)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(IndirectCost)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(QualityStandardNo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(QuarantinePostingPolicy)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(RPMSolutionSKU)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(LeadTimeCalculation)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(ReorderingPolicy)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(ReorderPoint)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(ReorderQuantity)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(MinimumOrderQty)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(MaximumOrderQty)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(OrderMultiple)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(SafetyStockQty)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(SafetyLeadTime)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(TimeBucket)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(OverflowLevel)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(BackorderType)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(CCCDimCode)
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
                        TempXMLBuffer.AddGroupElement('ItemLocalSite');
                        /*
                        EVALUATE(SimulationMode,ValidateOnly);
                        IF NOT SimulationMode THEN BEGIN
                          TempXMLBuffer.AddElement('ItemNo',ItemNo_SKU);
                          TempXMLBuffer.AddElement('LocationCode',LocationCode);
                        END ELSE BEGIN
                          IF ItemNo_SKU = '' THEN BEGIN
                            ItemSKU.SETRANGE(Type,ItemSKU.Type::Inventory);
                            ItemSKU.SETRANGE(Inventory,0);
                            IF ItemSKU.FINDLAST THEN
                              TempXMLBuffer.AddElement('ItemNo',ItemSKU."No.");
                          END ELSE
                            IF ItemSKU.GET(ItemNo_SKU) THEN
                              TempXMLBuffer.AddElement('ItemNo',ItemNo_SKU);
                          IF LocationCode = '' THEN BEGIN
                            Location.FINDLAST;
                            TempXMLBuffer.AddElement('LocationCode',Location.Code);
                          END ELSE
                            TempXMLBuffer.AddElement('LocationCode',LocationCode);
                        END;
                        */
                        AddTempNameValueBuffer('ItemLocalSite', 'ItemNo', ItemNo_SKU);
                        AddTempNameValueBuffer('ItemLocalSite', 'LocationCode', LocationCode);
                        AddTempNameValueBuffer('ItemLocalSite', 'Blocked', Blocked_SKU);
                        AddTempNameValueBuffer('ItemLocalSite', 'StandardCost', StandardCost);
                        AddTempNameValueBuffer('ItemLocalSite', 'PlantSpecificMaterialStatus', PlantSpecificMaterialStatus);
                        AddTempNameValueBuffer('ItemLocalSite', 'LotSize', LotSize);
                        AddTempNameValueBuffer('ItemLocalSite', 'FlushingMethod', FlushingMethod);
                        AddTempNameValueBuffer('ItemLocalSite', 'ReplenishmentSystem', ReplenishmentSystem);
                        AddTempNameValueBuffer('ItemLocalSite', 'PhysInvtCountingPeriodCode', PhysInvtCountingPeriodCode);
                        AddTempNameValueBuffer('ItemLocalSite', 'Scrap', Scrap);
                        AddTempNameValueBuffer('ItemLocalSite', 'OverheadRate', OverheadRate);
                        AddTempNameValueBuffer('ItemLocalSite', 'IndirectCost', IndirectCost);
                        AddTempNameValueBuffer('ItemLocalSite', 'QualityStandardNo', QualityStandardNo);
                        AddTempNameValueBuffer('ItemLocalSite', 'QuarantinePostingPolicy', QuarantinePostingPolicy);
                        AddTempNameValueBuffer('ItemLocalSite', 'RPMSolutionSKU', RPMSolutionSKU);
                        //HEI.02>>
                        AddTempNameValueBuffer('ItemLocalSite', 'LeadTimeCalculation', LeadTimeCalculation);
                        AddTempNameValueBuffer('ItemLocalSite', 'ReorderingPolicy', ReorderingPolicy);
                        AddTempNameValueBuffer('ItemLocalSite', 'ReorderPoint', ReorderPoint);
                        AddTempNameValueBuffer('ItemLocalSite', 'ReorderQuantity', ReorderQuantity);
                        AddTempNameValueBuffer('ItemLocalSite', 'MinimumOrderQty', MinimumOrderQty);
                        AddTempNameValueBuffer('ItemLocalSite', 'MaximumOrderQty', MaximumOrderQty);
                        AddTempNameValueBuffer('ItemLocalSite', 'SafetyLeadTime', SafetyLeadTime);
                        AddTempNameValueBuffer('ItemLocalSite', 'SafetyStockQty', SafetyStockQty);
                        AddTempNameValueBuffer('ItemLocalSite', 'TimeBucket', TimeBucket);
                        AddTempNameValueBuffer('ItemLocalSite', 'OverflowLevel', OverflowLevel);
                        AddTempNameValueBuffer('ItemLocalSite', 'OrderMultiple', OrderMultiple);
                        //HEI.02<<

                        //HEI.03>>
                        AddTempNameValueBuffer('ItemLocalSite', 'BackorderType', BackorderType);
                        //HEI.03<<

                        //HEI.11>>
                        AddTempNameValueBuffer('ItemLocalSite', 'CCCDimCode', CCCDimCode);
                        //HEI.11<<

                        AddXMLBufferElements('ItemLocalSite');
                        TempXMLBuffer.GetParent();

                    end;
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
                    textelement(CccCode)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable();
                        begin
                            //HEI.10>>
                            CccCodeDim := CccCode;
                            //HEI.10<<
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
                            WHMaterialGroupDim := WHMaterialGroup;//HEI.14
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
                        //HEI.10>>
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Ccc Code Attribute ID"), CccCode);
                        AddTempNameValueBuffer('ItemDimensions', GeneralInterfaceSetup."Cost Center Dimension Code", CccCodeDim);
                        //HEI.10<<
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
                        //HEI.08>>
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Sugar by Volume Attr ID"), SugarByVolume);
                        AddTempNameValueBuffer('ItemAttributes', GetAttributeNameFromID(GeneralInterfaceSetup."Artificially Sweetened Attr ID"), ArtificallySweetened);
                        //HEI.08<<
                        //HEI.14 >>
                        AddTempNameValueBuffer('ItemDimensions', GeneralInterfaceSetup."WH Material Group Dim. Code", WHMaterialGroupDim);
                        //HEI.14 <<
                        CreateAttributeXmlBuffer('ItemAttributes', No);
                        CreateDimensionXmlBuffer('ItemDimensions', No);
                    end;
                }

                trigger OnAfterAssignVariable();
                var
                    TrackingCodestrengthMethod: Record "TrackingCode & StrMethod FND";
                begin
                    if not ItemGroupElementCreated then begin
                        TempXMLBuffer.AddGroupElement('Item');
                        ItemGroupElementCreated := true;
                    end;
                    //BC Upgrade Kamnay01  FDD-DTW-011 >>
                    if (ItemTrackingCode <> '') And (StrengthMethod <> '') then begin
                        //Error('HI%1', ItemTrackingCode);
                        TrackingCodestrengthMethod.Reset();
                        TrackingCodestrengthMethod.SetRange("Tracking Code FND", ItemTrackingCode);
                        TrackingCodestrengthMethod.SetRange("Strength Method FND", StrengthMethod);
                        if TrackingCodestrengthMethod.FindFirst() then
                            ItemTrackingCode := TrackingCodestrengthMethod."New Tracking code FND";
                    end;
                    //BC Upgrade Kamnay01  FDD-DTW-011 <<
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
                    AddTempNameValueBuffer('Item', 'InventoryValueZero', InventoryValueZero);
                    AddTempNameValueBuffer('Item', 'ItemCategoryCode', ItemCategoryCode);
                    AddTempNameValueBuffer('Item', 'ProductGroupCode', ProductGroupCode);
                    AddTempNameValueBuffer('Item', 'ExpirationCalculation', ExpirationCalculation);

                    //onexml>>
                    AddTempNameValueBuffer('Item', 'InventoryPostingGroup', InventoryPostingGroup);
                    AddTempNameValueBuffer('Item', 'AllowInvoiceDiscount', AllowInvoiceDiscount);
                    AddTempNameValueBuffer('Item', 'CostingMethod', CostingMethod);
                    AddTempNameValueBuffer('Item', 'PriceIncludesVAT', PriceIncludesVAT);
                    AddTempNameValueBuffer('Item', 'GenProdPostingGroup', GenProdPostingGroup);
                    AddTempNameValueBuffer('Item', 'VATProdPostingGroup', VATProdPostingGroup);
                    AddTempNameValueBuffer('Item', 'ItemDepositGroupCode', ItemDepositGroupCode);
                    AddTempNameValueBuffer('Item', 'SplitDepositOnInvoice', SplitDepositOnInvoice);
                    AddTempNameValueBuffer('Item', 'AllowVATCalculationFree', AllowVATCalculationFree);
                    AddTempNameValueBuffer('Item', 'GenProdPostingGroupFreeItem', GenProdPostingGroupFreeItem);
                    AddTempNameValueBuffer('Item', 'CalculatePriceOnFree', CalculatePriceOnFree);
                    AddTempNameValueBuffer('Item', 'FreeItem', FreeItem);
                    AddTempNameValueBuffer('Item', 'WHTProductPostingGroup', WHTProductPostingGroup);
                    AddTempNameValueBuffer('Item', 'SalesPriceWarning', SalesPriceWarning); //HEI.04

                    AddTempNameValueBuffer('Item', 'Reserve', Reserve);
                    AddTempNameValueBuffer('Item', 'SalesUoM', SalesUoM);
                    AddTempNameValueBuffer('Item', 'PurchUoM', PurchUoM);
                    AddTempNameValueBuffer('Item', 'ItemTrackingCode', ItemTrackingCode);
                    AddTempNameValueBuffer('Item', 'LotNos', LotNos);
                    AddTempNameValueBuffer('Item', 'ReturnReasonCode', ReturnReasonCode);
                    AddTempNameValueBuffer('Item', 'MancoSurplusTolerance', MancoSurplusTolerance);
                    AddTempNameValueBuffer('Item', 'GiftBoxItem', GiftBoxItem);
                    AddTempNameValueBuffer('Item', 'BatchNumberingPolicy', BatchNumberingPolicy);
                    AddTempNameValueBuffer('Item', 'SerialNos', SerialNos);
                    AddTempNameValueBuffer('Item', 'ServiceItemGroup', ServiceItemGroup);
                    AddTempNameValueBuffer('Item', 'ItemSegmentation', ItemSegmentation);
                    AddTempNameValueBuffer('Item', 'CertificationRequired', CertificationRequired);
                    AddTempNameValueBuffer('Item', 'RotatingItem', RotatingItem);
                    AddTempNameValueBuffer('Item', 'MachineReferenceNumber', MachineReferenceNumber);
                    AddTempNameValueBuffer('Item', 'RoundingPrecision', RoundingPrecision);
                    AddTempNameValueBuffer('Item', 'RPMSolution', RPMSolution);
                    AddTempNameValueBuffer('Item', 'OrderTrackingPolicy', OrderTrackingPolicy);//HEi.02
                    AddTempNameValueBuffer('Item', 'ProductionUoM', ProductionUoM);
                    AddTempNameValueBuffer('Item', 'InventoryUoM', InventoryUoM);
                    AddTempNameValueBuffer('Item', 'StrengthMethod', StrengthMethod);//HEI.05
                    AddTempNameValueBuffer('Item', 'StrengthSpecificCode', StrengthSpecificCode);//HEI.05
                    AddTempNameValueBuffer('Item', 'StrengthSpecValue', StrengthSpecValue);//HEI.05
                    AddTempNameValueBuffer('Item', 'CommodityCode', CommodityCode);//HEI.07
                    AddTempNameValueBuffer('Item', 'ItemTaxGroupCode', ItemTaxGroupCode); // HEI.09
                    // HEI.12 >>
                    AddTempNameValueBuffer('Item', 'DepositValueMethod', DepositValueMethod);
                    AddTempNameValueBuffer('Item', 'DepositValue', DepositValue);
                    // HEI.12 <<
                    //onexml<<

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
        // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer);  // BC Upgrade NANDIS03
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
        SimulationMode: Boolean;
        ItemSKU: Record Item;
        Location: Record Location;
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

