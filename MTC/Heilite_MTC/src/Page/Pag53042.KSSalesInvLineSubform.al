page 53042 "KS Sales Inv Line Subform"
{
    // BC UPGRADE PATELS08 >>
    // # old page id 50347
    // # Blocked 'SourcetableView' as "Item Charge Type" is a DIT field
    // # added ApplicationArea and UsageCategory at page level
    // # added Rec. before field names
    // # Blocked 'if condition' in OnAfterGetRecord as "Item Charge Type" is a DIT field
    // BC UPGRADE PATELS08 <<

    PageType = ListPart;
    SourceTable = "Sales Invoice Line";

    // BC UPGRADE PATELS08 >> Blocked as "Item Charge Type" is a DIT field
    // SourceTableView = SORTING("Document No.","Line No.")
    //                   WHERE(Type=FILTER(Item|'"Charge (Item)"'),
    //                         "Item Charge Type" = FILTER(Deposit|" "));
    // BC UPGRADE PATELS08 <<

    // BC UPGRADE PATELS08 >> added ApplicationArea and UsageCategory at page level
    ApplicationArea = All;
    UsageCategory = None;
    // BC UPGRADE PATELS08 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(OrderNumber; Rec."Document No.")
                {
                }
                field(LineNumber; LineNo)
                {
                }
                field(DeliveryDate; ConvertDate(Rec."Shipment Date"))
                {
                }
                field(ItemCode; Rec."No.")
                {
                }
                field(ItemDescription; Rec.Description)
                {
                }
                field(Warehouse; Rec."Location Code")
                {
                }
                field(QtyDelivered; Rec.Quantity)
                {
                }
                field(QtyInvoiced; Rec.Quantity)
                {
                }
                field(Pricelist; Rec."Customer Price Group")
                {
                }
                field(UnitSalesPrice; Rec."Unit Price")
                {
                }
                field(TotalVATAmountLine; Rec."Amount Including VAT" - Rec.Amount)
                {
                }
                field(TotalGROSSAmountLine; Rec."Amount Including VAT")
                {
                }
                field(TotalNETAmountLine; Rec.Amount)
                {
                }
                field(Sysmodified; ConvertDate(Rec."Posting Date"))
                {
                }
                field(ItemType; ItemType)
                {
                }
                field(UnitCode; Rec."Unit of Measure Code")
                {
                }
                field(UnitFactor; UnitFactor)
                {
                }
                field(VATPercentage; Rec."VAT %")
                {
                }
                field(DefaultUoM; DefaultUoM)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        LineNo := COPYSTR(FORMAT(Rec."Line No."), 1, 4);

        // BC UPGRADE PATELS08 >> Blocked as "Item Charge Type" is a DIT field
        // if (Type = Type::"Charge (Item)") and ("Item Charge Type" = "Item Charge Type"::Deposit) then
        //   DefaultUoM := 'PC';
        // BC UPGRADE PATELS08 <<

    end;

    trigger OnOpenPage();
    begin
        ItemType := 'V';
        UnitFactor := '1';
    end;

    var
        ItemType: Text;
        UnitFactor: Text;
        LineNo: Text;
        DefaultUoM: Text;

    local procedure ConvertDate(SysModified: Date): Text;
    var
        ReturnDate: Text;
    begin
        ReturnDate := FORMAT(SysModified, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:' + '00:00.000+00:00';
        exit(ReturnDate);
    end;
}

