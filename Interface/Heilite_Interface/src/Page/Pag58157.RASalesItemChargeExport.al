page 58157 "RA Sales Item Charge Export"
{
    // HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019 # Object Created
    // BC Upgrade SHUKLP03 >> Old object ID 50359. Restuctured code according to new table and field.

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "RA Sales Item Depos charge INT";
    SourceTableTemporary = true;
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ItemCode; Rec."Item No.")
                {
                }
                field(RelatedItemCode; Rec."Empty Goods Code")
                {
                }
                field(RelatedQty; Rec."Qty. Per Base UOM")
                {
                }
                field(ValidateItems; ValidateItems)
                {
                }
                field(RelatedNetPrice; UnitPrice)
                {
                }
                field(RelatedItemCode2; RelatedItemCode2)
                {
                    NotBlank = true;
                }
                field(RelatedQty2; RelatedQty2)
                {
                }
                field(RelatedNetPrice2; RelatedNetPrice2)
                {
                }
                field(RelatedMandatory; RelatedMandatory)
                {
                }
                field(Sysmodified; format(Rec.SystemModifiedAt))
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    var
        SalesDepositQuery: Query "Sales Deposit Query";
    begin
        Item.Get(Rec."Item No.");
        ShowRecord := true;
        ValidateItems := 1;
        // UnitPrice := Rec."Qty. Per Base UOM" * "Unit Price"; // BC Upgrade SHUKLP03 << Obsolete "Unit Price"
        UnitPrice := Rec."Qty. Per Base UOM";
        // RelatedItemCode2 := '';
        // RelatedQty2 := '';
        // RelatedNetPrice2 := '';
        // PopulateDeposits(Rec."Item No.");

    end;

    trigger OnOpenPage();
    begin
        // Item.RESET();
        // Item.SETFILTER("Code 104FDW", '<>%1', '');
        // Item.SetRange("Is Empty Good 104FDW", FALSE);
        // IF Item.FindSet() Then

        HideValues := true;
        // OrtecKStoreInterfaceSetup.GET;
        // SETRANGE("Item Charge Type", OrtecKStoreInterfaceSetup."Item Charge Type");  // BC Upgrade SHUKLP03 << Obsolete
        RelatedMandatory := true;
        FillLines;
    end;

    var
        // OrtecKStoreInterfaceSetup: Record "Ortec & KStore Interface Setup";
        RelatedMandatory: Boolean;
        Item: Record Item;
        ShowRecord: Boolean;
        UnitPrice: Decimal;
        TempSalesDepositItemCharge: Record ItemClassification104FDW temporary;
        SalesDepositItemCharge: Record ItemClassification104FDW;
        ValidateItems: Integer;
        RelatedItemCode2: Code[20];
        RelatedQty2: Text;
        RelatedNetPrice2: Text;
        SalesDepositItemCharge2: Record "RA Sales Item Depos charge INT";
        HideValues: Boolean;

    local procedure ConvertDate(SysModified: Date): Text;
    var
        ReturnDate: Text;
    begin
        ReturnDate := FORMAT(SysModified, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:' + '00:00.000+00:00';
        exit(ReturnDate);
    end;

    // local procedure FillLines();
    // var
    //     SalesDepositQuery: Query "Sales Deposit Query";
    // begin
    //     // rec.DeleteAll();
    //     Rec.Reset();

    //     SalesDepositQuery.OPEN;
    //     while SalesDepositQuery.READ
    //       do begin
    //         // SalesDepositItemCharge.SETRANGE("Source No.", SalesDepositQuery.No_);
    //         // SalesDepositItemCharge.RESET();
    //         // SalesDepositItemCharge.SETRANGE("Item No.", Item."No.");
    //         // SalesDepositItemCharge.SETFILTER("Source No.", '<>%1&<>%2', '', Item."No.");
    //         SalesDepositItemCharge.SETRANGE("Empty Goods Code", SalesDepositQuery.Empty_Goods_Code);
    //         if SalesDepositItemCharge.FindFirst() then begin

    //             Rec.SetRange("Empty Goods Code",
    //                          SalesDepositItemCharge."Empty Goods Code");
    //             Rec.SetRange("Item No.",
    //                          SalesDepositItemCharge."Item No.");

    //             if not Rec.FindFirst() then begin
    //                 Rec.Init();
    //                 Rec.TransferFields(SalesDepositItemCharge);
    //                 Rec.Insert();
    //             end;
    //         end;
    //     end;
    // end;
    local procedure FillLines()
    var
        Item: Record Item;
        ItemClassification: Record ItemClassification104FDW;
    begin
        Rec.DeleteAll();

        Item.SetFilter("Code 104FDW", '<>%1', '');
        Item.SetRange("Is Empty Good 104FDW", false);

        if Item.FindSet() then
            repeat

                ItemClassification.Reset();
                ItemClassification.SetRange(
                    "Empty Goods Code",
                    Item."Code 104FDW");

                if ItemClassification.FindSet() then
                    repeat
                        Rec.Init();

                        Rec."Item No." := Item."No.";
                        Rec."Empty Goods Code" :=
                            ItemClassification."Empty Goods Code";

                        Rec."Qty. Per Base UOM" :=
                            ItemClassification."Qty. Per Base UOM";
                        RelatedItemCode2 := Item."No.";
                        RelatedQty2 := FORMAT(ItemClassification."Qty. Per Base UOM");
                        // RelatedNetPrice2 := FORMAT(SalesDepositItemCharge2."Qty. Per Base UOM" * SalesDepositItemCharge2."Unit Price"); // BC Upgrade SHUKLP03 << Obsolete
                        RelatedNetPrice2 := FORMAT(ItemClassification."Qty. Per Base UOM");


                        if not Rec.Insert(false) then;

                    until ItemClassification.Next() = 0;

            until Item.Next() = 0;
    end;

    local procedure PopulateDeposits(SourceNo: Code[20]);
    begin
        SalesDepositItemCharge2.SETRANGE("Item No.", SourceNo);
        if SalesDepositItemCharge2.COUNT = 2 then
            if SalesDepositItemCharge2.FINDLAST then begin
                RelatedItemCode2 := SalesDepositItemCharge2."Item No.";
                RelatedQty2 := FORMAT(SalesDepositItemCharge2."Qty. Per Base UOM");
                // RelatedNetPrice2 := FORMAT(SalesDepositItemCharge2."Qty. Per Base UOM" * SalesDepositItemCharge2."Unit Price"); // BC Upgrade SHUKLP03 << Obsolete
                RelatedNetPrice2 := FORMAT(SalesDepositItemCharge2."Qty. Per Base UOM");
            end;
    end;
}

