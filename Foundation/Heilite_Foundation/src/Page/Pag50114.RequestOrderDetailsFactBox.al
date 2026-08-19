page 50114 "Request Order Details FactBox"
{
    // version HEI.02

    // HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New FactBox Page created
    // HEI.02 Defect #3388 IBM NASTAA02 30.10.2018 # Request Order - Multiple Adjustments
    //   # New Fields added: "Total Actual Quantity" and "Total Outstanding Quantity"
    // HEI.03 Defect #3453 IBM NASTAA02 06.11.2018 # Request Order - multiple corrections
    //   # New Field created "Item Availability by From-Code"

    Caption = 'Request Order Details';
    PageType = CardPart;
    SourceTable = "Request Order Line FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(ItemNo; Rec."Item No.")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Item No.',
                            FRA = 'N° article';
                Lookup = false;
                ToolTipML = ENU = 'Specifies the item that is handled on the sales line.',
                            FRA = 'Spécifie l''article géré sur la ligne vente.';

                trigger OnDrillDown();
                begin
                    LookupItem();
                end;
            }
            field("Required Quantity"; Rec."Outstanding Qty.")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Required Quantity',
                            FRA = 'Quantité requise';
                DecimalPlaces = 0 : 5;
                ToolTipML = ENU = 'Specifies how many units of the item are required on the sales line.',
                            FRA = 'Spécifie le nombre d''unités de l''article nécessaires sur la ligne vente.';
            }
            field("Request Date"; RequestHeader."Request Date")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Request Date';
                ToolTip = 'Specifies the value of the Request Date field.';
            }
            //field("Item Availability";SalesInfoPaneMgt.CalcAvailabilityForRequestOrder(Rec))  // BC Upgrade KAMNAY01
            field("Item Availability"; HNKBCFunctionsCU.CalcAvailabilityByFromCodeForRequestOrder(Rec))  // BC Upgrade KAMNAY01
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Item Availability',
                            FRA = 'Disponibilité article';
                DecimalPlaces = 2 : 0;
                DrillDown = true;
                ToolTipML = ENU = 'Specifies how may units of the item on the sales line are available, in inventory or incoming before the shipment date.',
                            FRA = 'Spécifie combien d''unités de l''article de la ligne vente sont disponibles, en stock ou entrantes avant la date d''expédition.';

                trigger OnDrillDown();
                begin
                    //ItemAvailFormsMgt.ShowItemAvailFromRequestOrderLine(RequestHeader, Rec, 2);  // BC Upgrade KAMNAY01
                    HNKBCFunctionsCU.ShowItemAvailFromRequestOrderLine(RequestHeader, Rec, 2);  // BC Upgrade KAMNAY01
                    CurrPage.UPDATE(true);
                end;
            }
            //field("Item Availability by From-Code"; SalesInfoPaneMgt.CalcAvailabilityByFromCodeForRequestOrder(Rec))  // BC Upgrade KAMNAY01
            field("Item Availability by From-Code"; HNKBCFunctionsCU.CalcAvailabilityByFromCodeForRequestOrder(Rec))  // BC Upgrade KAMNAY01
            {
                Caption = 'Item Availability by From-Code';
                Description = 'HEI.03';
                ToolTip = 'Specifies the value of the Item Availability by From-Code field.';

                trigger OnDrillDown();
                begin
                    //HEI.03>>
                    //ItemAvailFormsMgt.ShowItemAvailByFromCodeFromRequestOrderLine(RequestHeader, Rec, 2);   // BC Upgrade KAMNAY01
                    HNKBCFunctionsCU.ShowItemAvailByFromCodeFromRequestOrderLine(RequestHeader, Rec, 2);   // BC Upgrade KAMNAY01
                    CurrPage.UPDATE(true);
                    //HEI.03<<
                end;
            }
            field(UnitofMeasureCode; Rec."Unit of Measure Code")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Unit of Measure Code',
                            FRA = 'Code unité';
                ToolTipML = ENU = 'Specifies the unit of measure that is used to determine the value in the Unit Price field on the sales line.',
                            FRA = 'Spécifie l''unité de mesure utilisée pour déterminer la valeur dans le champ Prix unitaire de la ligne vente.';
            }
            field("Total Actual Quantity"; Rec."Total Actual Quantity")
            {
                ToolTip = 'Specifies the value of the Total Actual Quantity field.';
            }
            field("Total Outstanding Quantity"; Rec."Total Outstanding Quantity")
            {
                ToolTip = 'Specifies the value of the Total Outstanding Quantity field.';
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        if RequestHeader.GET(Rec."Document No.") then;
    end;

    var
        Item: Record Item;
        RequestHeader: Record "Request Order Header FND";
        RequestLine: Record "Request Order Line FND";
        HNKBCFunctionsCU: Codeunit "Heineken BC Custom Functions";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";

    local procedure LookupItem();
    begin
        RequestLine.GET(Rec."Document No.", Rec."Line No.");
        RequestLine.TESTFIELD("Item No.");
        Item.GET(RequestLine."Item No.");
        PAGE.RUNMODAL(PAGE::"Item Card", Item);
    end;
}

