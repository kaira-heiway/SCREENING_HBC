page 51084 "SKU Sales Inventory CBN"
{
    // version HEI.01

    // HEI.01 IBM.AK PATHAA02 CHG2056363 23.09.20
    //  # New Page (Replica of Stock Keeping Unit Page) with Customised Fields to show quantities in Sales UoM
    //**********************************************************************************************************
    //BC UPGRADE PATHAA02-21.11.25
    //DIT field commented

    Caption = 'SKU Sales Inventory';
    CardPageID = "Stockkeeping Unit Card";
    Editable = false;
    PageType = List;
    SourceTable = "Stockkeeping Unit";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTipML = ENU = 'Specifies the item number to which the SKU applies.',
                                FRA = 'Spécifie le numéro de l''article auquel s''applique le point de stock.';
                }
                field(Description; Rec.Description)
                {
                    ToolTipML = ENU = 'Specifies the description from the Item Card.',
                                FRA = 'Spécifie la description de la fiche article.';
                }
                field("Item Category Code"; Rec."Item Category Code FND")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field(ItemCategoryCode; ItemCategoryCode)
                {
                    Caption = 'Item Category Code';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTipML = ENU = 'Specifies the location code (for example, the warehouse or distribution center) to which the SKU applies.',
                                FRA = 'Spécifie le code magasin (par exemple, l''entrepôt ou le centre de distribution) auquel s''applique le point de stock.';
                }
                field("Sales UoM"; SalesUoM)
                {
                    ToolTip = 'Specifies the value of the SalesUoM field.';
                }
                field(Inventory; SalesInv)
                {
                    Caption = 'Inventory';
                    ToolTip = 'Specifies the value of the Inventory field.';
                }
                field("<Available Inv. (Whse)>"; AvailableInvWhse)
                {
                    Caption = 'Available Inv. (Whse)';
                    ToolTip = 'Specifies the value of the Available Inv. (Whse) field.';
                }
                field("<Qty. on Prod. Order>"; qtyprodOrd)
                {
                    Caption = 'Qty. on Prod. Order';
                    ToolTip = 'Specifies the value of the Qty. on Prod. Order field.';
                }
                field("<Qty. on Purch. Order>"; qtyPurchOrd)
                {
                    Caption = 'Qty. on Purch. Order';
                    ToolTip = 'Specifies the value of the Qty. on Purch. Order field.';
                }
                field("<Qty. on Sales Order>"; qtySalesOrd)
                {
                    Caption = 'Qty. on Sales Order';
                    ToolTip = 'Specifies the value of the Qty. on Sales Order field.';
                }
                field("<Qty. in Transit>"; qtyTransit)
                {
                    Caption = 'Qty. in Transit';
                    ToolTip = 'Specifies the value of the Qty. in Transit field.';
                }
                field("Inventory Base UoM"; InvBUoM)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the InvBUoM field.';
                }
                field("<Inventory BUoM>"; Rec.Inventory)
                {
                    CaptionML = ENU = 'Inventory BUoM',
                                FRA = 'Stocks';
                    ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.',
                                FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
                    Visible = false;
                }
                field("Available Inv. (Whse)"; Rec."Available Inv. (Whse) FND")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Available Inv. (Whse) field.';
                }
                field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
                {
                    Visible = false;
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                }
                field("Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
                {
                    Visible = false;
                    ToolTip = 'Specifies how many item units have been planned for production, which is how many units are on outstanding production order lines.';
                }
                field("Qty. on Component Lines"; Rec."Qty. on Component Lines")
                {
                    Visible = false;
                    ToolTip = 'Specifies how many item units are needed for production, which is how many units remain on outstanding production order component lists.';
                }
                field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
                {
                    Visible = false;
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                }
                //BC UPGRADE PATHAA02-DIT>>
                // field("Qty. on Sales Blanket Order"; Rec."Qty. on Sales Blanket Order")
                // {
                //     Visible = false;
                // }
                //BC UPGRADE PATHAA02-DIT<<
                field("Qty. in Transit"; Rec."Qty. in Transit")
                {
                    Visible = false;
                    ToolTip = 'Specifies the quantity of the SKUs in transit. These items have been shipped, but not yet received.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    var
        Item: Record Item;
    begin

        if Item.GET(Rec."Item No.") then begin
            SalesUoM := Item."Sales Unit of Measure";
            InvBUoM := Item."Base Unit of Measure";
        end;

        if SalesUoM <> '' then
            if RecIteUOM.GET(Rec."Item No.", SalesUoM) then begin
                SalesQtyUOM := RecIteUOM."Qty. per Unit of Measure";
                Rec.CALCFIELDS(Inventory, "Available Inv. (Whse) FND", "Qty. on Prod. Order", "Qty. on Purch. Order", "Qty. on Sales Order", "Qty. in Transit");
                SalesInv := Rec.Inventory / SalesQtyUOM;
                AvailableInvWhse := Rec."Available Inv. (Whse) FND" / SalesQtyUOM;
                qtyprodOrd := Rec."Qty. on Prod. Order" / SalesQtyUOM;
                qtyPurchOrd := Rec."Qty. on Purch. Order" / SalesQtyUOM;
                qtySalesOrd := Rec."Qty. on Sales Order" / SalesQtyUOM;
                qtyTransit := Rec."Qty. in Transit" / SalesQtyUOM;
            end;
    end;

    trigger OnOpenPage();
    var
        Item: Record Item;
    begin

        Rec.SETFILTER("Item Category Code FND", '%1|%2', '01', '15');
    end;

    var
        RecIteUOM: Record "Item Unit of Measure";
        SPVisible: Boolean;
        InvBUoM: Code[10];
        SalesUoM: Code[10];
        ItemCategoryCode: Code[20];
        AvailableInvWhse: Decimal;
        qtyprodOrd: Decimal;
        qtyPurchOrd: Decimal;
        qtySalesOrd: Decimal;
        qtyTransit: Decimal;
        SalesInv: Decimal;
        SalesQtyUOM: Decimal;
}

