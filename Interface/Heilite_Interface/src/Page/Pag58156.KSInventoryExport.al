page 58156 "KS Inventory Export"
{
    // HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019 # Item."Item Category Code" field added
    //                                             # code added to OnAfterGetRecord()
    // HEI.02 FDD-LC-HT736 IBM.GUNERE01 21.11.2019 # Route."Driver Code" field added

    //BC Upgrade SHIKHD02  >>
    // added application area and usage category
    // added Rec for fields and SETFILTER in trigger OnOpenPage()
    // Blocked Drink-IT field in layout - Route
    // Blocked Drink-IT field in trigger OnAfterGetRecord() for the fields - "Shipment Status", "Status", "Route"
    //BC Upgrade SHIKHD02  <<

    // BC Upgrade SHUKLP03 >> Moved trigger OnOpenPage() and field Batch in interface ext.

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Stockkeeping Unit";
    SourceTableView = SORTING("Location Code", "Item No.", "Variant Code")
                      WHERE(Inventory = FILTER(<> 0));

    //BC Upgrade SHIKHD02  >> added application area and usage category 
    ApplicationArea = All;
    UsageCategory = Lists;
    //BC Upgrade SHIKHD02  <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Warehouse; Rec."Location Code")
                {
                }
                field(ItemCode; Rec."Item No.")
                {
                }
                field(Stock; Rec.Inventory)
                {
                }
                field(QtyToBeDelivered; SalesLine."Outstanding Qty. (Base)")
                {
                }
                field(Sysmodified; ConvertDate(Rec."Last Date Modified"))
                {
                }
                // field(Batch; Batch) // BC Upgrade SHUKLP03 << Moved in interface ext.
                // {
                // }
                field(Batch; Batch)
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field(Type; Item."Item Category Code")
                {
                }
                //BC Upgrade SHUKLP03  >> Blocking because of Drink-IT field - Route
                field(Driver; Route.Driver)
                {
                }
                //BC Upgrade SHUKLP03 <<
                field(InventorySalesUoM; InventorySUoM)
                {
                    DecimalPlaces = 0 : 0;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();

    begin
        OrtecKStoreInterfaceSetup.GET();
        OrtecKStoreInterfaceSetup.TESTFIELD("Inventory Location Code");
        Rec.SETFILTER("Location Code", OrtecKStoreInterfaceSetup."Inventory Location Code");
        Batch := ' '
    end;

    trigger OnAfterGetRecord();
    var
        ItemUnitofMeasure: Record "Item Unit of Measure";
        SalesHeader: Record "Sales Header";
    begin
        SalesLine.RESET();
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETRANGE("No.", Rec."Item No.");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        //BC Upgrade SHUKLP03  >> find "Shipment Status" and "Status" from sales header because in line these fields are obsolete.
        // SalesLine.SETFILTER("Shipment Status", '<>%1', SalesLine."Shipment Status"::Invoice);
        // SalesLine.SETRANGE(Status, SalesLine.Status::Released);
        IF SalesLine.Findfirst then begin
            SalesHeader.Reset();
            SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
            SalesHeader.SetRange("No.", SalesLine."Document No.");
            SalesHeader.SETFILTER("Logistic Status 107FDW", '=%1', 'Invoice');
            SalesHeader.SetRange(Status, SalesHeader.Status::Released);
            IF SalesHeader.Findfirst then
                SalesLine.CALCSUMS("Outstanding Qty. (Base)");
        end;
        //BC Upgrade SHUKLP03  << find "Shipment Status" and "Status" from sales header because in line these fields are obsolete.

        Item.GET(Rec."Item No."); // HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019
        //Inventory in Sales Unit of Measure
        InventorySUoM := 0;
        if Item."Sales Unit of Measure" <> Item."Base Unit of Measure" then begin
            ItemUnitofMeasure.SETRANGE("Item No.", Item."No.");
            ItemUnitofMeasure.SETRANGE(Code, Item."Sales Unit of Measure");
            if ItemUnitofMeasure.FINDFIRST() then
                InventorySUoM := Rec.Inventory / ItemUnitofMeasure."Qty. per Unit of Measure";
        end else
            InventorySUoM := Rec.Inventory;
        //BC Upgrade SHUKLP03  >> Drink-IT Table - Route
        //>> HEI.01
        if Location.GET(Rec."Location Code") then
            if Route.GET(Location."Van Sales Route FND") then;
        //<< HEI.01
        //BC Upgrade SHUKLP03 <<
    end;

    // BC Upgrade SHUKLP03 >> Moved in interface ext.
    // trigger OnOpenPage();

    // begin
    //     OrtecKStoreInterfaceSetup.GET();
    //     OrtecKStoreInterfaceSetup.TESTFIELD("Inventory Location Code");
    //     Rec.SETFILTER("Location Code", OrtecKStoreInterfaceSetup."Inventory Location Code");
    //     Batch := ' '
    // end;
    // BC Upgrade SHUKLP03 << Moved in interface ext.

    var
        //OrtecKStoreInterfaceSetup: Record "Ortec & KStore Interface Setup INT"; // BC Upgrade SHUKLP03 << Moved in interface ext.
        SalesLine: Record "Sales Line";
        //Batch: Text;  // BC Upgrade SHUKLP03 << Moved in interface ext.
        Item: Record Item;
        //BC Upgrade SHUKLP03  >> Drink It --> Route
        Route: Record Route107FDW;
        //BC Upgrade SHUKLP03  <<
        Location: Record Location;
        OrtecKStoreInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";
        Text001: Label 'Inventory Location Code cannot be empty!';
        InventorySUoM: Decimal;

        Batch: Text;

    local procedure ConvertDate(SysModified: Date): Text;
    var
        ReturnDate: Text;
    begin
        ReturnDate := FORMAT(SysModified, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:' + '00:00.000+00:00';
        exit(ReturnDate);
    end;
}

