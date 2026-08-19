reportextension 51003 "Phys. Inventory List Ext CBN" extends "Phys. Inventory List"
{

    dataset
    {
        add(ItemTrackingSpecification)
        {
            column(ReservEntryBufferQtyInvUoM; GetReservEntryBufferQtyInvUoM(TempReservationEntryBuffer."Quantity (Base)")) { }
        }
        add("Item Journal Line")
        {
            column(UOM_ItemJournalLine; "Item Journal Line"."Unit of Measure Code") { IncludeCaption = true; }
            column(InventUnitofMeasureCode_ItemJournalLine; "Item Journal Line"."Invent. Unit of Measur Cod FND") { IncludeCaption = true; }
            column(QtyCalculatedinInvUoM_ItemJournalLine; "Item Journal Line"."Quantity in Inv. UoM FND") { IncludeCaption = true; }
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            Caption = 'Phys. Inventory List';
            LayoutFile = 'src\ReportsLayout\PhysInventoryList.rdl';
        }
    }

    LOCAL PROCEDURE GetReservEntryBufferQtyInvUoM(QtyBase: Decimal): Decimal;
    VAR
        Item: Record 27;
        UOMMgt: Codeunit 5402;
    BEGIN
        //<< HEI.01
        Item.GET("Item Journal Line"."Item No.");
        EXIT(UOMMgt.CalcQtyFromBase(QtyBase, UOMMgt.GetQtyPerUnitOfMeasure(Item, "Item Journal Line"."Invent. Unit of Measur Cod FND")));
        //>> HEI.01
    END;

}