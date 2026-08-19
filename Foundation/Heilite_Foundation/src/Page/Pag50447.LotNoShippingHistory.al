page 50447 "Lot No. Shipping History"
{
    // HEI.01 CHG2095415 IBM BULIMC01 11.03.2021#new page created to store Lot No. info related to Shipping costs

    Caption = 'Lot No. Shipping History';
    Editable = false;
    PageType = List;
    SourceTable = "Shipping Cost Allocation FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Lot No."; rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Posted Source Document"; rec."Posted Source Document")
                {
                    ToolTip = 'Specifies the value of the Posted Source Document field.';
                }
                field("Posted Source Document No."; rec."Posted Source Document No.")
                {
                    ToolTip = 'Specifies the value of the Posted Source Document No. field.';
                }
                field("Item No."; rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Description; rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Location Code"; rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Destination Type"; rec."Destination Type")
                {
                    ToolTip = 'Specifies the value of the Destination Type field.';
                }
                field("Destination No."; rec."Destination No.")
                {
                    ToolTip = 'Specifies the value of the Destination No. field.';
                }
                field("Quantity (Base UoM)"; rec."Quantity (Base UoM)")
                {
                    ToolTip = 'Specifies the value of the Quantity (Base UoM) field.';
                }
                field("Net Weight (Kg)"; rec."Net Weight (Kg)")
                {
                    ToolTip = 'Specifies the value of the Net Weight (Kg) field.';
                }
                field("Total Net Weight (Kg)"; rec."Total Net Weight (Kg)")
                {
                    ToolTip = 'Specifies the value of the Total Net Weight (Kg) field.';
                }
                field("Primary Allocated Amount"; rec."Primary Allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Primary Allocated Amount field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                CaptionML = ENU = '&Line',
                            FRA = '&Ligne';
                Image = Line;
                action("Show Document")
                {
                    CaptionML = ENU = 'Show Document',
                                FRA = 'Afficher Document';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Executes the Show Document action.';

                    trigger OnAction();
                    begin
                        rec.ShowDocument();
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    CaptionML = ENU = 'Dimensions',
                                FRA = 'Axes analytiques';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction();
                    begin
                        rec.ShowDimensions();
                        CurrPage.SAVERECORD();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        if rec.findset() then
            repeat
                rec.SETRANGE("Lot No.", LotNo);
                rec.SETRANGE("Item No.", ItemNo);
                rec.SETRANGE("Posted Source Document", DocType);
            until rec.NEXT() = 0;
    end;

    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemLedgEntriesPage: Page "Item Ledger Entries";
        ItemNo: Code[20];
        LotNo: Code[20];
        QtyPerUoM: Decimal;
        RemainingILEQty: Decimal;
        RemainingQty: Decimal;
        RemainingTransfAmt: Decimal;
        RemainingWeight: Decimal;
        TransferAmount: Decimal;
        TransferUnitCost: Decimal;
        Text001: Label 'Formula: Net Weight * (Total Shipping Cost Amount/Total Net Weight)';
        Text002: Label 'Formula: Internal Transfer Allocated Amount / Net Weight';
        DocType: Option " ","Posted Receipt",,"Posted Return Receipt",,"Posted Shipment",,"Posted Return Shipment",,"Posted Transfer Receipt","Posted Transfer Shipment";

    procedure GetFilters(LotFilter: Code[20]; ItemFilter: Code[20]; DocTypeFilter: Option " ","Posted Receipt",,"Posted Return Receipt",,"Posted Shipment",,"Posted Return Shipment",,"Posted Transfer Receipt","Posted Transfer Shipment");
    begin
        LotNo := LotFilter;
        ItemNo := ItemFilter;
        DocType := DocTypeFilter;
    end;
}

