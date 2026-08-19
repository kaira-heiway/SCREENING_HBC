page 53049 "KS Sales Cr. Memo Line Subform"
{
    //BC Upgrade MISHRS14  >>
    // #Old object id-50349
    // ADDED ApplicationArea
    // Blocking OnAfterGetRecord trigger because ----DITW Field - Item Charge type
    //BC Upgrade MISHRS14  <<

    PageType = ListPart;
    //BC Upgrade MISHRS14  >> ADDED ApplicationArea 
    ApplicationArea = All;
    //BC Upgrade MISHRS14  <<
    SourceTable = "Sales Cr.Memo Line";
    //BC Upgrade MISHRS14  >> Blocking because ----DITW Field - Item Charge type
    // SourceTableView = SORTING("Document No.","Line No.")
    //                   WHERE(Type=FILTER(Item|'"Charge (Item)"'),
    //                         "Item Charge Type"=FILTER(Deposit|" "));
    //BC Upgrade MISHRS14  <<

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
    //BC Upgrade MISHRS14  >> Blocking because ----DITW Field - Item Charge type
    // trigger OnAfterGetRecord();
    // begin
    //     LineNo := COPYSTR(FORMAT(Rec."Line No."),1,4);
    //     if (Type = Type::"Charge (Item)") and ("Item Charge Type" = "Item Charge Type"::Deposit) then
    //       DefaultUoM := 'PC';
    // end;
    // BC Upgrade MISHRS14 <<

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

