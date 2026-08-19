xmlport 58002 "Write/Validate Local Finance"
{

    // Heilite Navision Old Id - 50003
    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 28.06.2017 # New xmlport for importing material from Mendix
    // HEI.02 RFC254 IBM HORTOC01 21.05.2018 - new field
    // HEI.03 FDD PBRD HT401 BULIMC01 IBM 28.05.2019 - added new field "Sales Price Warning"
    // HEI.04 FDD BRDHT393 IBM BULIMC01 24.06.2019 #add new field "Inventory Value zero"
    // HEI.05 CHG2060049 HT1098 IBM.GUNERE01 10.04.2020 # new field "Commodity Code" added
    // HEI.06 CHG2063089 HB1343 IBM.KUMARN15 16/06/2020
    //   # ItemTaxGroupCode node added, code added
    // HEI.07 CHG2140629 HB2723 BHANDS01 20.01.2022
    //   # Added "Deposit Value Method","Deposit Value" and Added Code on AddXMLBufferElements()

    // BC Upgrade VAMSIU01 >>
    // InterfaceFrameworkMgt.SaveXMLToTempBlob(TempBlob, TempXMLBuffer); - Commented(Blocked temporarily as this function is dependent on Dotnet variables).
    // InterfaceFrameworkMgt.SaveXMLBufferToTempBlob(TempBlob, TempXMLBuffer); - Added.
    // procedure GetTempBlob(var NewTempBlob: Record TempBlob); - Commented(BLocked as TempBlob Record is obsolete)
    // procedure GetTempBlob(var NewTempBlob: Codeunit ""Temp Blob"");" - Added.
    // TempBlob : Record TempBlob temporary; - Commented(BLocked as TempBlob Record is obsolete)
    // TempBlob: Codeunit "Temp Blob"; -Added
    // BC Upgrade VAMSIU01 <<

    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/WriteMaterialLocalFinance';
    UseDefaultNamespace = true;

    schema
    {
        textelement(webMaterialWriteLocalFinance)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            textelement(ValidateOnly)
            {
                MaxOccurs = Once;
                MinOccurs = Once;

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('webMaterialWriteLocalFinance');
                    TempXMLBuffer.AddElement('ValidateOnly', ValidateOnly);
                end;
            }
            textelement(ItemLocalFinance)
            {
                MaxOccurs = Unbounded;
                MinOccurs = Zero;
                textelement(No)
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
                textelement(SalesPriceWarning)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(InventoryValueZero)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
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

                trigger OnAfterAssignVariable();
                begin
                    TempXMLBuffer.AddGroupElement('ItemLocalFinance');
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
        TempXMLBuffer.AddElement('InventoryPostingGroup', InventoryPostingGroup);
        TempXMLBuffer.AddElement('AllowInvoiceDiscount', AllowInvoiceDiscount);
        TempXMLBuffer.AddElement('CostingMethod', CostingMethod);
        TempXMLBuffer.AddElement('PriceIncludesVAT', PriceIncludesVAT);
        TempXMLBuffer.AddElement('GenProdPostingGroup', GenProdPostingGroup);
        TempXMLBuffer.AddElement('VATProdPostingGroup', VATProdPostingGroup);
        TempXMLBuffer.AddElement('ItemDepositGroupCode', ItemDepositGroupCode);
        TempXMLBuffer.AddElement('SplitDepositOnInvoice', SplitDepositOnInvoice);
        TempXMLBuffer.AddElement('AllowVATCalculationFree', AllowVATCalculationFree);
        TempXMLBuffer.AddElement('GenProdPostingGroupFreeItem', GenProdPostingGroupFreeItem);
        TempXMLBuffer.AddElement('CalculatePriceOnFree', CalculatePriceOnFree);
        TempXMLBuffer.AddElement('FreeItem', FreeItem);
        TempXMLBuffer.AddElement('WHTProductPostingGroup', WHTProductPostingGroup);//HEI.02
        TempXMLBuffer.AddElement('SalesPriceWarning', SalesPriceWarning);//HEI.03
        TempXMLBuffer.AddElement('InventoryValueZero', InventoryValueZero);//HEI.04
        TempXMLBuffer.AddElement('CommodityCode', CommodityCode);//HEI.05
        TempXMLBuffer.AddElement('ItemTaxGroupCode', ItemTaxGroupCode);  //HEI.06
        // HEI.07 >>
        TempXMLBuffer.AddElement('DepositValueMethod', DepositValueMethod);
        TempXMLBuffer.AddElement('DepositValue', DepositValue);
        // HEI.07 <<

        No := '';
        InventoryPostingGroup := '';
        AllowInvoiceDiscount := '';
        CostingMethod := '';
        PriceIncludesVAT := '';
        GenProdPostingGroup := '';
        VATProdPostingGroup := '';
        ItemDepositGroupCode := '';
        SplitDepositOnInvoice := '';
        AllowVATCalculationFree := '';
        GenProdPostingGroupFreeItem := '';
        CalculatePriceOnFree := '';
        FreeItem := '';
        WHTProductPostingGroup := '';//HEI.02
        SalesPriceWarning := ''; //HEI.03
        InventoryValueZero := ''; //HEI.04
        CommodityCode := ''; //HEI.05
        ItemTaxGroupCode := ''; //HEI.06
        // HEI.07 >>
        DepositValueMethod := '';
        DepositValue := '';
        // HEI.07 <<
    end;

    procedure GetSimulateMode() SimulateMode: Boolean;
    begin
        EVALUATE(SimulateMode, ValidateOnly);
    end;

    // BC Upgrade NANDIS03 <>>
    //procedure GetTempBlob(var NewTempBlob : Record TempBlob);
    procedure GetTempBlob(var NewTempBlob: Codeunit "Temp Blob");
    // BC Upgrade NANDIS03 <<
    begin
        NewTempBlob := TempBlob;
    end;
}

