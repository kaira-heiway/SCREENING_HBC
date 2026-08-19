namespace DTWMain_Ext.DTWMain_Ext;

using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Manufacturing.Routing;
using Microsoft.Inventory.Location;

//PATHAA02 13.07.26-To Update Items with Certified BOM and Routing from Certified SKUs. 
//This Report is useful for Standard Cost Functionality.


report 54050 "Update Item from Certified SKU"
{
    ApplicationArea = All;
    Caption = 'Update Item from Certified SKU';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Group)
                {
                    field(ItemNoFilter; ItemNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Item No.';
                        ToolTip = 'Enter an item number to process only SKUs for that item.';
                        TableRelation = Item;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        SKU: Record "Stockkeeping Unit";
        Item: Record Item;
        ProductionBOMHeader: Record "Production BOM Header";
        RoutingHeader: Record "Routing Header";
        HasCertifiedBOM: Boolean;
        HasCertifiedRouting: Boolean;
    begin
        SKU.Reset();
        SKU.SetRange("Replenishment System", SKU."Replenishment System"::"Prod. Order");
        if ItemNoFilter <> '' then
            SKU.SetFilter("Item No.", ItemNoFilter);
        if SKU.FindSet() then
            repeat
                if (SKU."Routing No." = '') and (SKU."Production BOM No." = '') then
                    continue;

                if not Item.Get(SKU."Item No.") then
                    continue;

                HasCertifiedBOM := false;
                HasCertifiedRouting := false;

                if SKU."Production BOM No." <> '' then begin
                    ProductionBOMHeader.Reset();
                    ProductionBOMHeader.SetRange("Linked Item No. FND", SKU."Item No.");
                    ProductionBOMHeader.SetRange("Linked SKU FND", SKU."Location Code");
                    ProductionBOMHeader.SetRange("No.", SKU."Production BOM No.");
                    ProductionBOMHeader.SetRange(Status, ProductionBOMHeader.Status::Certified);
                    HasCertifiedBOM := not ProductionBOMHeader.IsEmpty;
                end;

                if SKU."Routing No." <> '' then begin
                    RoutingHeader.Reset();
                    RoutingHeader.SetRange("Linked Item No. FND", SKU."Item No.");
                    RoutingHeader.SetRange("Linked SKU FND", SKU."Location Code");
                    RoutingHeader.SetRange("No.", SKU."Routing No.");
                    RoutingHeader.SetRange(Status, RoutingHeader.Status::Certified);
                    HasCertifiedRouting := not RoutingHeader.IsEmpty;
                end;

                if HasCertifiedBOM or HasCertifiedRouting then begin
                    Item."New Location Code FND" := SKU."Location Code";
                    if HasCertifiedRouting then
                        Item."Routing No." := SKU."Routing No.";
                    if HasCertifiedBOM then
                        Item."Production BOM No." := SKU."Production BOM No.";
                    Item.Modify(true);
                    UpdatedItems += 1;
                end;
            until SKU.Next() = 0;
    end;

    trigger OnPostReport()
    begin
        if UpdatedItems = 0 then
            Message('No matching SKUs were updated.')
        else
            Message('%1 item(s) were updated.', UpdatedItems);
    end;

    var
        UpdatedItems: Integer;
        ItemNoFilter: Text;
}
