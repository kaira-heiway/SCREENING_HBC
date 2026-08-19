report 52008 "Spare Part Stock BAH"
{
    // version HEI.01
    //*******************//
    //BC UPGRADE ATHUKS01//
    //1.VendorName increases size 50 to 100 & Base application uses 100.if we are not increases size report will
    //stop when vendor name is more than 50
    //2. No Drink IT code & HEI tag
    //BC Upgrade ATHUKS01 Old ID- 50153
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Spare Part Stock BAH.rdl';
    Caption = 'Spare Part Stock BAH';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = Inventory, "Qty. on Purch. Order";
            RequestFilterFields = "No.", Description;
            column(CompanyName; COMPANYNAME)
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(ItemCptFilter; TABLECAPTION + ': ' + GETFILTERS)
            {
            }
            column(ItemFilter; USERID)
            {
            }
            column(ItemNo; Item."No.")
            {
            }
            column(ItemDescription; Item.Description)
            {
            }
            column(ItemCategoryCode; Item."Item Category Code")
            {
            }
            column(ItemInventory; Item.Inventory)
            {
            }
            column(ItemQtyOnPurchOrder; Item."Qty. on Purch. Order")
            {
            }
            column(ItemBaseUnitOfMeasure; Item."Base Unit of Measure")
            {
            }
            column(ItemStockValue; Item.Inventory * Item."Last Direct Cost")
            {
            }
            column(ItemVendorNo; VendorNo)
            {
            }
            column(ItemVendorName; VendorName)
            {
            }
            column(ItemLastDirectCost; Item."Last Direct Cost")
            {
            }

            trigger OnAfterGetRecord();
            begin

                CLEAR(VendorNo);
                CLEAR(VendorName);
                CLEAR(VendorCurrCode);
                VendorDirectCost := 0;
                ItemLineFound := false;

                PurchInvHeader.SETCURRENTKEY("Posting Date");
                if PurchInvHeader.FINDLAST() then
                    repeat
                        PurchInvLines.RESET();
                        PurchInvLines.SETRANGE("Document No.", PurchInvHeader."No.");
                        PurchInvLines.SETRANGE(Type, PurchInvLines.Type::Item);
                        PurchInvLines.SETRANGE("No.", Item."No.");
                        if PurchInvLines.FINDFIRST() then begin
                            ItemLineFound := true;
                            VendorNo := PurchInvHeader."Buy-from Vendor No.";
                            VendorName := PurchInvHeader."Buy-from Vendor Name";
                            VendorDirectCost := PurchInvLines."Direct Unit Cost";
                            VendorCurrCode := PurchInvHeader."Currency Code";
                        end;
                    until (PurchInvHeader.NEXT(-1) = 0) or ItemLineFound;
            end;


            trigger OnPreDataItem();
            begin
                ManufacturingSetup.GET();
                ManufacturingSetup.TESTFIELD("SP Item Category Filter FND");
                SETFILTER("Item Category Code", ManufacturingSetup."SP Item Category Filter FND");

                if InventoryFilter <> '' then
                    SETFILTER(Item.Inventory, InventoryFilter);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(MainGroup)
                {
                    field("Filter on Stock"; InventoryFilter)
                    {
                        ApplicationArea = all;
                        Caption = 'Filter on Stock';
                        ToolTip = 'Filter on Stock';
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
        ReportTitle_lbl = 'Spare Part Stock'; ItemNo_lbl = 'Item No.'; ItemDescr_lbl = 'Item Description'; Stock_lbl = 'Stock'; UM_lbl = 'UM'; StockValue_lbl = 'Stock Value'; DirectUnitCost_lbl = 'Direct Unit Cost'; QtyToBeDeliv_lbl = 'Quantity to be Delivered';
    }

    var
        ManufacturingSetup: Record "Manufacturing Setup";
        VendorRec: Record Vendor;
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLines: Record "Purch. Inv. Line";
        VendorNo: Code[20];
        VendorName: Text[100];
        VendorDirectCost: Decimal;
        ItemLineFound: Boolean;
        VendorCurrCode: Code[10];
        ReportTitle: Text[150];
        GoodVendorNo: Boolean;
        InventoryFilter: Text[250];
}

