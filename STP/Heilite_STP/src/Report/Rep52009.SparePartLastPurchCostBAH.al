report 52009 "Spare Part Last Purch Cost BAH"
{
    // version HEI.01
    //*******************//
    //BC UPGRADE ATHUKS01//
    //1.VendorName increases size 50 to 100 & Base application uses 100.if we are not increases size report will
    //stop when vendor name is more than 50
    //2. No Drink IT code & HEI tag
    //BC upgrade ATHUKS01 Old ID-50151
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Spare Part Last Purch Cost BAH.rdl';
    Caption = 'Spare Part Last Purch Cost BAH';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
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
            column(VendorCptFilter; Vendor.TABLECAPTION + ': ' + Vendor.GETFILTERS)
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
            column(ItemVendorNo; VendorNo)
            {
            }
            column(ItemVendorName; VendorName)
            {
            }
            column(ItemLastDirectCost; VendorDirectCost)
            {
            }
            column(ItemVendCurrCode; VendorCurrCode)
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
                            //VendorDirectCost := PurchInvLines."Direct Unit Cost";
                            //VendorDirectCost := Item."Last Direct Cost";
                            VendorDirectCost := PurchInvLines."Direct Unit Cost";

                            VendorCurrCode := PurchInvHeader."Currency Code";
                        end;
                    until (PurchInvHeader.NEXT(-1) = 0) or ItemLineFound;


                GoodVendorNo := false;
                if VendorRec.FINDSET() then
                    repeat
                        GoodVendorNo := (VendorRec."No." = VendorNo)
                    until (VendorRec.NEXT() = 0) or (GoodVendorNo);
                if not GoodVendorNo then
                    CurrReport.SKIP();
            end;

            trigger OnPreDataItem();
            begin
                ManufacturingSetup.GET();
                // ManufacturingSetup.TESTFIELD("SP Item Category Filter");
                SETFILTER("Item Category Code", ManufacturingSetup."SP Item Category Filter FND");
            end;
        }
        dataitem(Vendor; Vendor)
        {
            MaxIteration = 1;
            RequestFilterFields = "No.", Name;
            //ReqFilterHeading = 'Item Vendor Filter';
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        ReportTitle_lbl = 'Spare Part Last Direct Cost'; ItemNo_lbl = 'Item No.'; ItemDescr_lbl = 'Item Description'; CurrCode_lbl = 'Currency Code'; LastDirectCost_lbl = 'Last Direct Cost'; ItemVendorNo_lbl = 'Item Vendor No.'; ItemVendorName_lbl = 'Item Vendor Name';
    }

    trigger OnInitReport();
    begin
        ReportTitle := 'Spare Parts Last Direct Cost';
    end;

    trigger OnPreReport();
    begin
        //Vendor.COPYFILTER(Name, VendorRec.Name);
        VendorRec.COPYFILTERS(Vendor)
    end;

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
}

