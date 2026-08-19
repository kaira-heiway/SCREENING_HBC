xmlport 58004 "Write/Validate Local Site"
{
    // Heilite Navision Old Id - 50005
    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 28.06.2017 # New xmlport for importing material from Mendix
    // HEI.02 FDD-PRD-GAP061 IBM NAIKH01 18.12.2018
    //   # New Fields Added LeadTimeCalculation,ReorderingPolicy,ReorderPoint,ReorderQuantity
    // HEI.03 FDD-BA-GAPLOG09 IBM HORTOC01 15.04.2019
    //   # New field "BackOrder Type"
    // HEI.04 CHG2142222-HT2493 BHANDS01 03.01.2022
    //   # Added New Field "CCCDimCode" and Code on AddXMLBufferElements()

    // BC Upgrade VAMSIU01 >>
    // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer); - Commented(Blocked temporarily as this function is dependent on Dotnet variables).
    // InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); - Added.
    // procedure GetTempBlob(var NewTempBlob: Record TempBlob); - Commented(BLocked as TempBlob Record is obsolete)
    // procedure GetTempBlob(var NewTempBlob: Codeunit ""Temp Blob"");" - Added.
    // TempBlob : Record TempBlob temporary; - Commented(BLocked as TempBlob Record is obsolete)
    // TempBlob: Codeunit "Temp Blob"; -Added
    // BC Upgrade VAMSIU01 <<

    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/WriteMaterialLocalSite';
    UseDefaultNamespace = true;

    schema
    {
        textelement(webMaterialWriteLocalSite)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            textelement(ValidateOnly)
            {
                MaxOccurs = Once;
                MinOccurs = Once;

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('webMaterialWriteLocalSite');
                    TempXMLBuffer.AddElement('ValidateOnly', ValidateOnly);
                end;
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
                textelement(RPMSolution)
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
                    TempXMLBuffer.AddGroupElement('ItemLocalSite');
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
    var
        Location: Record Location;
        Item: Record Item;
        SimulationMode: Boolean;
    begin
        EVALUATE(SimulationMode, ValidateOnly);
        if not SimulationMode then begin
            TempXMLBuffer.AddElement('ItemNo', ItemNo_SKU);
            TempXMLBuffer.AddElement('LocationCode', LocationCode);
        end else begin
            if ItemNo_SKU = '' then begin
                Item.SETRANGE(Type, Item.Type::Inventory);
                Item.SETRANGE(Inventory, 0);
                if Item.FINDLAST() then
                    TempXMLBuffer.AddElement('ItemNo', Item."No.");
            end else
                if Item.GET(ItemNo_SKU) then
                    TempXMLBuffer.AddElement('ItemNo', ItemNo_SKU);
            if LocationCode = '' then begin
                Location.FINDLAST();
                TempXMLBuffer.AddElement('LocationCode', Location.Code);
            end else
                TempXMLBuffer.AddElement('LocationCode', LocationCode);
        end;
        TempXMLBuffer.AddElement('Blocked', Blocked_SKU);
        TempXMLBuffer.AddElement('PlantSpecificMaterialStatus', PlantSpecificMaterialStatus);
        TempXMLBuffer.AddElement('StandardCost', StandardCost);
        TempXMLBuffer.AddElement('LotSize', LotSize);
        TempXMLBuffer.AddElement('FlushingMethod', FlushingMethod);
        TempXMLBuffer.AddElement('ReplenishmentSystem', ReplenishmentSystem);
        TempXMLBuffer.AddElement('PhysInvtCountingPeriodCode', PhysInvtCountingPeriodCode);
        TempXMLBuffer.AddElement('Scrap', Scrap);
        TempXMLBuffer.AddElement('OverheadRate', OverheadRate);
        TempXMLBuffer.AddElement('IndirectCost', IndirectCost);
        TempXMLBuffer.AddElement('QualityStandardNo', QualityStandardNo);
        TempXMLBuffer.AddElement('QuarantinePostingPolicy', QuarantinePostingPolicy);
        TempXMLBuffer.AddElement('RPMSolution', RPMSolution);
        //<<HEI.02
        TempXMLBuffer.AddElement('LeadTimeCalculation', LeadTimeCalculation);
        TempXMLBuffer.AddElement('ReorderingPolicy', ReorderingPolicy);
        TempXMLBuffer.AddElement('ReorderPoint', ReorderPoint);
        TempXMLBuffer.AddElement('ReorderQuantity', ReorderQuantity);
        //HEI.02>>
        TempXMLBuffer.AddElement('MinimumOrderQty', MinimumOrderQty);
        TempXMLBuffer.AddElement('MaximumOrderQty', MaximumOrderQty);
        TempXMLBuffer.AddElement('SafetyStockQty', SafetyStockQty);
        TempXMLBuffer.AddElement('SafetyLeadTime', SafetyLeadTime);
        TempXMLBuffer.AddElement('TimeBucket', TimeBucket);
        TempXMLBuffer.AddElement('OverflowLevel', OverflowLevel);
        TempXMLBuffer.AddElement('OrderMultiple', OrderMultiple);
        //HEI.03>>
        TempXMLBuffer.AddElement('BackorderType', BackorderType);
        BackorderType := '';
        //HEI.03<<

        //HEI.04>>
        TempXMLBuffer.AddElement('CCCDimCode', CCCDimCode);
        CCCDimCode := '';
        //HEI.04<<

        MinimumOrderQty := '';
        MaximumOrderQty := '';
        SafetyLeadTime := '';
        SafetyStockQty := '';
        TimeBucket := '';
        OverflowLevel := '';
        OrderMultiple := '';
        LeadTimeCalculation := '';
        ReorderingPolicy := '';
        ReorderPoint := '';
        ReorderQuantity := '';
        //HEI.02<<
        ItemNo_SKU := '';
        LocationCode := '';
        Blocked_SKU := '';
        PlantSpecificMaterialStatus := '';
        StandardCost := '';
        LotSize := '';
        FlushingMethod := '';
        ReplenishmentSystem := '';
        PhysInvtCountingPeriodCode := '';
        Scrap := '';
        OverheadRate := '';
        IndirectCost := '';
        QualityStandardNo := '';
        QuarantinePostingPolicy := '';
        RPMSolution := '';
        //<<HEI.02
        LeadTimeCalculation := '';
        ReorderingPolicy := '';
        ReorderPoint := '';
        ReorderQuantity := '';
        //HEI.02>>
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

