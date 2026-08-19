page 58042 "DMS Interface Setup"
{
    // Heilite Navision Old Id - 50385

    // version HEI.02

    // HEI.01 FDD-HB1268 - CHG2068666 IBM NASTAA02 26.10.2020 # DMS Integration Ivory Coast
    //   # New Page created for DMS Interfaces
    // HEI.02 CHG2221799 IBM SISUM01 19.12.2023 HB3600 La Reunion DMS - Best Before Date
    //   # add field Lot Sent Enable

    Caption = 'DMS Interface Setup';
    SourceTable = "DMS Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Enable DMS Interfaces"; Rec."Enable DMS Interfaces")
                {
                    ToolTip = 'Specifies the value of the Enable DMS Interfaces field.';
                }
            }
            group("Interface Setup")
            {
                field("DMS Customer Interface"; Rec."DMS Customer Interface")
                {
                    ToolTip = 'Specifies the value of the DMS Customer Interface field.';
                }
                field("DMS Item Interface"; Rec."DMS Item Interface")
                {
                    ToolTip = 'Specifies the value of the DMS Item Interface field.';
                }
                field("DMS Shipment Interface"; Rec."DMS Shipment Interface")
                {
                    ToolTip = 'Specifies the value of the DMS Shipment Interface field.';
                }
            }
            group("Customer Interface Setup")
            {
                field("Customer Acc Group Filter"; Rec."Customer Acc Group Filter")
                {
                    ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                }
                field("Facility Type"; Rec."Facility Type")
                {
                    ToolTip = 'Specifies the value of the Facility Type field.';
                }
                field("Branch Server ID"; Rec."Branch Server ID")
                {
                    ToolTip = 'Specifies the value of the Branch Server ID field.';
                }
                field("Tax Loc Hierarchy Server ID"; Rec."Tax Loc Hierarchy Server ID")
                {
                    ToolTip = 'Specifies the value of the Tax Location Hierarchy Server ID field.';
                }
            }
            group("Item Interface Setup")
            {
                field("Item Category Filter"; Rec."Item Category Filter")
                {
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("Product Hierarchy"; Rec."Product Hierarchy")
                {
                    ToolTip = 'Specifies the value of the Product Hierarchy field.';
                }
            }
            group("Shipment Interface Setup")
            {
                field("Branch Server ID Ship"; Rec."Branch Server ID Ship")
                {
                    ToolTip = 'Specifies the value of the Branch Server ID Shipment field.';
                }
                field(OrderType; Rec.OrderType)
                {
                    ToolTip = 'Specifies the value of the Order Type field.';
                }
                field("PO Status"; Rec."PO Status")
                {
                    ToolTip = 'Specifies the value of the PO Status field.';
                }
                field("PO Type"; Rec."PO Type")
                {
                    ToolTip = 'Specifies the value of the PO Type field.';
                }
                field("Vendor ID"; Rec."Vendor ID")
                {
                    ToolTip = 'Specifies the value of the Vendor ID field.';
                }
                field("Lot Sent Enable"; Rec."Lot Sent Enable")
                {
                    ToolTip = 'Specifies the value of the Lot Sent Enable field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("DMS Items Included / Excluded")
            {
                Caption = 'DMS Items Included / Excluded';
                Image = Item;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = Page "DMS Items Incl. Excl.";
                ToolTip = 'Executes the DMS Items Included / Excluded action.';
            }
        }
    }
}

