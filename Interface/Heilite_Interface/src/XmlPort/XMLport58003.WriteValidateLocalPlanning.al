xmlport 58003 "Write/Validate Local Planning"
{
    // Heilite Navision Old Id - 50004
    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 28.06.2017 # New xmlport for importing material from Mendix
    // HEI.02 FDD-PRDGAP061 IBM HORTOC01 14.01.2019 # new fields "Order TRacking Policy","Minimum Order Quantity","Maximum Order Quantity","Safety Stock Quantity","Order Multiple","Safety Lead Time","Time Bucket","Overflow Level"
    // HEI.03 CHG2013123 TUDOSG01 IBM 11.03.2020 - added new fields: StrengthMethod, StrengthSpecificCode, StrengthSpecValue
    // HEI.04 CHG2013123 IBM.LS 16.03.2020
    //   # Corrected the following 3 fields property values;
    //   # 1) StrengthMethod
    //   # 2) StrengthSpecificCode
    //   # 3) StrengthSpecValue

    // BC Upgrade VAMSIU01 >>
    // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer); - Commented(Blocked temporarily as this function is dependent on Dotnet variables).
    // InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); - Added.
    // procedure GetTempBlob(var NewTempBlob: Record TempBlob); - Commented(BLocked as TempBlob Record is obsolete)
    // procedure GetTempBlob(var NewTempBlob: Codeunit ""Temp Blob"");" - Added.
    // TempBlob : Record TempBlob temporary; - Commented(BLocked as TempBlob Record is obsolete)
    // TempBlob: Codeunit "Temp Blob"; -Added
    // BC Upgrade VAMSIU01 <<

    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/WriteMaterialLocalPlanning';
    UseDefaultNamespace = true;

    schema
    {
        textelement(webMaterialWriteLocalPlanning)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            textelement(ValidateOnly)
            {
                MaxOccurs = Once;
                MinOccurs = Once;

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('webMaterialWriteLocalPlanning');
                    TempXMLBuffer.AddElement('ValidateOnly', ValidateOnly);
                end;
            }
            textelement(ItemLocalPlanning)
            {
                MaxOccurs = Unbounded;
                MinOccurs = Zero;
                textelement(No)
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
                }

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('ItemLocalPlanning');
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
        TempXMLBuffer.AddElement('Reserve', Reserve);
        TempXMLBuffer.AddElement('SalesUoM', SalesUoM);
        TempXMLBuffer.AddElement('PurchUoM', PurchUoM);
        TempXMLBuffer.AddElement('ItemTrackingCode', ItemTrackingCode);
        TempXMLBuffer.AddElement('LotNos', LotNos);
        TempXMLBuffer.AddElement('ReturnReasonCode', ReturnReasonCode);
        TempXMLBuffer.AddElement('MancoSurplusTolerance', MancoSurplusTolerance);
        TempXMLBuffer.AddElement('GiftBoxItem', GiftBoxItem);
        TempXMLBuffer.AddElement('BatchNumberingPolicy', BatchNumberingPolicy);
        TempXMLBuffer.AddElement('SerialNos', SerialNos);
        TempXMLBuffer.AddElement('ServiceItemGroup', ServiceItemGroup);
        TempXMLBuffer.AddElement('ItemSegmentation', ItemSegmentation);
        TempXMLBuffer.AddElement('CertificationRequired', CertificationRequired);
        TempXMLBuffer.AddElement('RotatingItem', RotatingItem);
        TempXMLBuffer.AddElement('MachineReferenceNumber', MachineReferenceNumber);
        TempXMLBuffer.AddElement('RoundingPrecision', RoundingPrecision);
        TempXMLBuffer.AddElement('RPMSolution', RPMSolution);
        TempXMLBuffer.AddElement('ProductionUoM', ProductionUoM);
        TempXMLBuffer.AddElement('InventoryUoM', InventoryUoM);
        TempXMLBuffer.AddElement('StrengthMethod', StrengthMethod);//HEI.03
        TempXMLBuffer.AddElement('StrengthSpecificCode', StrengthSpecificCode);//HEI.03
        TempXMLBuffer.AddElement('StrengthSpecValue', StrengthSpecValue);//HEI.03

        //HEI.02>>
        TempXMLBuffer.AddElement('OrderTrackingPolicy', OrderTrackingPolicy);
        OrderTrackingPolicy := '';
        //HEI.02<<
        No := '';
        Reserve := '';
        SalesUoM := '';
        PurchUoM := '';
        ItemTrackingCode := '';
        LotNos := '';
        ReturnReasonCode := '';
        MancoSurplusTolerance := '';
        GiftBoxItem := '';
        BatchNumberingPolicy := '';
        SerialNos := '';
        ServiceItemGroup := '';
        ItemSegmentation := '';
        CertificationRequired := '';
        RotatingItem := '';
        MachineReferenceNumber := '';
        RoundingPrecision := '';
        RPMSolution := '';
        ProductionUoM := '';
        InventoryUoM := '';
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

