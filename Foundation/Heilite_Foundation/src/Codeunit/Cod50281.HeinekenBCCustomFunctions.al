namespace ALProject.ALProject;
using Microsoft.Inventory.Item;
using System.IO;
using System.Utilities;
using Microsoft.Inventory.Tracking;
using Microsoft.Sales.Receivables;
using Microsoft.Foundation.Navigate;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;
using Microsoft.Manufacturing.Setup;
using Microsoft.Manufacturing.Routing;
using Microsoft.Manufacturing.StandardCost;
using Microsoft.Inventory.Planning;
using Microsoft.Manufacturing.WorkCenter;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Item.Attribute;
using Microsoft.Warehouse.Structure;
using Microsoft.Inventory.Costing;
using Microsoft.Inventory.Setup;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Foundation.Enums;
using Microsoft.Foundation.UOM;
using Microsoft.Inventory.BOM.Tree;
using Microsoft.Inventory.BOM;
using Microsoft.Inventory.Location;
using System.Text;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.VAT.Setup;
using Microsoft.Sales.History;
using Microsoft.Utilities;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.Address;
using Microsoft.Inventory.Availability;
using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Reporting;
using Microsoft.CashFlow.Worksheet;

// BC Upgrade PATELP08 >> 
// Replaced integer document type with Document Entry Document Type enum to avoid implicit integer-to-enum conversion.
// Replacing Method 'ShowItemAvailByDate' as it is marked for removal. Reason: Replaced by procedure ShowItemAvailabilityByPeriod()
// Replacing Method 'ShowItemAvailByLoc' as it is marked for removal. Reason: Replaced by procedure ShowItemAvailabilityByLocation()
// Replacing Method 'ShowItemAvailByEvent' as it is marked for removal. Reason: Replaced by procedure ShowItemAvailabilityByEvent()
// Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
// Changed variable data type from Option to Enum of PeriodType since the procedure CalcQtyAvailableToPromise expects an Enum parameter and the values are compatible.
// Replaced Manufacturing Setup with Inventory Setup variables as field 'Default Safety Lead Time' is moved to Inventory Setup and marked for removal in Manufacturing Setup.
// BC Upgrade PATELP08 <<

// BC Upgrade RD03 - MANXL7 table commented
// BC Upgrade RD03 - DITW Fields commented 
// BC Upgrade RD03 - OnValidate (Quantity Per) field Calculation Changed 
// BC Upgrade RD03 - A custom function was created and used in NAV, and the same has been replicated in BC (CreateSplitComponentlinesforYeatMaterialGroup).
// BC Upgrade RD03 - A new custom function created to get Default Bin (GetDefaultBin)
codeunit 50281 "Heineken BC Custom Functions"
{
    SingleInstance = true;
    ///---BC Upgrade KAMNAY01>>---Request Order Line HEI.03
    procedure CalcAvailabilityByFromCodeForRequestOrder(VAR RequestLine: Record "Request Order Line FND"): Decimal
    var
        Item: record Item;
        RequestHeader: Record "Request Order Header FND";
        AvailableToPromise: Codeunit "Available to Promise";
        LookaheadDateformula: DateFormula;
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        // BC Upgrade PATELP08 >> Changed variable data type from Option to Enum of PeriodType since the procedure CalcQtyAvailableToPromise expects an Enum parameter and the values are compatible.
        // PeriodType: Option Day,Week,Month,Quarter,Year;
        PeriodType: Enum "Analysis Period Type";
    // BC Upgrade PATELP08 <<
    begin
        //HEI.03>>
        IF Item.GET(RequestLine."Item No.") THEN BEGIN
            RequestHeader.GET(RequestLine."Document No.");
            Item.RESET();
            Item.SETRANGE("Date Filter", 0D, RequestHeader."Request Date");
            Item.SETRANGE("Location Filter", RequestLine."From-Code");
            Item.SETRANGE("Drop Shipment Filter", FALSE);
            EXIT(ConvertQty(
              AvailableToPromise.CalcQtyAvailableToPromise(           //-BC Upgrade KAMNAY01 in NAV the name of the function is QtyAvailabletoPromise but in BC the name change to  CalcQtyAvailableToPromise
                Item,
                GrossRequirement,
                ScheduledReceipt,
                RequestHeader."Request Date",
                PeriodType,
                LookaheadDateformula),
                RequestLine."Qty. per Unit of Measure"));
        end;
        //HEI.03<<
    end;

    procedure CalcAvailabilityForRequestOrder(VAR RequestLine: Record "Request Order Line FND"): Decimal
    var
        Item: Record Item;
        RequestHeader: Record "Request Order Header FND";
        AvailableToPromise: Codeunit "Available to Promise";
        LookaheadDateformula: DateFormula;
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        // BC Upgrade PATELP08 >> Changed variable data type from Option to Enum since the procedure CalcQtyAvailableToPromise expects an Enum parameter and the values are compatible.
        // PeriodType: Option Day,Week,Month,Quarter,Year;
        PeriodType: Enum "Analysis Period Type";
    // BC Upgrade PATELP08 <<
    begin
        //HEI.01>>
        IF Item.GET(RequestLine."Item No.") THEN BEGIN
            RequestHeader.GET(RequestLine."Document No.");
            Item.RESET();
            Item.SETRANGE("Date Filter", 0D, RequestHeader."Request Date");
            //Item.SETRANGE("Location Filter",RequestHeader."To-Code"); //HEI.02
            Item.SETRANGE("Drop Shipment Filter", FALSE);
            EXIT(ConvertQty(
              AvailableToPromise.CalcQtyAvailableToPromise(
                Item,
                GrossRequirement,
                ScheduledReceipt,
                RequestHeader."Request Date",
                PeriodType,
                LookaheadDateformula),
                RequestLine."Qty. per Unit of Measure"));
        end;
        //HEI.01<<
    end;
    //HEI.01<<
    local procedure ConvertQty(Qty: Decimal; PerUoMQty: Decimal): Decimal
    var
        myInt: Integer;
    begin
        IF PerUoMQty = 0 THEN
            PerUoMQty := 1;
        EXIT(ROUND(Qty / PerUoMQty, 0.00001));
    end;

    procedure ShowItemAvailFromRequestOrderLine(VAR RequestHeader: Record "Request Order Header FND"; RequestLine: Record "Request Order Line FND"; AvailabilityType2: Option Date,Location,"Event")
    var
        Item: Record Item;
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        NewLocationCode: Code[10];
        NewVariantCode: Code[10];
        NewDate: Date;
    begin
        //HEI.01>>
        IF Item.GET(RequestLine."Item No.") THEN BEGIN
            Item.RESET();
            Item.SETRANGE("Date Filter", 0D, RequestHeader."Request Date");
            CASE AvailabilityType2 OF
                AvailabilityType2::date:
                    // BC Upgrade PATELP08 >> Replacing Method 'ShowItemAvailByDate' as it is marked for removal. Reason: Replaced by procedure ShowItemAvailabilityByPeriod()
                    // IF ItemAvailFormsMgt.ShowItemAvailByDate(Item, RequestHeader.FIELDCAPTION("Request Date"), RequestHeader."Request Date", NewDate) THEN
                    IF ItemAvailFormsMgt.ShowItemAvailabilityByPeriod(Item, RequestHeader.FIELDCAPTION("Request Date"), RequestHeader."Request Date", NewDate) THEN
                        // BC Upgrade PATELP08 <<
                        RequestHeader.VALIDATE("Request Date", NewDate);
                AvailabilityType2::location:
                    // BC Upgrade PATELP08 >> Replacing Method 'ShowItemAvailByLoc' as it is marked for removal. Reason: Replaced by procedure ShowItemAvailabilityByLocation()
                    // IF ItemAvailFormsMgt.ShowItemAvailByLoc(Item, RequestHeader.FIELDCAPTION("To-Code"), RequestHeader."To-Code", NewLocationCode) THEN
                    IF ItemAvailFormsMgt.ShowItemAvailabilityByLocation(Item, RequestHeader.FIELDCAPTION("To-Code"), RequestHeader."To-Code", NewLocationCode) THEN
                        // BC Upgrade PATELP08 <<
                        RequestHeader.VALIDATE("To-Code", NewLocationCode);
                AvailabilityType2::"Event":
                    // BC Upgrade PATELP08 >> Replacing Method 'ShowItemAvailByEvent' as it is marked for removal. Reason: Replaced by procedure ShowItemAvailabilityByEvent()
                    // IF ItemAvailFormsMgt.ShowItemAvailByEvent(Item, RequestHeader.FIELDCAPTION("Request Date"), RequestHeader."Request Date", NewDate, FALSE) THEN
                    IF ItemAvailFormsMgt.ShowItemAvailabilityByEvent(Item, RequestHeader.FIELDCAPTION("Request Date"), RequestHeader."Request Date", NewDate, FALSE) THEN
                        // BC Upgrade PATELP08 <<  
                        RequestHeader.VALIDATE("Request Date", NewDate);
            end;
        end;
    end;

    procedure ShowItemAvailByFromCodeFromRequestOrderLine(VAR RequestHeader: Record "Request Order Header FND"; RequestLine: Record "Request Order Line FND"; AvailabilityType2: Option Date,Location,"Event")
    var
        Item: Record Item;
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        NewLocationCode: Code[10];
        NewVariantCode: Code[10];
        NewDate: Date;
    begin
        //HEI.02>>
        IF Item.GET(RequestLine."Item No.") THEN BEGIN
            Item.RESET();
            Item.SETRANGE("Date Filter", 0D, RequestHeader."Request Date");
            Item.SETRANGE("Location Filter", RequestLine."From-Code");
            CASE AvailabilityType2 OF
                AvailabilityType2::date:
                    // BC Upgrade PATELP08 >> Replacing Method 'ShowItemAvailByDate' as it is marked for removal. Reason: Replaced by procedure ShowItemAvailabilityByPeriod()
                    // IF ItemAvailFormsMgt.ShowItemAvailByDate(Item, RequestHeader.FIELDCAPTION("Request Date"), RequestHeader."Request Date", NewDate) THEN
                    IF ItemAvailFormsMgt.ShowItemAvailabilityByPeriod(Item, RequestHeader.FIELDCAPTION("Request Date"), RequestHeader."Request Date", NewDate) THEN
                        // BC Upgrade PATELP08 <<
                        RequestHeader.VALIDATE("Request Date", NewDate);
                AvailabilityType2::location:
                    // BC Upgrade PATELP08 >> Replacing Method 'ShowItemAvailByLoc' as it is marked for removal. Reason: Replaced by procedure ShowItemAvailabilityByLocation()
                    // IF ItemAvailFormsMgt.ShowItemAvailByLoc(Item, RequestHeader.FIELDCAPTION("To-Code"), RequestHeader."To-Code", NewLocationCode) THEN
                    IF ItemAvailFormsMgt.ShowItemAvailabilityByLocation(Item, RequestHeader.FIELDCAPTION("To-Code"), RequestHeader."To-Code", NewLocationCode) THEN
                        // BC Upgrade PATELP08 <<
                        RequestHeader.VALIDATE("To-Code", NewLocationCode);
                AvailabilityType2::"Event":
                    // BC Upgrade PATELP08 >> Replacing Method 'ShowItemAvailByEvent' as it is marked for removal. Reason: Replaced by procedure ShowItemAvailabilityByEvent()
                    // IF ItemAvailFormsMgt.ShowItemAvailByEvent(Item, RequestHeader.FIELDCAPTION("Request Date"), RequestHeader."Request Date", NewDate, FALSE) THEN
                    IF ItemAvailFormsMgt.ShowItemAvailabilityByEvent(Item, RequestHeader.FIELDCAPTION("Request Date"), RequestHeader."Request Date", NewDate, FALSE) THEN
                        // BC Upgrade PATELP08 <<
                        RequestHeader.VALIDATE("Request Date", NewDate);
            end;
        end;
        //HEI.02<<
    end;
    //---BC Upgrade KAMNAY01<<---Request Order Line HEI.03    


    // BC Upgrade by Manisha for CU 57>> 
    /* BC Upgrade Code commented by Manisha -- due to missing event in base.
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnAfterSalesLineSetFilters', '', true, true)]
        local procedure OnAfterSalesLineSetFilters(var TotalSalesLine: Record "Sales Line"; SalesLine: Record "Sales Line")
        begin
            //HEI.01>>
            GeneralLedgerSetup.GET;
            IF GeneralLedgerSetup."Enable CAD" THEN BEGIN
                TotalSalesLine.CALCSUMS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "CAD Amount");
                VATAmount := TotalSalesLine."Amount Including VAT" - TotalSalesLine.Amount - TotalSalesLine."CAD Amount";
            end else BEGIN
                //HEI.01<<
                TotalSalesLine.CALCSUMS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount");
                VATAmount := TotalSalesLine."Amount Including VAT" - TotalSalesLine.Amount;
            end; //HEI.01
        end;
        */
    // BC Upgrade Code commented by Manisha -- due to missing event in base.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnBeforeCalculatePostedSalesInvoiceTotals', '', true, true)]
    local procedure OnBeforeCalculatePostedSalesInvoiceTotals(var SalesInvoiceHeader: Record "Sales Invoice Header"; var VATAmount: Decimal; SalesInvoiceLine: Record "Sales Invoice Line"; var IsHandled: Boolean)
    begin
        IF SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.") THEN BEGIN
            /*
                //HEI.01>>
                GeneralLedgerSetup.GET;
                IF GeneralLedgerSetup."Enable CAD" THEN BEGIN
                    SalesInvoiceHeader.CALCFIELDS(Amount, "Amount Including VAT", "Invoice Discount Amount", "CAD Amount");
                    VATAmount := SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount - SalesInvoiceHeader."CAD Amount";
                end else BEGIN
                    //HEI.01<<
                    SalesInvoiceHeader.CALCFIELDS(Amount, "Amount Including VAT", "Invoice Discount Amount");
                    VATAmount := SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount;
                end; //HEI.01
                IsHandled := true;
                */ //Commented by Manisha due to Sales Invoice header dependency
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnBeforeCalculatePostedSalesCreditMemoTotals', '', true, true)]
    local procedure OnBeforeCalculatePostedSalesCreditMemoTotals(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var VATAmount: Decimal; SalesCrMemoLine: Record "Sales Cr.Memo Line"; var IsHandled: Boolean)
    begin
        IF SalesCrMemoHeader.GET(SalesCrMemoLine."Document No.") THEN BEGIN
            /*
             //HEI.01>>
             GeneralLedgerSetup.GET;
             IF GeneralLedgerSetup."Enable CAD" THEN BEGIN
                 SalesCrMemoHeader.CALCFIELDS(Amount, "Amount Including VAT", "Invoice Discount Amount", "CAD Amount");
                 VATAmount := SalesCrMemoHeader."Amount Including VAT" - SalesCrMemoHeader.Amount - SalesCrMemoHeader."CAD Amount";
             end else BEGIN
                 //HEI.01<<
                 SalesCrMemoHeader.CALCFIELDS(Amount, "Amount Including VAT", "Invoice Discount Amount");
                 VATAmount := SalesCrMemoHeader."Amount Including VAT" - SalesCrMemoHeader.Amount;
             end; //HEI.01
             IsHandled := true;
             */ //Commented by Manisha due to Sales Cr Memo header dependency
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnCalculatePurchasePageTotalsOnAfterCalculateVATAmount', '', true, true)]
    local procedure OnCalculatePurchasePageTotalsOnAfterCalculateVATAmount(var TotalPurchaseLine: Record "Purchase Line"; var VATAmount: Decimal; var PurchaseLine: Record "Purchase Line"; var TotalPurchaseLine2: Record "Purchase Line")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        VPS: Record "VAT Posting Setup";
        rcVat: Decimal;
    begin
        //HEI.02>>
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."Enable CAD FND" THEN
            TotalPurchaseLine.CALCSUMS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "CAD Amount FND");
        //Bc Upgrade YADAVM09 Code added in Levy custom codeunit>>
        // else
        //     //HEI.02<<
        //     TotalPurchaseLine.CALCSUMS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "H&S Levy Tax Amount FND");//HEI.03
        //Bc Upgrade YADAVM09 Code added in Levy custom codeunit<<
        //soicad>>

        TotalPurchaseLine2.SETRANGE("Document Type", PurchaseLine."Document Type");
        TotalPurchaseLine2.SETRANGE("Document No.", PurchaseLine."Document No.");
        TotalPurchaseLine2.SETRANGE("VAT Calculation Type", TotalPurchaseLine2."VAT Calculation Type"::"Reverse Charge VAT");
        IF TotalPurchaseLine2.findset() THEN
            REPEAT
                IF VPS.GET(TotalPurchaseLine2."VAT Bus. Posting Group", TotalPurchaseLine2."VAT Prod. Posting Group") THEN
                    IF VPS."Reverse Charge VAT % FND" <> 0 THEN
                        rcVat += ROUND(TotalPurchaseLine2.Amount * VPS."VAT %" / 100)
                           - ROUND(ROUND(TotalPurchaseLine2.Amount * VPS."VAT %" / 100)) * VPS."Reverse Charge VAT % FND" / 100;
            UNTIL TotalPurchaseLine2.NEXT() = 0;
        //soicad<<
        VATAmount := TotalPurchaseLine."Amount Including VAT" - TotalPurchaseLine.Amount + rcVat;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnBeforeCalculatePostedPurchInvoiceTotals', '', true, true)]
    local procedure OnBeforeCalculatePostedPurchInvoiceTotals(var PurchInvHeader: Record "Purch. Inv. Header"; var VATAmount: Decimal; PurchInvLine: Record "Purch. Inv. Line"; var IsHandled: Boolean)
    var
        PurchInvLine2: Record "Purch. Inv. Line";
        VPS: Record "VAT Posting Setup";
        rcVat: Decimal;
    begin
        if PurchInvHeader.Get(PurchInvLine."Document No.") then begin
            //HEI.02>>
            //PurchInvHeader.CALCFIELDS(Amount,"Amount Including VAT","Invoice Discount Amount");
            PurchInvHeader.CALCFIELDS(Amount, "Amount Including VAT", "Invoice Discount Amount", "CAD Amount FND");
            //HEI.02<<

            //soicad>>
            PurchInvLine2.SETRANGE("Document No.", PurchInvHeader."No.");
            PurchInvLine2.SETRANGE("VAT Calculation Type", PurchInvLine2."VAT Calculation Type"::"Reverse Charge VAT");
            IF PurchInvLine2.findset() THEN
                REPEAT
                    IF VPS.GET(PurchInvLine2."VAT Bus. Posting Group", PurchInvLine2."VAT Prod. Posting Group") THEN
                        IF VPS."Reverse Charge VAT % FND" <> 0 THEN
                            rcVat := PurchInvLine2.Amount * (VPS."Reverse Charge VAT % FND" / 100) * (VPS."VAT %" / 100);
                UNTIL PurchInvLine2.NEXT() = 0;
            //soicad<<
            VATAmount := PurchInvHeader."Amount Including VAT" - PurchInvHeader.Amount + rcVat;
            PurchInvHeader."Amount Including VAT" += rcVat; //soicad
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnBeforeCalculatePostedPurchCreditMemoTotals', '', true, true)]
    local procedure OnBeforeCalculatePostedPurchCreditMemoTotals(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var VATAmount: Decimal; PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var IsHandled: Boolean)
    begin
        if PurchCrMemoHdr.Get(PurchCrMemoLine."Document No.") then begin
            //HEI.02>>
            //PurchCrMemoHdr.CalcFields(Amount, "Amount Including VAT", "Invoice Discount Amount");
            PurchCrMemoHdr.CALCFIELDS(Amount, "Amount Including VAT", "Invoice Discount Amount", "CAD Amount FND");
            //HEI.02<<
            VATAmount := PurchCrMemoHdr."Amount Including VAT" - PurchCrMemoHdr.Amount;
            IsHandled := true;
        end;
    end;
    //BC UPGRADE ATHUKS01 STP_FDD007<< 
    PROCEDURE GetTotalCADCaption(CurrencyCode: Code[10]): Text;
    var
        TotalCADLbl: Label 'Total CAD';
    BEGIN
        //HEI.01>>
        EXIT(GetCaptionClassWithCurrencyCode(TotalCADLbl, CurrencyCode));
        //HEI.01<<
    end;

    PROCEDURE GetTotalInclCADCaption(CurrencyCode: Code[10]): Text;
    var
        TotalInclCADLbl: Label 'Total Incl.CAD';
    BEGIN
        //HEI.01>>
        EXIT(GetCaptionClassWithCurrencyCode(TotalInclCADLbl, CurrencyCode));
        //HEI.01<<
    end;
    //BC UPGRADE ATHUKS01 STP_FDD007>>

    LOCAL PROCEDURE GetCaptionClassWithCurrencyCode(CaptionWithoutCurrencyCode: Text; CurrencyCode: Code[10]): Text;
    BEGIN
        EXIT('3,' + GetCaptionWithCurrencyCode(CaptionWithoutCurrencyCode, CurrencyCode));
    end;

    LOCAL PROCEDURE GetCaptionWithCurrencyCode(CaptionWithoutCurrencyCode: Text; CurrencyCode: Code[10]): Text;
    VAR
        GLSetup: Record "General Ledger Setup";
    BEGIN
        IF CurrencyCode = '' THEN BEGIN
            GLSetup.GET();
            CurrencyCode := GLSetup.GetCurrencyCode(CurrencyCode);
        end;

        IF CurrencyCode <> '' THEN
            EXIT(CaptionWithoutCurrencyCode + STRSUBSTNO(' (%1)', CurrencyCode));

        EXIT(CaptionWithoutCurrencyCode);
    end;
    // BC Upgrade by Manisha for CU 57<<





    procedure UpdateAddrArrayForPostCodeCity(var AddrArray: array[8] of Text[100]; Contact: Text[100]; ContLineNo: Integer; Country: Record "Country/Region"; CountryLineNo: Integer; PostCodeCityLineNo: Integer; CountyLineNo: Integer; City: Text[50]; PostCode: Code[20]; County: Text[50])
    var
        CUFormataddress: Codeunit "Format Address";
    begin
        AddrArray[ContLineNo] := Contact;
        CUFormatAddress.GeneratePostCodeCity(AddrArray[PostCodeCityLineNo], AddrArray[CountyLineNo], City, PostCode, County, Country);
        AddrArray[CountryLineNo] := Country.Name;
        CompressArray(AddrArray);
    end;

    // BC Upgrade by Manisha for CU 365>>
    procedure CashCollection(VAR AddrArray: ARRAY[8] OF Text[60]; VAR CashCollectionHeader: Record "Cash Collection Header FND")
    begin
        //HEI.01>>
        //WITH CashCollectionHeader DO// Bc Upgrade YADAVM09 With ststement will be removed in future<<
        FormatAddress.FormatAddr(
          AddrArray,
          CashCollectionHeader.Name,
          CashCollectionHeader."Name 2",
          CashCollectionHeader.Contact,
          CashCollectionHeader.Address,
          CashCollectionHeader."Address 2",
          CashCollectionHeader.City,
          CashCollectionHeader."Post Code",
          CashCollectionHeader.County,
          CashCollectionHeader."Country/Region Code");
        //HEI.01<<
    end;

    procedure IssuedCashCollection(VAR AddrArray: ARRAY[8] OF Text[50]; VAR IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND")
    begin
        FormatAddress.FormatAddr(
        AddrArray,
        IssuedCashCollectionHeader.Name,
        IssuedCashCollectionHeader."Name 2",
        IssuedCashCollectionHeader.Contact,
        IssuedCashCollectionHeader.Address,
        IssuedCashCollectionHeader."Address 2",
        IssuedCashCollectionHeader.City,
        IssuedCashCollectionHeader."Post Code",
        IssuedCashCollectionHeader.County,
        IssuedCashCollectionHeader."Country/Region Code");
    end;

    procedure SalesShptSellToExt(VAR AddrArray: ARRAY[8] OF Text[60]; VAR SalesShptHeader: Record "Sales Shipment Header"): Boolean

    begin

        //HEI.04>>
        GLSetup.GET;
        IF NOT GLSetup."Extended Address Formating FND" THEN
            EXIT(FALSE);
        //WITH SalesShptHeader DO BEGIN
        //Cust.GET(SalesShptHeader."Bill-to Customer No.");
        // EXIT(FormatAddrExt(
        //   AddrArray, "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
        //   "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code", "Sundry Customer", Cust));
        //END;//Bc Upgrade YADAVM09 Dependency on drink it field "Sundry Customer"<<
        //HEI.04>>
    end;

    procedure SalesShptBillToExt(VAR AddrArray: ARRAY[8] OF Text[60]; ShipToAddr: ARRAY[8] OF Text[60]; VAR SalesShptHeader: Record "Sales Shipment Header") ShowCustAddr: Boolean
    begin
        //HEI.04>>
        GLSetup.GET;
        IF NOT GLSetup."Extended Address Formating FND" THEN
            EXIT(FALSE);
        //WITH SalesShptHeader DO BEGIN
        //Cust.GET(SalesShptHeader."Bill-to Customer No.");
        // EXIT(FormatAddrExt(
        //   AddrArray, "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
        //   "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code", "Sundry Customer", Cust));
        //END;//Bc Upgrade YADAVM09 Dependency on drink it field "Sundry Customer"<<
        //HEI.04>>
    end;

    procedure SalesShptShipToExt(VAR AddrArray: ARRAY[8] OF Text[60]; VAR SalesShptHeader: Record "Sales Shipment Header"): Boolean
    begin
        //HEI.04>>
        GLSetup.GET;
        IF NOT GLSetup."Extended Address Formating FND" THEN
            EXIT(FALSE);
        //WITH SalesShptHeader DO BEGIN
        // Cust.GET(SalesShptHeader."Bill-to Customer No.");
        // EXIT(FormatAddrExt(
        //   AddrArray, "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
        //   "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code", "Sundry Customer", Cust));
        //END;//Bc Upgrade YADAVM09 Dependency on drink it field "Sundry Customer"<<
        //HEI.04>>
    end;

    procedure SalesInvSellToExt(VAR AddrArray: ARRAY[8] OF Text[60]; VAR SalesInvHeader: Record "Sales Invoice Header"): Boolean
    begin
        //HEI.04>>
        GLSetup.GET;
        IF NOT GLSetup."Extended Address Formating FND" THEN
            EXIT(FALSE);
        // WITH SalesInvHeader DO BEGIN
        //     Cust.GET(SalesInvHeader."Bill-to Customer No.");
        //     EXIT(FormatAddrExt(
        //       AddrArray, "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
        //       "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code", "Sundry Customer", Cust));
        // END;//Bc Upgrade YADAVM09 Dependency on drink it field "Sundry Customer"<<
        //HEI.04>>
    end;

    procedure SalesInvShipToExt(VAR AddrArray: ARRAY[8] OF Text[60]; CustAddr: ARRAY[8] OF Text[60]; VAR SalesInvHeader: Record "Sales Invoice Header") ShowShippingAddr: Boolean
    begin
        //HEI.04>>
        GLSetup.GET;
        IF NOT GLSetup."Extended Address Formating FND" THEN
            EXIT(FALSE);
        // WITH SalesInvHeader DO BEGIN
        //     Cust.GET(SalesInvHeader."Bill-to Customer No.");
        //     EXIT(FormatAddrExt(
        //       AddrArray, "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
        //       "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code", "Sundry Customer", Cust));
        // END;//Bc Upgrade YADAVM09 Dependency on drink it field "Sundry Customer"<<
        //HEI.04>>
    end;

    procedure SalesCrMemoSellToExt(VAR AddrArray: ARRAY[8] OF Text[60]; VAR SalesCrMemoHeader: Record "Sales Cr.Memo Header"): Boolean
    begin
        //HEI.04>>
        GLSetup.GET;
        IF NOT GLSetup."Extended Address Formating FND" THEN
            EXIT(FALSE);
        // WITH SalesCrMemoHeader DO BEGIN
        //     Cust.GET(SalesCrMemoHeader."Bill-to Customer No.");
        //     EXIT(FormatAddrExt(
        //       AddrArray, "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
        //       "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code", "Sundry Customer", Cust));
        // END;//Bc Upgrade YADAVM09 Dependency on drink it field "Sundry Customer"<<
        //HEI.04>>
    end;

    Procedure SalesCrMemoBillToExt(VAR AddrArray: ARRAY[8] OF Text[60]; VAR SalesCrMemoHeader: Record "Sales Cr.Memo Header"): Boolean
    begin
        //HEI.04>>
        GLSetup.GET;
        IF NOT GLSetup."Extended Address Formating FND" THEN
            EXIT(FALSE);
        // WITH SalesCrMemoHeader DO BEGIN
        //     Cust.GET(SalesCrMemoHeader."Bill-to Customer No.");
        //     EXIT(FormatAddrExt(
        //       AddrArray, "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
        //       "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code", "Sundry Customer", Cust));
        // END;//Bc Upgrade YADAVM09 Dependency on drink it field "Sundry Customer"<<
        //HEI.04>>
    end;

    procedure SalesCrMemoShipToExt(VAR AddrArray: ARRAY[8] OF Text[60]; CustAddr: ARRAY[8] OF Text[60]; VAR SalesCrMemoHeader: Record "Sales Cr.Memo Header") ShowShippingAddr: Boolean
    begin
        //HEI.04>>
        GLSetup.GET;
        IF NOT GLSetup."Extended Address Formating FND" THEN
            EXIT(FALSE);
        // WITH SalesCrMemoHeader DO BEGIN
        //     Cust.GET(SalesCrMemoHeader."Bill-to Customer No.");
        //     EXIT(FormatAddrExt(
        //       AddrArray, "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
        //       "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code", "Sundry Customer", Cust));
        // END;//Bc Upgrade YADAVM09 Dependency on drink it field "Sundry Customer"<<
        //HEI.04>>
    end;

    Procedure SalesRcptSellToExt(VAR AddrArray: ARRAY[8] OF Text[60]; VAR ReturnRcptHeader: Record "Return Receipt Header"): Boolean
    begin
        //HEI.04>>
        GLSetup.GET;
        IF NOT GLSetup."Extended Address Formating FND" THEN
            EXIT(FALSE);
        // WITH ReturnRcptHeader DO BEGIN
        //     Cust.GET(ReturnRcptHeader."Bill-to Customer No.");
        //     EXIT(FormatAddrExt(
        //       AddrArray, "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
        //       "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code", "Sundry Customer", Cust));
        // END;
        //HEI.04>>
    end;

    procedure SalesRcptBillToExt(VAR AddrArray: ARRAY[8] OF Text[60]; ShipToAddr: ARRAY[8] OF Text[60]; VAR ReturnRcptHeader: Record "Return Receipt Header") ShowCustAddr: Boolean
    begin
        //HEI.04>>
        GLSetup.GET;
        IF NOT GLSetup."Extended Address Formating FND" THEN
            EXIT(FALSE);
        // WITH ReturnRcptHeader DO BEGIN
        //     Cust.GET(ReturnRcptHeader."Bill-to Customer No.");
        //     EXIT(FormatAddrExt(
        //       AddrArray, "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
        //       "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code", "Sundry Customer", Cust));
        // END;
        //HEI.04>>
    end;

    procedure SalesRcptShipToExt(VAR AddrArray: ARRAY[8] OF Text[60]; VAR ReturnRcptHeader: Record "Return Receipt Header"): Boolean
    begin
        //HEI.04>>
        GLSetup.GET;
        IF NOT GLSetup."Extended Address Formating FND" THEN
            EXIT(FALSE);
        // WITH ReturnRcptHeader DO BEGIN
        //     Cust.GET(ReturnRcptHeader."Bill-to Customer No.");
        //     EXIT(FormatAddrExt(
        //       AddrArray, "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
        //       "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code", "Sundry Customer", Cust));
        // END;
        //HEI.04>>
    end;

    procedure SalesHeaderSellToExt(VAR AddrArray: ARRAY[8] OF Text[60]; VAR SalesHeader: Record "Sales Header"): Boolean
    begin
        //HEI.04>>
        GLSetup.GET;
        IF NOT GLSetup."Extended Address Formating FND" THEN
            EXIT(FALSE);
        // WITH SalesHeader DO BEGIN
        //     Cust.GET(SalesHeader."Sell-to Customer No.");
        //     EXIT(FormatAddrExt(
        //       AddrArray, "Sell-to Customer Name", "Sell-to Customer Name 2", "Sell-to Contact", "Sell-to Address", "Sell-to Address 2",
        //       "Sell-to City", "Sell-to Post Code", "Sell-to County", "Sell-to Country/Region Code", "Sundry Customer", Cust));
        // END;
        //HEI.04>>
    end;

    procedure SalesHeaderBillToExt(VAR AddrArray: ARRAY[8] OF Text[60]; VAR SalesHeader: Record "Sales Header"): Boolean
    begin
        //HEI.04>>
        GLSetup.GET;
        IF NOT GLSetup."Extended Address Formating FND" THEN
            EXIT(FALSE);
        // WITH SalesHeader DO BEGIN
        //     Cust.GET(SalesHeader."Bill-to Customer No.");
        //     EXIT(FormatAddrExt(
        //       AddrArray, "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
        //       "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code", "Sundry Customer", Cust));
        // END;
        //HEI.04>>
    end;

    procedure SalesHeaderShipToExt(VAR AddrArray: ARRAY[8] OF Text[60]; CustAddr: ARRAY[8] OF Text[60]; VAR SalesHeader: Record "Sales Header") ShowShippingAddr: Boolean
    begin
        //HEI.04>>
        GLSetup.GET;
        IF NOT GLSetup."Extended Address Formating FND" THEN
            EXIT(FALSE);
        // WITH SalesHeader DO BEGIN
        //     Cust.GET(SalesHeader."Bill-to Customer No.");
        //     EXIT(FormatAddrExt(
        //       AddrArray, "Ship-to Name", "Ship-to Name 2", "Ship-to Contact", "Ship-to Address", "Ship-to Address 2",
        //       "Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code", "Sundry Customer", Cust));
        // END;
        //HEI.04>>
    end;

    procedure FormatAddrExt(VAR AddrArray: ARRAY[8] OF Text[90]; Name: Text[90]; Name2: Text[90]; Contact: Text[90]; Addr: Text[50]; Addr2: Text[50]; City: Text[50]; PostCode: Code[20]; County: Text[50]; CountryCode: Code[10]; SundryDoc: Boolean; Cust: Record Customer): Boolean
    var
        CompanyInfo: Record "Company Information";
        Country: Record "Country/Region";
        TempCust: Record Customer;
        CustomerAttributes: Record "Customer Attributes FND";
        CountryFormatExists: Boolean;
        CountryFormat: Record "Country Format FND";
    begin
        GLSetup.GET;
        IF CountryCode = '' THEN BEGIN
            GLSetup.GET;
            CLEAR(Country);
            CompanyInfo.GET;
            Country.Code := CompanyInfo."Country/Region Code";
            Country."Address Format" := GLSetup."Local Address Format";
            Country."Contact Address Format" := GLSetup."Local Cont. Addr. Format";
        END ELSE
            Country.GET(CountryCode);
        IF SundryDoc THEN BEGIN
            TempCust.Name := Name;
            TempCust."Name 2" := Name2;
            TempCust.Contact := Contact;
            TempCust.Address := Addr;
            TempCust.City := City;
            TempCust."Post Code" := PostCode;
            TempCust.County := County;
            TempCust."Country/Region Code" := CountryCode;
        END ELSE
            TempCust.TRANSFERFIELDS(Cust);
        CountryFormat.SETRANGE("Country/Region", Country.Code);
        CountryFormatExists := CountryFormat.FINDFIRST;
        IF (NOT CountryFormatExists) THEN BEGIN
            // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
            // WITH TempCust DO
            //     FormatAddress.FormatAddr(
            //       AddrArray, Name, "Name 2", Contact, Address, "Address 2",
            //       City, "Post Code", County, "Country/Region Code");
            // EXIT(FALSE);
            FormatAddress.FormatAddr(
                AddrArray, Name, TempCust."Name 2", Contact, TempCust.Address, TempCust."Address 2",
                City, TempCust."Post Code", County, TempCust."Country/Region Code");
            EXIT(FALSE);
            // BC Upgrade PATELP08 <<
        END;

        //NAIKH01>>
        IF CustomerAttributes.GET(TempCust."No.") THEN;
        //<<
        //EXIT(FALSE);
        CLEAR(AddrArray);
        IF CountryFormatExists THEN
            REPEAT
                AddrArray[CountryFormat."Row No."] := MakeAddrRow(CountryFormat, TempCust, CustomerAttributes);
            UNTIL CountryFormat.NEXT = 0;
        COMPRESSARRAY(AddrArray);
        EXIT(TRUE);

    end;

    local procedure MakeAddrRow(VAR CountryFormat: Record "Country Format FND"; VAR Cust: Record Customer; VAR CustomerAttributes: Record "Customer Attributes FND"): Text[60]
    var
        RetVal: Text;
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // WITH CountryFormat DO BEGIN
        //     RetVal := GetFieldValue(CountryFormat."Address 1 Element", Cust, CustomerAttributes) +
        //               GetFieldValue(CountryFormat."Address 2 Element", Cust, CustomerAttributes) +
        //               GetFieldValue(CountryFormat."Address 3 Element", Cust, CustomerAttributes) +
        //               GetFieldValue(CountryFormat."Address 4 Element", Cust, CustomerAttributes) +
        //               GetFieldValue(CountryFormat."Address 5 Element", Cust, CustomerAttributes) +
        //               GetFieldValue(CountryFormat."Address 6 Element", Cust, CustomerAttributes) +
        //               GetFieldValue(CountryFormat."Address 7 Element", Cust, CustomerAttributes) +
        //               GetFieldValue(CountryFormat."Address 8 Element", Cust, CustomerAttributes) +
        //               GetFieldValue(CountryFormat."Address 9 Element", Cust, CustomerAttributes);
        // END;
        RetVal := GetFieldValue(CountryFormat."Address 1 Element", Cust, CustomerAttributes) +
                    GetFieldValue(CountryFormat."Address 2 Element", Cust, CustomerAttributes) +
                    GetFieldValue(CountryFormat."Address 3 Element", Cust, CustomerAttributes) +
                    GetFieldValue(CountryFormat."Address 4 Element", Cust, CustomerAttributes) +
                    GetFieldValue(CountryFormat."Address 5 Element", Cust, CustomerAttributes) +
                    GetFieldValue(CountryFormat."Address 6 Element", Cust, CustomerAttributes) +
                    GetFieldValue(CountryFormat."Address 7 Element", Cust, CustomerAttributes) +
                    GetFieldValue(CountryFormat."Address 8 Element", Cust, CustomerAttributes) +
                    GetFieldValue(CountryFormat."Address 9 Element", Cust, CustomerAttributes);
        // BC Upgrade PATELP08 <<
        IF RetVal <> '' THEN BEGIN
            RetVal := COPYSTR(RetVal, 1, STRLEN(RetVal) - 2);
            IF STRLEN(RetVal) > 60 THEN
                RetVal := COPYSTR(RetVal, 1, 60);
        END;
        EXIT(RetVal);
    end;

    LOCAL Procedure GetFieldValue(OptionValue: Option " ",Name,Name2,"Post Code",City,Region,Country,Address,Address2,Name3,Name4,Street3,Street4,Street5,"House No.","House No. extension"; VAR Cust: Record Customer; VAR CustomerAttributes: Record "Customer Attributes FND"): Text
    var
        RetVal: Text;
    Begin
        //NAIKH01 Replaced the OptionValue
        // ,Name,Name2,Post Code,City,Region,Country,Address,Address2,Name3,Name4,Street3,Street4,Street5,House No.,House No. extension//Bc Upgrade YADAVM09<<
        CASE OptionValue OF

            OptionValue::Name:
                RetVal := Cust.Name;
            OptionValue::Name2:
                RetVal := Cust."Name 2";
            OptionValue::"Post Code":
                RetVal := Cust."Post Code";
            OptionValue::City:
                RetVal := Cust.City;
            OptionValue::Region:
                RetVal := Cust."Territory Code";
            OptionValue::Country:
                RetVal := Cust."Country/Region Code";
            OptionValue::Address:
                RetVal := Cust.Address;
            OptionValue::Address2:
                RetVal := Cust."Address 2";
            OptionValue::Name3:
                RetVal := CustomerAttributes."Name 3";
            OptionValue::Name4:
                RetVal := CustomerAttributes."Name 4";
            OptionValue::Street3:
                RetVal := CustomerAttributes."Street 3";
            OptionValue::Street4:
                RetVal := CustomerAttributes."Street 4";
            OptionValue::Street5:
                RetVal := CustomerAttributes."Street 5";
            OptionValue::"House No.":
                RetVal := CustomerAttributes."House No. 1";
            OptionValue::"House No. extension":
                RetVal := CustomerAttributes."House Supplement 2"
        END;
        IF RetVal <> '' THEN
            RetVal := RetVal + ', ';
        EXIT(RetVal);
    end;

    // BC Upgrade by Manisha for CU 365 - Format Address<< 


    var
        FormatAddress: Codeunit "Format Address";
        Cust: Record Customer;
        GLSetup: Record "General Ledger Setup";
        CountryFormat: Record "Country Format FND";

    // BC Upgrade by Manisha for CU 365<< 

    PROCEDURE GetSelectionFilterForIssueCashCollection(VAR CashCollectionHeader: Record 50023): Text;
    VAR
        CUselction: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    BEGIN
        //HEI.01>>
        RecRef.GETTABLE(CashCollectionHeader);
        EXIT(CUselction.GetSelectionFilter(RecRef, CashCollectionHeader.FIELDNO("No.")));
        //HEI.01<<
    end;


    //BC-Subscribed events to handle code on page-Navigate(Hei.03, Hei.04 & Soicad) 29-09-25 --PATHAA02>>
    [EventSubscriber(ObjectType::Page, Page::Navigate, OnBeforeFindCustLedgerEntry, '', false, false)]
    local procedure Navigate_OnBeforeFindCustLedgerEntry(var Sender: Page Navigate; var CustLedgerEntry: Record "Cust. Ledger Entry"; DocNoFilter: Text; PostingDateFilter: Text; ExtDocNo: Text; var IsHandled: Boolean)
    var
        CADEntry: Record "CAD Entry FND";
        Rec_Navigate: Record "Document Entry";
        LevyTaxEntries: Record "Levy Tax Entries FND";
        WHTEntry: Record "WHT Entry FND";

    begin

        //HEI.03>>
        IF CADEntry.READPERMISSION THEN BEGIN
            CADEntry.RESET();
            CADEntry.SETCURRENTKEY("Document No.", "Posting Date");
            CADEntry.SETFILTER("Document No.", DocNoFilter);
            CADEntry.SETFILTER("Posting Date", PostingDateFilter);
            Rec_Navigate.InsertIntoDocEntry(
            // BC Upgrade PATELP08 >> Replaced integer document type with Document Entry Document Type enum to avoid implicit integer-to-enum conversion.
            //   DATABASE::"CAD Entry FND", 0, CADEntry.TABLECAPTION, CADEntry.COUNT);
              DATABASE::"CAD Entry FND", Enum::"Document Entry Document Type"::Quote, CADEntry.TABLECAPTION, CADEntry.COUNT);
            // BC Upgrade PATELP08 <<
        end;
        //HEI.03<<

        //soicad>>
        IF WHTEntry.READPERMISSION THEN BEGIN
            WHTEntry.RESET();
            WHTEntry.SETCURRENTKEY("Document No.", "Posting Date");
            WHTEntry.SETFILTER("Document No.", DocNoFilter);
            WHTEntry.SETFILTER("Posting Date", PostingDateFilter);
            Rec_Navigate.InsertIntoDocEntry(
            // BC Upgrade PATELP08 >> Replaced integer document type with Document Entry Document Type enum to avoid implicit integer-to-enum conversion.
            //   DATABASE::"WHT Entry", 0, WHTEntry.TABLECAPTION, WHTEntry.COUNT);
              DATABASE::"WHT Entry FND", Enum::"Document Entry Document Type"::Quote, WHTEntry.TABLECAPTION, WHTEntry.COUNT);
            // BC Upgrade PATELP08 <<
        end;
        //soica<<
        //Bc Upgrade YADAVM09 code added in Levy custom>>
        //HEI.04>>
        // IF LevyTaxEntries.READPERMISSION THEN BEGIN
        //     LevyTaxEntries.RESET();
        //     LevyTaxEntries.SETCURRENTKEY("Doc. No.", "Posting Date");
        //     LevyTaxEntries.SETFILTER("Doc. No.", DocNoFilter);
        //     LevyTaxEntries.SETFILTER("Posting Date", PostingDateFilter);
        //     Rec_Navigate.InsertIntoDocEntry(
        //     // BC Upgrade PATELP08 >> Replaced integer document type with Document Entry Document Type enum to avoid implicit integer-to-enum conversion.
        //     //   DATABASE::"Levy Tax Entries FND", 0, LevyTaxEntries.TABLECAPTION, LevyTaxEntries.COUNT);
        //       DATABASE::"Levy Tax Entries FND", Enum::"Document Entry Document Type"::Quote, LevyTaxEntries.TABLECAPTION, LevyTaxEntries.COUNT);
        //     // BC Upgrade PATELP08 <<
        // end;
        // //HEI.04<<
        //Bc Upgrade YADAVM09 code added in Levy custom<<
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, OnAfterShowRecords, '', false, false)]
    local procedure Navigate_OnAfterShowRecords(var Sender: Page Navigate; var DocumentEntry: Record "Document Entry" temporary; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean; ContactType: Enum "Navigate Contact Type"; ContactNo: Code[250]; ExtDocNo: Code[250])
    var
        CADEntry: Record "CAD Entry FND";
        LevyTaxEntries: Record "Levy Tax Entries FND";
        WHTEntry: Record "WHT Entry FND";
        ItemTrackingNavigateMgt: Codeunit "Item Tracking Navigate Mgt.";
    begin

        if Sender.ItemTrackingSearch() then
            ItemTrackingNavigateMgt.Show(DocumentEntry."Table ID")
        else
            case DocumentEntry."Table ID" of
                //soicad>>
                DATABASE::"WHT Entry FND":
                    PAGE.RUN(0, WHTEntry);
                //soicad<<

                //HEI.03>>
                DATABASE::"CAD Entry FND":
                    PAGE.RUN(0, CADEntry);
            //HEI.03<<

            //     //HEI.04>>
            //     DATABASE::"Levy Tax Entries FND":
            //         IF DocumentEntry."No. of Records" = 1 THEN
            //             PAGE.RUN(PAGE::"Levy Tax entries Preview", LevyTaxEntries)
            //         else
            //             PAGE.RUN(PAGE::"Levy Tax entries Preview", LevyTaxEntries);
            // //HEI.04<<//Bc Upgrade YADAVM09 code added in Levy custom<<
            end;
    end;
    //BC-Subscribed events to handle code on page-Navigate(Hei.03, Hei.04 & Soicad) 29-09-25 --PATHAA02<<


    //BC Upgrade Manisha CU 5063>>
    procedure ArchivePurchDocumentOnReopen(VAR PurchHeader: Record "Purchase Header")
    var
        ArchiveManagement: Codeunit ArchiveManagement;
        Text001: Label 'Document %1 has been archived.';
    begin
        //HEI.03>>
        ArchiveManagement.StorePurchDocument(PurchHeader, FALSE);
        MESSAGE(Text001, PurchHeader."No.");
        //HEI.03<<
    end;

    procedure CalcCompDueDate(DemandDate: Date; ParentItem: Record Item; LeadTimeOffset: DateFormula) DueDate: Date
    var
        //BC Upgrade PATELP08 >> Replaced Manufacturing Setup with Inventory Setup variables as field 'Default Safety Lead Time' is moved to Inventory Setup and marked for removal in Manufacturing Setup.
        // MfgSetup: Record "Manufacturing Setup";
        InvSetup: Record "Inventory Setup";
        //BC Upgrade PATELP08 <<
        EndDate: Date;
        StartDate: Date;
    begin
        if DemandDate = 0D then
            exit;

        EndDate := DemandDate;
        if Format(ParentItem."Safety Lead Time") <> '' then
            EndDate := DemandDate - (CalcDate(ParentItem."Safety Lead Time", DemandDate) - DemandDate)
        else
            //BC Upgrade PATELP08 >> Replaced Manufacturing Setup with Inventory Setup as field 'Default Safety Lead Time' is moved to Inventory Setup and marked for removal in Manufacturing Setup.
            // if MfgSetup.Get() and (Format(MfgSetup."Default Safety Lead Time") <> '') then
            //     EndDate := DemandDate - (CalcDate(MfgSetup."Default Safety Lead Time", DemandDate) - DemandDate);
            if InvSetup.Get() and (Format(InvSetup."Default Safety Lead Time") <> '') then
                EndDate := DemandDate - (CalcDate(InvSetup."Default Safety Lead Time", DemandDate) - DemandDate);
        //BC Upgrade PATELP08 <<
        if Format(ParentItem."Lead Time Calculation") = '' then
            StartDate := EndDate
        else
            StartDate := EndDate - (CalcDate(ParentItem."Lead Time Calculation", EndDate) - EndDate);

        if Format(LeadTimeOffset) = '' then
            DueDate := StartDate
        else
            DueDate := StartDate - (CalcDate(LeadTimeOffset, StartDate) - StartDate);
    end;

    procedure GenerateItemSubTree(ItemNo: Code[20]; var BOMBuffer: Record "BOM Buffer"): Boolean
    var
        ParentItem: Record Item;
        TempItem: Record Item temporary;
    begin
        ParentItem.Get(ItemNo);
        //OnGenerateItemSubTreeOnAfterParentItemGet(ParentItem);
        if TempItem.Get(ItemNo) then begin
            BOMBuffer."Is Leaf" := false;
            BOMBuffer.Modify(true);
            exit(false);
        end;
        TempItem := ParentItem;
        TempItem.Insert();

        if ParentItem."Replenishment System" = ParentItem."Replenishment System"::"Prod. Order" then begin
            BOMBuffer."Is Leaf" := not GenerateProdCompSubTree(ParentItem, BOMBuffer);
            if BOMBuffer."Is Leaf" then
                BOMBuffer."Is Leaf" := not GenerateBOMCompSubTree(ParentItem, BOMBuffer);
        end else begin
            BOMBuffer."Is Leaf" := not GenerateBOMCompSubTree(ParentItem, BOMBuffer);
            if BOMBuffer."Is Leaf" then
                BOMBuffer."Is Leaf" := not GenerateProdCompSubTree(ParentItem, BOMBuffer);
        end;
        BOMBuffer.Modify(true);

        TempItem.Get(ItemNo);
        TempItem.Delete();
        exit(not BOMBuffer."Is Leaf");
    end;

    procedure GenerateBOMCompSubTree(ParentItem: Record Item; var BOMBuffer: Record "BOM Buffer"): Boolean
    var
        ParentBOMBuffer: Record "BOM Buffer";
        BOMComp: Record "BOM Component";
        ItemFilter: Record Item;
        UOMMgt: Codeunit "Unit of Measure Management";
        IsHandled: Boolean;
        EntryNo: Integer;
        TreeType: Option " ",Availability,Cost;
    begin
        ParentBOMBuffer := BOMBuffer;
        BOMComp.SetRange("Parent Item No.", ParentItem."No.");
        if BOMComp.FindSet() then begin
            if ParentItem."Replenishment System" <> ParentItem."Replenishment System"::Assembly then
                exit(true);

            IsHandled := false;
            //   OnGenerateBOMCompSubTreeOnBeforeLoopBOMComponents(ParentItem, IsHandled);
            if IsHandled then
                exit(true);
            repeat
                if (BOMComp."No." <> '') and ((BOMComp.Type = BOMComp.Type::Item) or (TreeType in [TreeType::" ", TreeType::Cost])) then begin
                    BOMBuffer.SetLocationVariantFiltersFrom(ItemFilter);
                    BOMBuffer.TransferFromBOMComp(
                      EntryNo, BOMComp, ParentBOMBuffer.Indentation + 1,
                      Round(
                        ParentBOMBuffer."Qty. per Top Item" *
                        UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
                      Round(
                        ParentBOMBuffer."Scrap Qty. per Top Item" *
                        UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
                      CalcCompDueDate(ParentBOMBuffer."Needed by Date", ParentItem, BOMComp."Lead-Time Offset"),
                      ParentBOMBuffer."Location Code");
                    if BOMComp.Type = BOMComp.Type::Item then
                        GenerateItemSubTree(BOMComp."No.", BOMBuffer);
                end;
            until BOMComp.Next() = 0;
            BOMBuffer := ParentBOMBuffer;
            exit(true);
        end;
    end;

    procedure GenerateProdCompSubTree(ParentItem: Record Item; var BOMBuffer: Record "BOM Buffer") FoundSubTree: Boolean
    var
        ParentBOMBuffer: Record "BOM Buffer";
        CopyOfParentItem: Record Item;
        ItemFilter: Record Item;
        ProdBOMLine: Record "Production BOM Line";
        RoutingLine: Record "Routing Line";
        BCUpgradeCU: Codeunit "Heineken BC Upgrade";
        MfgCostCalcMgt: Codeunit "Mfg. Cost Calculation Mgt.";
        UOMMgt: Codeunit "Unit of Measure Management";
        VersionMgt: Codeunit VersionManagement;
        IsHandled: Boolean;
        RunIteration: Boolean;
        BomQtyPerUom: Decimal;
        LotSize: Decimal;
        EntryNo: Integer;
        TreeType: Option " ",Availability,Cost;
    begin
        ParentBOMBuffer := BOMBuffer;
        if not ProdBOMLine.ReadPermission then
            exit;
        ProdBOMLine.SetRange("Production BOM No.", ParentItem."Production BOM No.");
        ProdBOMLine.SetRange("Version Code", VersionMgt.GetBOMVersion(ParentItem."Production BOM No.", WorkDate(), true));
        ProdBOMLine.SetFilter("Starting Date", '%1|..%2', 0D, ParentBOMBuffer."Needed by Date");
        ProdBOMLine.SetFilter("Ending Date", '%1|%2..', 0D, ParentBOMBuffer."Needed by Date");
        IsHandled := false;
        // OnBeforeFilterByQuantityPer(ProdBOMLine, IsHandled, ParentBOMBuffer);
        if not IsHandled then
            if TreeType = TreeType::Availability then
                ProdBOMLine.SetFilter("Quantity per", '>%1', 0);
        if ProdBOMLine.FindSet() then begin
            if ParentItem."Replenishment System" <> ParentItem."Replenishment System"::"Prod. Order" then begin
                FoundSubTree := true;
                //OnGenerateProdCompSubTreeOnBeforeExitForNonProdOrder(ParentItem, BOMBuffer, FoundSubTree);
                //exit(FoundSubTree);
            end;
            repeat
                IsHandled := false;
                //  OnBeforeTransferProdBOMLine(BOMBuffer, ProdBOMLine, ParentItem, ParentBOMBuffer, EntryNo, TreeType, IsHandled);
                if not IsHandled then
                    if ProdBOMLine."No." <> '' then
                        case ProdBOMLine.Type of
                            ProdBOMLine.Type::Item:
                                begin
                                    BOMBuffer.SetLocationVariantFiltersFrom(ItemFilter);
                                    BomQtyPerUom :=
                                    BCUpgradeCU.GetQtyPerBOMHeaderUnitOfMeasure(
                                        ParentItem, ParentBOMBuffer."Production BOM No.",
                                        VersionMgt.GetBOMVersion(ParentBOMBuffer."Production BOM No.", WorkDate(), true));
                                    BOMBuffer.TransferFromProdComp(
                                    EntryNo, ProdBOMLine, ParentBOMBuffer.Indentation + 1,
                                    Round(
                                        ParentBOMBuffer."Qty. per Top Item" *
                                        UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
                                    Round(
                                        ParentBOMBuffer."Scrap Qty. per Top Item" *
                                        UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
                                    ParentBOMBuffer."Scrap %",
                                    CalcCompDueDate(ParentBOMBuffer."Needed by Date", ParentItem, ProdBOMLine."Lead-Time Offset"),
                                    ParentBOMBuffer."Location Code",
                                    ParentItem, BomQtyPerUom);

                                    if ParentItem."Production BOM No." <> ParentBOMBuffer."Production BOM No." then begin
                                        BOMBuffer."Qty. per Parent" := BOMBuffer."Qty. per Parent" * ParentBOMBuffer."Qty. per Parent";
                                        BOMBuffer."Scrap Qty. per Parent" := BOMBuffer."Scrap Qty. per Parent" * ParentBOMBuffer."Qty. per Parent";
                                        BOMBuffer."Qty. per BOM Line" := BOMBuffer."Qty. per BOM Line" * ParentBOMBuffer."Qty. per Parent";
                                    end;
                                    // OnAfterTransferFromProdItem(BOMBuffer, ProdBOMLine, EntryNo);
                                    GenerateItemSubTree(ProdBOMLine."No.", BOMBuffer);
                                    //OnGenerateProdCompSubTreeOnAfterGenerateItemSubTree(ParentBOMBuffer, BOMBuffer);
                                end;
                            ProdBOMLine.Type::"Production BOM":
                                begin
                                    // OnBeforeTransferFromProdBOM(BOMBuffer, ProdBOMLine, ParentItem, ParentBOMBuffer, EntryNo, TreeType);

                                    BOMBuffer := ParentBOMBuffer;
                                    BOMBuffer."Qty. per Top Item" := Round(BOMBuffer."Qty. per Top Item" * ProdBOMLine."Quantity per", UOMMgt.QtyRndPrecision());
                                    if ParentItem."Production BOM No." <> ParentBOMBuffer."Production BOM No." then
                                        BOMBuffer."Qty. per Parent" := ParentBOMBuffer."Qty. per Parent" * ProdBOMLine."Quantity per"
                                    else
                                        BOMBuffer."Qty. per Parent" := ProdBOMLine."Quantity per";

                                    BOMBuffer."Scrap %" := CombineScrapFactors(BOMBuffer."Scrap %", ProdBOMLine."Scrap %");
                                    if MfgCostCalcMgt.FindRoutingLine(RoutingLine, ProdBOMLine, WorkDate(), ParentItem."Routing No.") then
                                        BOMBuffer."Scrap %" := CombineScrapFactors(BOMBuffer."Scrap %", RoutingLine."Scrap Factor % (Accumulated)" * 100);
                                    BOMBuffer."Scrap %" := Round(BOMBuffer."Scrap %", 0.00001);

                                    // OnAfterTransferFromProdBOM(BOMBuffer, ProdBOMLine);

                                    CopyOfParentItem := ParentItem;
                                    ParentItem."Routing No." := '';
                                    ParentItem."Production BOM No." := ProdBOMLine."No.";
                                    GenerateProdCompSubTree(ParentItem, BOMBuffer);
                                    ParentItem := CopyOfParentItem;

                                    // OnAfterGenerateProdCompSubTree(ParentItem, BOMBuffer, ParentBOMBuffer);
                                end;
                        end;
            // OnGenerateProdCompSubTreeOnAfterProdBOMLineLoop(ParentBOMBuffer, BOMBuffer);
            until ProdBOMLine.Next() = 0;
            FoundSubTree := true;
        end;

        if RoutingLine.ReadPermission then
            if (TreeType in [TreeType::" ", TreeType::Cost]) and
                   RoutingLine.CertifiedRoutingVersionExists(ParentItem."Routing No.", WorkDate())
            then begin
                repeat
                    RunIteration := RoutingLine."No." <> '';
                    // OnGenerateProdCompSubTreeOnBeforeRoutingLineLoop(RoutingLine, BOMBuffer, RunIteration);
                    if RunIteration then begin
                        BOMBuffer.SetLocationVariantFiltersFrom(ItemFilter);
                        BOMBuffer.TransferFromProdRouting(
                          EntryNo, RoutingLine, ParentBOMBuffer.Indentation + 1,
                          ParentBOMBuffer."Qty. per Top Item" *
                          UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"),
                          ParentBOMBuffer."Needed by Date",
                          ParentBOMBuffer."Location Code");
                        //  OnAfterTransferFromProdRouting(BOMBuffer, RoutingLine);
                        if TreeType = TreeType::Cost then begin
                            LotSize := ParentBOMBuffer."Lot Size";
                            if LotSize = 0 then
                                if ParentBOMBuffer."Qty. per Top Item" <> 0 then
                                    LotSize := ParentBOMBuffer."Qty. per Top Item"
                                else
                                    LotSize := 1;
                            CalcRoutingLineCosts(RoutingLine, LotSize, ParentBOMBuffer."Scrap %", BOMBuffer, ParentItem);
                            BOMBuffer.RoundCosts(
                              ParentBOMBuffer."Qty. per Top Item" *
                              UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code") / LotSize);
                            // OnGenerateProdCompSubTreeOnBeforeBOMBufferModify(BOMBuffer, ParentBOMBuffer, ParentItem);
                            BOMBuffer.Modify();
                        end;
                        // OnGenerateProdCompSubTreeOnAfterBOMBufferModify(BOMBuffer, RoutingLine, LotSize, ParentItem, ParentBOMBuffer, TreeType);
                    end;
                until RoutingLine.Next() = 0;
                FoundSubTree := true;
            end;

        BOMBuffer := ParentBOMBuffer;
    end;

    local procedure CalcRoutingLineCosts(RoutingLine: Record "Routing Line"; LotSize: Decimal; ScrapPct: Decimal; var BOMBuffer: Record "BOM Buffer"; ParentItem: Record Item)
    var
        CalcStdCost: Codeunit "Calculate Standard Cost";
        MfgCostCalcMgt: Codeunit "Mfg. Cost Calculation Mgt.";
        CapCost: Decimal;
        CapOverhead: Decimal;
        SubcontractedCapCost: Decimal;
    begin
        //OnBeforeCalcRoutingLineCosts(RoutingLine, LotSize, ScrapPct, ParentItem);

        CalcStdCost.SetProperties(WorkDate(), false, false, false, '', false);
        CalcStdCost.CalcRtngLineCost(
          RoutingLine, MfgCostCalcMgt.CalcQtyAdjdForBOMScrap(LotSize, ScrapPct), CapCost, SubcontractedCapCost, CapOverhead);

        //OnCalcRoutingLineCostsOnBeforeBOMBufferAdd(RoutingLine, LotSize, ScrapPct, CapCost, SubcontractedCapCost, CapOverhead, BOMBuffer);

        BOMBuffer.AddCapacityCost(CapCost, CapCost);
        BOMBuffer.AddSubcontrdCost(SubcontractedCapCost, SubcontractedCapCost);
        BOMBuffer.AddCapOvhdCost(CapOverhead, CapOverhead);
    end;

    procedure CombineScrapFactors(LowLevelScrapPct: Decimal; HighLevelScrapPct: Decimal): Decimal
    begin
        exit(LowLevelScrapPct + HighLevelScrapPct + LowLevelScrapPct * HighLevelScrapPct / 100);
    end;



    procedure GetBOMUnitOfMeasure(ProdBOMNo: Code[20]; ProdBOMVersionNo: Code[20]): Code[10]
    var
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMVersion: Record "Production BOM Version";
    begin
        if ProdBOMVersionNo <> '' then begin
            ProdBOMVersion.Get(ProdBOMNo, ProdBOMVersionNo);
            exit(ProdBOMVersion."Unit of Measure Code");
        end;

        ProdBOMHeader.Get(ProdBOMNo);
        exit(ProdBOMHeader."Unit of Measure Code");
    end;

    procedure GenerateTreeForItemsSKU(VAR ParentItem: Record Item; VAR BOMBuffer: Record "BOM Buffer"; TreeType: Option " ",Availability,Cost; LocationCode: Code[20]; VariantCode: Code[20])
    var
        ItemFilter: Record Item;
        StockkeepingUnit: Record "Stockkeeping Unit";
        HeinkinBCUpgrade: Codeunit "Heineken BC Upgrade";
        DemandDate: Date;
    begin
        //HEI.01>>
        StockkeepingUnit.GET(LocationCode, ParentItem."No.", VariantCode);//HEI.01
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // WITH ParentItem DO BEGIN
        //     ItemFilter.COPY(ParentItem);

        //     GET("No.");
        //     InitBOMBuffer(BOMBuffer);
        //     InitTreeType(TreeType);

        //     //"Replenishment System" := "Replenishment System"::"Prod. Order";//HEI.01
        //     "Replenishment System" := StockkeepingUnit."Replenishment System";//HEI.01
        //     IF "Replenishment System" = "Replenishment System"::"Prod. Order" THEN BEGIN
        //         "Production BOM No." := StockkeepingUnit."Production BOM No.";
        //         "Routing No." := StockkeepingUnit."Routing No.";
        //     end;
        //     HeinkinBCUpgrade.GenerateTreeForItemSKULocal(ParentItem, BOMBuffer, DemandDate, TreeType, StockkeepingUnit);
        //     COPY(ItemFilter);
        // end;
        ItemFilter.COPY(ParentItem);

        ParentItem.GET(ParentItem."No.");
        InitBOMBuffer(BOMBuffer);
        InitTreeType(TreeType);

        //"Replenishment System" := "Replenishment System"::"Prod. Order";//HEI.01
        ParentItem."Replenishment System" := StockkeepingUnit."Replenishment System";//HEI.01
        IF ParentItem."Replenishment System" = "Replenishment System"::"Prod. Order" THEN BEGIN
            ParentItem."Production BOM No." := StockkeepingUnit."Production BOM No.";
            ParentItem."Routing No." := StockkeepingUnit."Routing No.";
        end;
        HeinkinBCUpgrade.GenerateTreeForItemSKULocal(ParentItem, BOMBuffer, DemandDate, TreeType, StockkeepingUnit);
        ParentItem.COPY(ItemFilter);
        // BC Upgrade PATELP08 <<
    end;


    procedure CalculateTreeType(var BOMBuffer: Record "BOM Buffer"; ShowTotalAvailability: Boolean; TreeType: Option " ",Availability,Cost)
    begin
        case TreeType of
            TreeType::Availability:
                UpdateAvailability(BOMBuffer, ShowTotalAvailability);
            TreeType::Cost:
                UpdateCost(BOMBuffer);
        end;
    end;

    local procedure UpdateCost(var BOMBuffer: Record "BOM Buffer")
    var
        CopyOfBOMBuffer: Record "BOM Buffer";
    begin
        CopyOfBOMBuffer.Copy(BOMBuffer);
        if BOMBuffer.Find() then
            repeat
                if BOMBuffer.Indentation = 0 then
                    TraverseCostTree(BOMBuffer);
            until BOMBuffer.Next() = 0;
        BOMBuffer.Copy(CopyOfBOMBuffer);
    end;

    local procedure TraverseCostTree(var BOMBuffer: Record "BOM Buffer"): Decimal
    var
        ParentBOMBuffer: Record "BOM Buffer";
    begin
        ParentBOMBuffer := BOMBuffer;
        while (BOMBuffer.Next() <> 0) and (ParentBOMBuffer.Indentation < BOMBuffer.Indentation) do
            if (ParentBOMBuffer.Indentation + 1 = BOMBuffer.Indentation) and
               ((BOMBuffer."Qty. per Top Item" <> 0) or (BOMBuffer.Type in [BOMBuffer.Type::"Machine Center", BOMBuffer.Type::"Work Center"]))
            then begin
                if not BOMBuffer."Is Leaf" then
                    TraverseCostTree(BOMBuffer)
                else
                    if (BOMBuffer.Type = BOMBuffer.Type::Resource) and (BOMBuffer."Resource Usage Type" = BOMBuffer."Resource Usage Type"::Fixed) then
                        UpdateNodeCosts(BOMBuffer, ParentBOMBuffer."Lot Size" / ParentBOMBuffer."Qty. per Top Item")
                    else
                        UpdateNodeCosts(BOMBuffer, 1);

                if BOMBuffer."Is Leaf" then begin
                    ParentBOMBuffer.AddMaterialCost(BOMBuffer."Single-Level Material Cost", BOMBuffer."Rolled-up Material Cost");
                    ParentBOMBuffer.AddNonInvMaterialCost(BOMBuffer."Single-Lvl Mat. Non-Invt. Cost", BOMBuffer."Rolled-up Mat. Non-Invt. Cost");
                    ParentBOMBuffer.AddCapacityCost(BOMBuffer."Single-Level Capacity Cost", BOMBuffer."Rolled-up Capacity Cost");
                    ParentBOMBuffer.AddSubcontrdCost(BOMBuffer."Single-Level Subcontrd. Cost", BOMBuffer."Rolled-up Subcontracted Cost");
                    ParentBOMBuffer.AddCapOvhdCost(BOMBuffer."Single-Level Cap. Ovhd Cost", BOMBuffer."Rolled-up Capacity Ovhd. Cost");
                    ParentBOMBuffer.AddMfgOvhdCost(BOMBuffer."Single-Level Mfg. Ovhd Cost", BOMBuffer."Rolled-up Mfg. Ovhd Cost");
                    ParentBOMBuffer.AddScrapCost(BOMBuffer."Single-Level Scrap Cost", BOMBuffer."Rolled-up Scrap Cost");
                end else begin
                    ParentBOMBuffer.AddMaterialCost(
                      BOMBuffer."Single-Level Material Cost" +
                      BOMBuffer."Single-Lvl Mat. Non-Invt. Cost" +
                      BOMBuffer."Single-Level Capacity Cost" +
                      BOMBuffer."Single-Level Subcontrd. Cost" +
                      BOMBuffer."Single-Level Cap. Ovhd Cost" +
                      BOMBuffer."Single-Level Mfg. Ovhd Cost",
                      BOMBuffer."Rolled-up Material Cost");
                    ParentBOMBuffer.AddNonInvMaterialCost(0, BOMBuffer."Rolled-up Mat. Non-Invt. Cost");
                    ParentBOMBuffer.AddCapacityCost(0, BOMBuffer."Rolled-up Capacity Cost");
                    ParentBOMBuffer.AddSubcontrdCost(0, BOMBuffer."Rolled-up Subcontracted Cost");
                    ParentBOMBuffer.AddCapOvhdCost(0, BOMBuffer."Rolled-up Capacity Ovhd. Cost");
                    ParentBOMBuffer.AddMfgOvhdCost(0, BOMBuffer."Rolled-up Mfg. Ovhd Cost");
                    ParentBOMBuffer.AddScrapCost(0, BOMBuffer."Rolled-up Scrap Cost");
                end;
                // OnTraverseCostTreeOnAfterAddCosts(ParentBOMBuffer, BOMBuffer);
            end;

        BOMBuffer := ParentBOMBuffer;
        UpdateNodeCosts(BOMBuffer, ParentBOMBuffer."Lot Size");
        exit(BOMBuffer."Able to Make Top Item");
    end;

    local procedure UpdateNodeCosts(var BOMBuffer: Record "BOM Buffer"; LotSize: Decimal)
    begin
        if LotSize = 0 then
            LotSize := 1;
        BOMBuffer.RoundCosts(LotSize);

        if BOMBuffer."Is Leaf" then begin
            case BOMBuffer.Type of
                BOMBuffer.Type::Item:
                    BOMBuffer.GetItemCosts();
                BOMBuffer.Type::Resource:
                    BOMBuffer.GetResCosts();
            end;
            BOMBuffer.RoundCosts(1 / LotSize);
        end else
            if IsProductionOrAssemblyItem(BOMBuffer."No.") then begin
                BOMBuffer.CalcOvhdCost();
                BOMBuffer.RoundCosts(1 / LotSize);
                if not HasBomStructure(BOMBuffer."No.") then
                    BOMBuffer.GetItemUnitCost();
            end else
                if BOMBuffer.Type = BOMBuffer.Type::Item then begin
                    BOMBuffer.RoundCosts(1 / LotSize);
                    BOMBuffer.GetItemCosts();
                end;

        BOMBuffer.CalcUnitCost();
        BOMBuffer.Modify();
    end;

    local procedure HasBomStructure(ItemNo: Code[20]): Boolean
    var
        Item: Record Item;
    begin
        Item.Get(ItemNo);
        case Item."Replenishment System" of
            Item."Replenishment System"::Assembly:
                begin
                    Item.CalcFields("Assembly BOM");
                    if Item."Assembly BOM" then
                        exit(true);
                end;
            Item."Replenishment System"::"Prod. Order":
                if Item."Production BOM No." <> '' then
                    exit(true);
        end;
    end;

    local procedure IsProductionOrAssemblyItem(ItemNo: Code[20]): Boolean
    var
        Item: Record Item;
    begin
        if not Item.Get(ItemNo) then
            exit(false);

        exit(Item.IsMfgItem() or Item.IsAssemblyItem());
    end;

    local procedure UpdateAvailability(var BOMBuffer: Record "BOM Buffer"; ShowTotalAvailability: Boolean)
    var
        CopyOfBOMBuffer: Record "BOM Buffer";
        TempMemoizedResult: Record "Memoized Result" temporary;
        UOMMgt: Codeunit "Unit of Measure Management";
        OptimalQty: Decimal;
        SubOptimalQty: Decimal;
        AvailToUse: Option UpdatedQtyOnItemAvail,QtyOnItemAvail,QtyAvail;
    begin
        CopyOfBOMBuffer.Copy(BOMBuffer);
        BOMBuffer.SetRange("Inventoriable", true);
        if BOMBuffer.Find() then
            repeat
                if BOMBuffer.Indentation = 0 then begin
                    InitItemAvailDates(BOMBuffer);
                    SubOptimalQty := TraverseTree(BOMBuffer, AvailToUse::QtyOnItemAvail);
                    TempMemoizedResult.DeleteAll();
                    OptimalQty := BinarySearchOptimal(BOMBuffer, UOMMgt.QtyRndPrecision(), SubOptimalQty);
                    MarkBottlenecks(BOMBuffer, OptimalQty);
                    CalcAvailability(BOMBuffer, OptimalQty, false);
                    if ShowTotalAvailability then
                        DistributeRemainingAvail(BOMBuffer);
                    TraverseTree(BOMBuffer, AvailToUse::QtyAvail);
                end;
            until BOMBuffer.Next() = 0;
        BOMBuffer.SetRange("Inventoriable");
        BOMBuffer.Copy(CopyOfBOMBuffer);
    end;

    local procedure DistributeRemainingAvail(var BOMBuffer: Record "BOM Buffer")
    var
        CopyOfBOMBuffer: Record "BOM Buffer";
        CurrItemAvailByDate: Record "Item Availability by Date";
        TempItemAvailByDate: Record "Item Availability by Date" temporary;

    begin
        CopyOfBOMBuffer.Copy(BOMBuffer);
        BOMBuffer.Reset();
        BOMBuffer.SetCurrentKey(Type, "No.", Indentation);
        BOMBuffer.SetFilter("Entry No.", '>=%1', BOMBuffer."Entry No.");
        BOMBuffer.SetFilter("Calculation Formula", '<>%1', BOMBuffer."Calculation Formula"::"Fixed Quantity");
        TempItemAvailByDate.Reset();
        if TempItemAvailByDate.FindSet() then
            repeat
                if TempItemAvailByDate."Updated Available Qty" <> 0 then begin
                    CurrItemAvailByDate := TempItemAvailByDate;

                    BOMBuffer.SetRange(Type, BOMBuffer.Type);
                    BOMBuffer.SetRange("No.", TempItemAvailByDate."Item No.");
                    BOMBuffer.SetRange("Variant Code", TempItemAvailByDate."Variant Code");
                    if LocationSpecific then
                        BOMBuffer.SetRange("Location Code", TempItemAvailByDate."Location Code");
                    BOMBuffer.SetRange("Needed by Date", TempItemAvailByDate.Date);
                    if BOMBuffer.FindFirst() then begin
                        BOMBuffer."Available Quantity" += TempItemAvailByDate."Updated Available Qty";
                        BOMBuffer."Unused Quantity" += TempItemAvailByDate."Updated Available Qty";
                        BOMBuffer.Modify();

                        ReduceAvailability(BOMBuffer."No.", BOMBuffer."Variant Code", BOMBuffer."Location Code", BOMBuffer."Needed by Date", TempItemAvailByDate."Updated Available Qty", BOMBuffer."Calculation Formula");
                    end;

                    TempItemAvailByDate := CurrItemAvailByDate;
                end;
            until TempItemAvailByDate.Next() = 0;
        BOMBuffer.Copy(CopyOfBOMBuffer);
        BOMBuffer.Find();
    end;

    local procedure ReduceAvailability(ItemNo: Code[20]; VariantCode: Code[10]; LocationCode: Code[10]; ToDate: Date; Qty: Decimal; BOMLineCalcFormula: Enum "Quantity Calculation Formula")
    var
        TempItemAvailByDate: Record "Item Availability by Date" temporary;
    begin
        if BOMLineCalcFormula = BOMLineCalcFormula::"Fixed Quantity" then
            exit;
        TempItemAvailByDate.Reset();
        TempItemAvailByDate.SetRange("Item No.", ItemNo);
        TempItemAvailByDate.SetRange("Variant Code", VariantCode);
        if LocationSpecific then
            TempItemAvailByDate.SetRange("Location Code", LocationCode);
        TempItemAvailByDate.SetRange(Date, 0D, ToDate);
        if TempItemAvailByDate.FindSet() then
            repeat
                if TempItemAvailByDate."Updated Available Qty" <> 0 then begin
                    if TempItemAvailByDate."Updated Available Qty" > Qty then
                        TempItemAvailByDate."Updated Available Qty" := TempItemAvailByDate."Updated Available Qty" - Qty
                    else
                        TempItemAvailByDate."Updated Available Qty" := 0;
                    TempItemAvailByDate.Modify();
                end;
            until TempItemAvailByDate.Next() = 0;
        TempItemAvailByDate.SetRange("Item No.");
        TempItemAvailByDate.SetRange("Variant Code");
        TempItemAvailByDate.SetRange("Location Code");
        TempItemAvailByDate.SetRange(Date);
    end;

    local procedure CalcAvailability(var BOMBuffer: Record "BOM Buffer"; Input: Decimal; IsTest: Boolean): Boolean
    var
        ParentBOMBuffer: Record "BOM Buffer";
        TempItemAvailByDate: Record "Item Availability by Date" temporary;
        TempMemoizedResult: Record "Memoized Result" temporary;
        UOMMgt: Codeunit "Unit of Measure Management";
        AvailableVsExpectedCondition: Boolean;
        AvailQty: Decimal;
        ExpectedQty: Decimal;
        MaxTime: Integer;

    begin
        if BOMBuffer.Indentation = 0 then begin
            if IsTest then
                if TempMemoizedResult.Get(Input) then
                    exit(TempMemoizedResult.Output);

            ResetUpdatedAvailability();
        end;

        MaxTime := 0;
        ParentBOMBuffer := BOMBuffer;
        while (BOMBuffer.Next() <> 0) and (ParentBOMBuffer.Indentation < BOMBuffer.Indentation) do
            if ParentBOMBuffer.Indentation + 1 = BOMBuffer.Indentation then begin
                TempItemAvailByDate.SetRange("Item No.", BOMBuffer."No.");
                TempItemAvailByDate.SetRange(Date, BOMBuffer."Needed by Date");
                TempItemAvailByDate.SetRange("Variant Code", BOMBuffer."Variant Code");
                if LocationSpecific then
                    TempItemAvailByDate.SetRange("Location Code", BOMBuffer."Location Code");
                TempItemAvailByDate.FindFirst();
                if BOMBuffer."Calculation Formula" = BOMBuffer."Calculation Formula"::"Fixed Quantity" then begin
                    ExpectedQty := Round(BOMBuffer."Qty. per Parent", UOMMgt.QtyRndPrecision());
                    AvailQty := TempItemAvailByDate."Available Qty"
                end
                else begin
                    ExpectedQty := Round(BOMBuffer."Qty. per Parent" * Input, UOMMgt.QtyRndPrecision());
                    AvailQty := TempItemAvailByDate."Updated Available Qty";
                end;

                AvailableVsExpectedCondition := AvailQty < ExpectedQty;
                // OnCalcAvailabilityOnBeforeUpdateAvailableQty(BOMBuffer, ExpectedQty, AvailQty, AvailableVsExpectedCondition);
                if AvailableVsExpectedCondition then begin
                    if BOMBuffer."Is Leaf" then begin
                        if MarkBottleneck then begin
                            BOMBuffer.Bottleneck := true;
                            BOMBuffer.Modify(true);
                        end;
                        BOMBuffer := ParentBOMBuffer;
                        if (BOMBuffer.Indentation = 0) and IsTest then
                            AddMemoizedResult(Input, false);
                        exit(false);
                    end;
                    if AvailQty <> 0 then
                        ReduceAvailability(BOMBuffer."No.", BOMBuffer."Variant Code", BOMBuffer."Location Code", BOMBuffer."Needed by Date", AvailQty, BOMBuffer."Calculation Formula");
                    if not IsTest then begin
                        BOMBuffer."Available Quantity" := AvailQty;
                        BOMBuffer.Modify();
                    end;
                    if not CalcAvailability(BOMBuffer, ExpectedQty - AvailQty, IsTest) then begin
                        if MarkBottleneck then begin
                            BOMBuffer.Bottleneck := true;
                            BOMBuffer.Modify(true);
                        end;
                        BOMBuffer := ParentBOMBuffer;
                        if (BOMBuffer.Indentation = 0) and IsTest then
                            AddMemoizedResult(Input, false);
                        exit(false);
                    end;
                    if not IsTest then
                        if MaxTime < (ParentBOMBuffer."Needed by Date" - BOMBuffer."Needed by Date") + BOMBuffer."Rolled-up Lead-Time Offset" then
                            MaxTime := (ParentBOMBuffer."Needed by Date" - BOMBuffer."Needed by Date") + BOMBuffer."Rolled-up Lead-Time Offset";
                end else begin
                    if not IsTest then begin
                        if BOMBuffer."Calculation Formula" <> BOMBuffer."Calculation Formula"::"Fixed Quantity" then begin
                            BOMBuffer."Available Quantity" := ExpectedQty;
                            BOMBuffer.Modify();
                        end;
                        if MaxTime < (ParentBOMBuffer."Needed by Date" - BOMBuffer."Needed by Date") + BOMBuffer."Rolled-up Lead-Time Offset" then
                            MaxTime := (ParentBOMBuffer."Needed by Date" - BOMBuffer."Needed by Date") + BOMBuffer."Rolled-up Lead-Time Offset";
                    end;
                    ReduceAvailability(BOMBuffer."No.", BOMBuffer."Variant Code", BOMBuffer."Location Code", BOMBuffer."Needed by Date", ExpectedQty, BOMBuffer."Calculation Formula");
                end;
            end;
        BOMBuffer := ParentBOMBuffer;
        BOMBuffer."Rolled-up Lead-Time Offset" := MaxTime;
        BOMBuffer.Modify(true);
        if (BOMBuffer.Indentation = 0) and IsTest then
            AddMemoizedResult(Input, true);
        exit(true);
    end;

    local procedure AddMemoizedResult(NewInput: Decimal; NewOutput: Boolean)
    var
        TempMemoizedResult: Record "Memoized Result" temporary;
    begin
        TempMemoizedResult.Input := NewInput;
        TempMemoizedResult.Output := NewOutput;
        TempMemoizedResult.Insert();
    end;

    local procedure ResetUpdatedAvailability()
    var
        TempItemAvailByDate: Record "Item Availability by Date" temporary;
    begin
        TempItemAvailByDate.Reset();
        if TempItemAvailByDate.Find('-') then
            repeat
                if TempItemAvailByDate."Updated Available Qty" <> TempItemAvailByDate."Available Qty" then begin
                    TempItemAvailByDate."Updated Available Qty" := TempItemAvailByDate."Available Qty";
                    TempItemAvailByDate.Modify();
                end;
            until TempItemAvailByDate.Next() = 0;
    end;

    local procedure MarkBottlenecks(var BOMBuffer: Record "BOM Buffer"; Input: Decimal)
    var
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        MarkBottleneck := true;
        CalcAvailability(BOMBuffer, Input + UOMMgt.QtyRndPrecision(), true);
        MarkBottleneck := false;
    end;

    local procedure BinarySearchOptimal(var BOMBuffer: Record "BOM Buffer"; InputLow: Decimal; InputHigh: Decimal): Decimal
    var
        TempMemoizedResult: Record "Memoized Result" temporary;
        UOMMgt: Codeunit "Unit of Measure Management";
        InputMid: Decimal;
    begin
        if InputHigh <= 0 then
            exit(0);
        if CalcAvailability(BOMBuffer, InputHigh, true) then begin
            TempMemoizedResult.DeleteAll();
            exit(InputHigh);
        end;
        if InputHigh - InputLow = UOMMgt.QtyRndPrecision() then begin
            TempMemoizedResult.DeleteAll();
            exit(InputLow);
        end;
        InputMid := Round((InputLow + InputHigh) / 2, UOMMgt.QtyRndPrecision());
        if not CalcAvailability(BOMBuffer, InputMid, true) then
            exit(BinarySearchOptimal(BOMBuffer, InputLow, InputMid));
        exit(BinarySearchOptimal(BOMBuffer, InputMid, InputHigh));
    end;

    local procedure TraverseTree(var BOMBuffer: Record "BOM Buffer"; AvailToUse: Option UpdatedQtyOnItemAvail,QtyOnItemAvail,QtyAvail): Decimal
    var
        ParentBOMBuffer: Record "BOM Buffer";
        IsFirst: Boolean;
        IsHandled: Boolean;
        MinAbleToMakeQty: Decimal;
        MinAbleToMakeTopItem: Decimal;
    begin
        ParentBOMBuffer := BOMBuffer;
        IsFirst := true;
        while (BOMBuffer.Next() <> 0) and (ParentBOMBuffer.Indentation < BOMBuffer.Indentation) do
            if ParentBOMBuffer.Indentation + 1 = BOMBuffer.Indentation then begin
                if not BOMBuffer."Is Leaf" then
                    TraverseTree(BOMBuffer, AvailToUse)
                else begin
                    MinAbleToMakeQty := UpdateMinAbleToMake(BOMBuffer, AvailToUse);
                    MinAbleToMakeTopItem := CalcMinAbleToMake(IsFirst, MinAbleToMakeTopItem, MinAbleToMakeQty);
                end;

                IsHandled := false;
                //  OnTraverseTreeOnBeforeCalcAbleToMakeParentAndTopItem(BOMBuffer, ParentBOMBuffer, IsHandled);
                if not IsHandled then
                    if BOMBuffer."Calculation Formula" = BOMBuffer."Calculation Formula"::"Fixed Quantity" then begin
                        ParentBOMBuffer."Able to Make Parent" := CalcMinAbleToMake(IsFirst, ParentBOMBuffer."Able to Make Parent", MinAbleToMakeTopItem);
                        ParentBOMBuffer."Able to Make Top Item" := CalcMinAbleToMake(IsFirst, ParentBOMBuffer."Able to Make Top Item", MinAbleToMakeTopItem);
                    end
                    else begin
                        ParentBOMBuffer."Able to Make Parent" := CalcMinAbleToMake(IsFirst, ParentBOMBuffer."Able to Make Parent", BOMBuffer."Able to Make Parent");
                        MinAbleToMakeTopItem := CalcMinAbleToMake(IsFirst, ParentBOMBuffer."Able to Make Top Item", BOMBuffer."Able to Make Top Item");
                        ParentBOMBuffer."Able to Make Top Item" := MinAbleToMakeTopItem;
                    end;
                IsFirst := false;
            end;

        BOMBuffer := ParentBOMBuffer;
        UpdateMinAbleToMake(BOMBuffer, AvailToUse);
        exit(MinAbleToMakeTopItem);
    end;

    local procedure CalcMinAbleToMake(IsFirst: Boolean; OldMin: Decimal; NewMin: Decimal): Decimal
    begin
        if NewMin <= 0 then
            exit(0);
        if IsFirst then
            exit(NewMin);
        if NewMin < OldMin then
            exit(NewMin);
        exit(OldMin);
    end;

    local procedure UpdateMinAbleToMake(var BOMBuffer: Record "BOM Buffer"; AvailToUse: Option UpdatedQtyOnItemAvail,QtyOnItemAvail,QtyAvail): Decimal
    var
        TempItemAvailByDate: Record "Item Availability by Date" temporary;
        AvailQty: Decimal;

    begin
        TempItemAvailByDate.SetRange("Item No.", BOMBuffer."No.");
        TempItemAvailByDate.SetRange("Variant Code", BOMBuffer."Variant Code");
        if LocationSpecific then
            TempItemAvailByDate.SetRange("Location Code", BOMBuffer."Location Code");
        TempItemAvailByDate.SetRange(Date, BOMBuffer."Needed by Date");
        TempItemAvailByDate.FindFirst();

        case AvailToUse of
            AvailToUse::UpdatedQtyOnItemAvail:
                AvailQty := TempItemAvailByDate."Updated Available Qty";
            AvailToUse::QtyOnItemAvail:
                AvailQty := TempItemAvailByDate."Available Qty";
            AvailToUse::QtyAvail:
                AvailQty := BOMBuffer."Available Quantity";
        end;

        if BOMBuffer."Calculation Formula" = BOMBuffer."Calculation Formula"::"Fixed Quantity" then
            exit(MinAbleToMakeWithFixedQuantity(BOMBuffer, AvailQty))
        else begin
            BOMBuffer.UpdateAbleToMake(AvailQty);
            BOMBuffer.Modify();
            exit(BOMBuffer."Able to Make Top Item");
        end;
    end;

    local procedure UpdateAvailabilityForFixedQty(var BOMBuffer: Record "BOM Buffer"; AvailableQty: Decimal)
    begin
        if BOMBuffer."Calculation Formula" = BOMBuffer."Calculation Formula"::"Fixed Quantity" then begin
            BOMBuffer."Available Quantity" := AvailableQty;
            BOMBuffer.Modify();
        end;
    end;

    local procedure MinAbleToMakeWithFixedQuantity(var BOMBuffer: Record "BOM Buffer"; AvailableQty: Decimal): Decimal
    begin
        if BOMBuffer."Calculation Formula" = BOMBuffer."Calculation Formula"::"Fixed Quantity" then begin
            UpdateAvailabilityForFixedQty(BOMBuffer, AvailableQty);
            if AvailableQty < BOMBuffer."Qty. per Parent" then
                exit(0)
            else
                exit(999999999);
        end;
    end;

    local procedure InitItemAvailDates(var BOMBuffer: Record "BOM Buffer")
    var
        ParentBOMBuffer: Record "BOM Buffer";
        BOMItem: Record Item;
        ItemFilter: Record Item;
        TempItemAvailByDate: Record "Item Availability by Date" temporary;
        AvailableToPromise: Codeunit "Available to Promise";
        ZeroDF: DateFormula;
    begin
        ParentBOMBuffer := BOMBuffer;
        TempItemAvailByDate.Reset();
        TempItemAvailByDate.DeleteAll();
        Evaluate(ZeroDF, '<0D>');

        repeat
            if not AvailByDateExists(BOMBuffer) then begin
                BOMItem.CopyFilters(ItemFilter);
                BOMItem.Get(BOMBuffer."No.");
                BOMItem.SetRange("Date Filter", 0D, BOMBuffer."Needed by Date");
                if BOMBuffer.Indentation = 0 then begin
                    BOMItem.SetFilter("Variant Filter", ItemFilter.GetFilter("Variant Filter"));
                    BOMItem.SetFilter("Location Filter", ItemFilter.GetFilter("Location Filter"));
                end else
                    BOMItem.SetRange("Variant Filter", BOMBuffer."Variant Code");

                TempItemAvailByDate.Init();
                TempItemAvailByDate."Item No." := BOMBuffer."No.";
                TempItemAvailByDate.Date := BOMBuffer."Needed by Date";
                TempItemAvailByDate."Variant Code" := BOMBuffer."Variant Code";
                if LocationSpecific then
                    TempItemAvailByDate."Location Code" := BOMBuffer."Location Code";

                Clear(AvailableToPromise);
                //OnInitItemAvailDatesOnBeforeCalcAvailableQty(BOMItem);
                TempItemAvailByDate."Available Qty" :=
                  AvailableToPromise.CalcQtyAvailabletoPromise(
                      BOMItem, BOMBuffer."Gross Requirement", BOMBuffer."Scheduled Receipts", BOMBuffer."Needed by Date", "Analysis Period Type"::Day, ZeroDF);
                TempItemAvailByDate."Updated Available Qty" := TempItemAvailByDate."Available Qty";
                TempItemAvailByDate.Insert();

                BOMBuffer.Modify();
            end;
        until (BOMBuffer.Next() = 0) or (BOMBuffer.Indentation <= ParentBOMBuffer.Indentation);
        BOMBuffer := ParentBOMBuffer;
        BOMBuffer.Find();
    end;

    local procedure AvailByDateExists(BOMBuffer: Record "BOM Buffer"): Boolean
    var
        TempItemAvailByDate: Record "Item Availability by Date" temporary;

    begin
        if LocationSpecific then
            exit(TempItemAvailByDate.Get(BOMBuffer."No.", BOMBuffer."Variant Code", BOMBuffer."Location Code", BOMBuffer."Needed by Date"));
        exit(TempItemAvailByDate.Get(BOMBuffer."No.", BOMBuffer."Variant Code", '', BOMBuffer."Needed by Date"));
    end;


    local procedure InitTreeType(NewTreeType: Option)
    begin
        TreeType := NewTreeType;
    end;

    local procedure InitBOMBuffer(var BOMBuffer: Record "BOM Buffer")
    begin
        BOMBuffer.Reset();
        BOMBuffer.DeleteAll();
    end;

    //HEI.01<<
    var
        LocationSpecific: Boolean;
        MarkBottleneck: Boolean;
        TreeType: Option " ",Availability,Cost;
    //BC Upgrade Manisha CU 5063<<

    //BC Upgrade Manisha Table Bom Buffer
    procedure GetSKUFromFilter(var SKU: Record "Stockkeeping Unit"; ItemNo: Code[20]): Boolean
    var
        ItemFilter: Record Item;
        LocationFilter: Text;
        VariantFilter: Text;
    begin
        ItemFilter.Get(ItemNo);
        //LocationFilter := GetFilter("Location Code");//BC Upgrade Manisha
        LocationFilter := ItemFilter.GetFilter(ItemFilter."Location Filter");
        //if StrLen(LocationFilter) > MaxStrLen("Location Code") then
        //    exit(false);//BC Upgrade Manisha

        if StrLen(LocationFilter) > MaxStrLen(ItemFilter."Location Filter") then
            exit(false);//BC Upgrade Manisha

        // VariantFilter := GetFilter("Variant Code");
        // if StrLen(VariantFilter) > MaxStrLen("Variant Code") then
        //     exit(false);//BC Upgrade Manisha

        VariantFilter := ItemFilter.GetFilter(ItemFilter."Variant Filter");
        if StrLen(VariantFilter) > MaxStrLen(ItemFilter."Variant Filter") then
            exit(false);//BC Upgrade Manisha

        exit(SKU.Get(LocationFilter, ItemNo, VariantFilter));
    end;
    //Bc Upgrade Manisha Bom Buffer

    //BC UPGRADE SIVA >> Used in Codeunit Heineken BC Upgrade for event subscriber of Whse.-Shipment Release 
    //1.IsTransGateEntryMandatory procedure used in Before release EventSubscriber of Whse.-Shipment Release to check mandatory Bin&Location
    //2.IsSalesGateEntryMandatory procedure used in Before release EventSubscriber of Whse.-Shipment Release to check mandatory Bin&Location  
    PROCEDURE IsTransGateEntryMandatory(LocationCode: Code[20]; ZoneCode: Code[20]): Boolean;
    VAR
        LocationRec: Record 14;
        ZoneRec: Record 7300;
    BEGIN
        //HEI.01>>
        //>>HEI:EDD001:1:1
        //HEI.12>>
        //IF LocationRec.GET(LocationCode) AND ZoneRec.GET(LocationCode,ZoneCode) THEN BEGIN
        //HEI.13>>
        //IF LocationRec.GET(LocationCode) OR ZoneRec.GET(LocationCode,ZoneCode) THEN BEGIN
        //IF LocationRec."Transfer Gate Entry Mandatory" OR ZoneRec."Transfer Gate Entry Mandatory" THEN
        IF (ZoneCode <> '') AND ZoneRec.GET(LocationCode, ZoneCode) THEN
            EXIT(ZoneRec."Transf.Gate EntryMandatory FND");

        IF LocationRec.GET(LocationCode) THEN BEGIN
            IF LocationRec."Transfer Gate Entry Mandat FND" THEN
                //HEI.13<<
                //HEI.12<<
                EXIT(TRUE)
            ELSE
                EXIT(FALSE);
        END ELSE
            EXIT(FALSE);
        //<<HEI:EDD001:1:1
        //HEI.01<<
    END;

    PROCEDURE IsSalesGateEntryMandatory(LocationCode: Code[20]; ZoneCode: Code[20]): Boolean;
    VAR
        Location: Record 14;
        Zone: Record 7300;
    BEGIN
        //HEI.05>>
        //HEI.31>>
        //IF Location.GET(LocationCode) AND Zone.GET(LocationCode,ZoneCode) THEN BEGIN
        //HEI.32>>
        //IF Location.GET(LocationCode) OR Zone.GET(LocationCode,ZoneCode) THEN BEGIN
        //IF Location."Sales Gate Entry Mandatory" OR Zone."Sales Gate Entry Mandatory" THEN
        IF (ZoneCode <> '') AND Zone.GET(LocationCode, ZoneCode) THEN
            EXIT(Zone."Sales Gate Entry Mandatory FND");

        IF Location.GET(LocationCode) THEN BEGIN
            IF Location."Sales Gate Entry Mandatory FND" THEN
                //HEI.32<<
                //HEI.31<<
                EXIT(TRUE)
            ELSE
                EXIT(FALSE);
        END ELSE
            EXIT(FALSE);
        //HEI.05<<
    END;
    //BC UPGRADE SIVA >> Used in Codeunit Heineken BC Upgrade for event subscriber of Whse.-Shipment Release

    // BC Upgrade POENAB02 >> 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Suggest Worksheet Lines" then
            NewReportId := Report::"SuggestWorksheetLinesHeiLite";
    end;
    // BC Upgrade POENAB02 <<

    //BC Upgrade RD03 - Calculate Prod. Order ---------------------------- >>

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", OnTransferBOMOnAfterCalcReqQty, '', false, false)]
    local procedure OnTransferBOMOnAfterCalcReqQty(ProductionBOMLine: Record "Production BOM Line"; ProdOrderRoutingLine: Record "Prod. Order Routing Line"; ProdOrderLine: Record "Prod. Order Line"; var ReqQty: Decimal; LineQtyPerUOM: Decimal; ItemQtyPerUOM: Decimal)
    begin
        Line_QtyPerUOM := LineQtyPerUOM;
        Item_QtyPerUOM := ItemQtyPerUOM;
        GlobalProdOrderLine := ProdOrderLine; //BC Upgrade GUNREM01 -Bug fix
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", OnTransferBOMOnBeforeProcessItem, '', false, false)]
    local procedure OnTransferBOMOnBeforeProcessItem(ProdBOMLine: Record "Production BOM Line"; ReqQty: Decimal; var SkipTransfer: Boolean)
    begin
        ItemAttribute.SETFILTER(Name, 'Common Material Group');
        IF ItemAttribute.FINDFIRST() THEN
            ItemAttributeValueMapping.SETRANGE("Table ID", 27);
        ItemAttributeValueMapping.SETFILTER("No.", ProdBOMLine."No.");
        ItemAttributeValueMapping.SETRANGE("Item Attribute ID", ItemAttribute.ID);
        IF ItemAttributeValueMapping.FINDFIRST() THEN BEGIN
            REPEAT
                //ItemAttribute.SETRANGE(ID,ItemAttributeValueMapping."Item Attribute ID");
                //IF ItemAttribute.FINDSET THEN BEGIN REPEAT
                //IF ItemAttribute.Name ='Common Material Group' THEN BEGIN
                ItemAttributeValue.SETRANGE("Attribute ID", ItemAttribute.ID);
                ItemAttributeValue.SETRANGE(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                IF ItemAttributeValue.FINDSET() THEN BEGIN
                    REPEAT
                        IF ItemAttributeValue.Value = 'CMG0418' THEN
                            ItemCommonMatGroup := TRUE;
                    UNTIL ItemAttributeValue.NEXT() = 0;
                END;
            //END;
            //UNTIL ItemAttribute.NEXT=0;
            // END;
            UNTIL ItemAttributeValueMapping.NEXT = 0;
        END;
        IF ItemCommonMatGroup THEN
            CreateSplitComponentlinesforYeatMaterialGroup(ProdBOMLine, Line_QtyPerUOM, Item_QtyPerUOM, 0)
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", OnAfterTransferRoutingLine, '', false, false)]
    local procedure OnAfterTransferRoutingLine(var ProdOrderLine: Record "Prod. Order Line"; var RoutingLine: Record "Routing Line"; var ProdOrderRoutingLine: Record "Prod. Order Routing Line")
    var
        MfgCostCalculationMgt: Codeunit "Mfg. Cost Calculation Mgt.";
    begin
        MfgCostCalculationMgt.CalcRoutingCostPerUnit(ProdOrderRoutingLine.Type, ProdOrderRoutingLine."No.", ProdOrderRoutingLine."Direct Unit Cost",
  ProdOrderRoutingLine."Indirect Cost %", ProdOrderRoutingLine."Overhead Rate", ProdOrderRoutingLine."Unit Cost per", ProdOrderRoutingLine."Unit Cost Calculation");
        /* if ProdOrderRoutingLine.Type = ProdOrderRoutingLine.Type::"Work Center" then begin
            // BC Upgrade RD03 - MANXL7 table commented
           IF rMANXLSetup.READPERMISSION THEN
              ProdOrderRoutingLine."Subcontractor No." := WorkCenter."Subcontractor No.";
            end;*/
        // BC Upgrade RD03 - MANXL7 table commented

        // BC Upgrade RD03 - DITW Fields commented >>
        /*ProdOrderRoutingLine."Completion Required" := RoutingLine."Completion Required";
        ProdOrderRoutingLine."Alert Time" := RoutingLine."Alert Time";
        ProdOrderRoutingLine."Alert Time Unit of Meas. Code" := RoutingLine."Alert Time Unit of Meas. Code";
        ProdOrderRoutingLine."Allow Alert Cancel" := RoutingLine."Allow Alert Cancel";
        ProdOrderRoutingLine."Show on Production Order" := RoutingLine."Show on Production Order";
        ProdOrderRoutingLine."Next Test Within (Hours)" := RoutingLine."Next Test Within (Hours)";*/
        // BC Upgrade RD03 - DITW Fields commented <<

        //BC Upgrade RD03 - MANXL7 fields commented >>
        /*IF rMANXLSetup.READPERMISSION THEN BEGIN
            ProdOrderRoutingLine."Line Speed" := RoutingLine."Line Speed";
            ProdOrderRoutingLine."Item Category Code" := ProdOrderLine."Item Category Code";
            ProdOrderRoutingLine."Item Product Group Code" := ProdOrderLine."Item Product Group Code";
            ProdOrderRoutingLine."Planning Group" := ProdOrderLine."Planning Group";
            ProdOrderRoutingLine."Production Group" := ProdOrderLine."Production Group";
            ProdOrderRoutingLine."Revision No." := ProdOrderLine."Revision No.";
        END;*/
        //BC Upgrade RD03 - MANXL7 fields commented <<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", OnAfterTransferBOMComponent, '', false, false)]
    local procedure OnAfterProdOrderCompInsert(var ProdOrderComponent: Record "Prod. Order Component"; ProductionBOMLine: Record "Production BOM Line")
    begin
        // BC Upgrade RD03 - in NAV field commented, in BC commending field is not possible so we make it empty >>
        //ProdOrderComponent."Bin Code" := GetDefaultBin;
        ProdOrderComponent."Bin Code" := '';
        // BC Upgrade RD03 - in NAV field commented, in BC commending field is not possible so we make it empty >>

        // BC Upgrade RD03 - DITW Fields Commented >>
        /*ProdOrderComponent."Principal Component" := BomComponent[Level]."Principal Component";
        ProdOrderComponent."Show on Prod. Order" := BomComponent[Level]."Show on Prod. Order";
        ProdOrderComponent."Special Component" := BomComponent[Level]."Special Component";*/
        // BC Upgrade RD03 - DITW Fields Commented <<

        //BC Upgrade RD03 - MANXL7 Fields Commented >>
        /*IF rMANXLSetup.READPERMISSION THEN BEGIN
            ProdOrderComponent.Critical := BomComponent[Level].Critical;
            ProdOrderComponent."Revision No." := ProdOrderLine."Revision No.";
        END;*/
        //BC Upgrade RD03 - MANXL7 Fields Commented <<
        //ProdOrderComponent."Production jnl. flushing" := BomComponent[Level]."Production jnl. flushing";

        // BC Upgrade RD03 - DITW Fields Commented >>
        // BC Upgrade RD03 - OnValidate Quantity Per field Calculation Changed >>
        //ProdOrderComponent.VALIDATE("Quantity per",
        //                       //ProdOrderComponent."Quantity per" + BomComponent[Level]."Quantity per" * LineQtyPerUOM / ItemQtyPerUOM);
        //                       ProdOrderComponent."Quantity per");
        // BC Upgrade RD03 - OnValidate Quantity Per field Calculation Changed <<
        ProdOrderComponent.VALIDATE("Quantity per", ProdOrderComponent."Quantity per");
        //ProdOrderComponent."Production jnl. flushing" := BomComponent[Level]."Production jnl. flushing";
        // BC Upgrade RD03 - DITW Fields Commented <<

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", OnBeforeProdOrderCompModify, '', false, false)]
    local procedure OnBeforeProdOrderCompModify(var ProdOrderComp: Record "Prod. Order Component"; var ProdBOMLine: Record "Production BOM Line"; LineQtyPerUOM: Decimal; ItemQtyPerUOM: Decimal)
    begin
        // BC Upgrade RD03 - DITW Fields Commented >>
        //ProdOrderComp."Production jnl. flushing" := BomComponent[Level]."Production jnl. flushing";
        // BC Upgrade RD03 - DITW Fields Commented <<
    end;

    LOCAL procedure CreateSplitComponentlinesforYeatMaterialGroup(BomComponent: Record "Production BOM Line"; LineQtyPerUOM: Decimal; ItemQtyPerUOM: Decimal; Level: Integer)
    var
        ProdOrderComp: Record "Prod. Order Component";
        ProdOrderLine: Record "Prod. Order Line";
        NextProdOrderCompLineNo: Integer;
        Item2: Record Item;
        SKU: Record "Stockkeeping Unit";
        ProductionOrder: Record "Production Order";
        RoutingVersion: Record "Routing Version";
        RoutingLine: Record "Routing Line";
        WorkCenter: Record "Work Center";
        Bin: Record Bin;
        Blocked: Boolean;
        GetPlanningParameters: Codeunit "Planning-Get Parameters";
        ComponentSKU: Record "Stockkeeping Unit";
        ManufacturingSetup: Record "Manufacturing Setup";//Bc upgrade kamnay01 // Bug fix 
    begin
        ProdOrderLine := GlobalProdOrderLine; //BC Upgrade GUNREM01 -Bug fix
        //HEI.01<<
        ProdOrderComp.RESET();
        ProdOrderComp.SETRANGE(Status, ProdOrderLine.Status);
        ProdOrderComp.SETRANGE("Prod. Order No.", ProdOrderLine."Prod. Order No.");
        ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
        IF ProdOrderComp.FINDLAST THEN
            NextProdOrderCompLineNo := ProdOrderComp."Line No." + 10000
        ELSE
            NextProdOrderCompLineNo := 10000;
        //Bc upgrade kamnay01 // Bug fix >>
        ManufacturingSetup.Get();//Bc upgrade kamnay01 // Bug fix 
        SKU.Get(ProdOrderLine."Location Code", ProdOrderLine."Item No.");
        ////Bc upgrade kamnay01 // Bug fix <<
        ProdOrderComp.INIT;
        ProdOrderComp.SetIgnoreErrors;
        ProdOrderComp.BlockDynamicTracking(Blocked);
        ProdOrderComp.Status := ProdOrderLine.Status;
        ProdOrderComp."Prod. Order No." := ProdOrderLine."Prod. Order No.";
        ProdOrderComp."Prod. Order Line No." := ProdOrderLine."Line No.";
        ProdOrderComp."Line No." := NextProdOrderCompLineNo;
        ProdOrderComp.VALIDATE("Item No.", BomComponent."No.");
        ProdOrderComp."Variant Code" := BomComponent."Variant Code";
        //BC Upgrade kamnay01 >>  Bug fix
        if SKU."Components at Location" = '' then
            ProdOrderComp."Location Code" := ManufacturingSetup."Components at Location"
        else
            //BC Upgrade kamnay01 << Bug fix
        ProdOrderComp."Location Code" := SKU."Components at Location";
        //ProdOrderComp."Bin Code" := GetDefaultBin;
        ProdOrderComp.Description := BomComponent.Description;
        ProdOrderComp.VALIDATE("Unit of Measure Code", BomComponent."Unit of Measure Code");
        ProdOrderComp."Quantity per" :=
          BomComponent."Quantity per" * LineQtyPerUOM / ItemQtyPerUOM;
        ProdOrderComp.Length := BomComponent.Length;
        ProdOrderComp.Width := BomComponent.Width;
        ProdOrderComp.Weight := BomComponent.Weight;
        ProdOrderComp.Depth := BomComponent.Depth;
        ProdOrderComp.Position := BomComponent.Position;
        ProdOrderComp."Position 2" := BomComponent."Position 2";
        ProdOrderComp."Position 3" := BomComponent."Position 3";
        ProdOrderComp."Lead-Time Offset" := BomComponent."Lead-Time Offset";
        ProdOrderComp.VALIDATE("Routing Link Code", BomComponent."Routing Link Code");
        ProdOrderComp.VALIDATE("Scrap %", BomComponent."Scrap %");
        ProdOrderComp.VALIDATE("Calculation Formula", BomComponent."Calculation Formula");
        // BC Upgrade RD03 - DITW Fields Commented >>
        /*ProdOrderComp."Principal Component" := BomComponent."Principal Component";
        ProdOrderComp."Show on Prod. Order" := BomComponent."Show on Prod. Order";
        ProdOrderComp."Special Component" := BomComponent."Special Component";
        IF rMANXLSetup.READPERMISSION THEN BEGIN
            ProdOrderComp.Critical := BomComponent.Critical;
            ProdOrderComp."Revision No." := ProdOrderLine."Revision No.";
        END;*/
        // BC Upgrade RD03 - DITW Fields Commented <<

        GetPlanningParameters.AtSKU(
          ComponentSKU, ProdOrderComp."Item No.",
          ProdOrderComp."Variant Code",
          ProdOrderComp."Location Code");

        ProdOrderComp."Flushing Method" := ComponentSKU."Flushing Method";
        IF (SKU."Manufacturing Policy" = SKU."Manufacturing Policy"::"Make-to-Order") AND
            (ComponentSKU."Manufacturing Policy" = ComponentSKU."Manufacturing Policy"::"Make-to-Order") AND
            (ComponentSKU."Replenishment System" = ComponentSKU."Replenishment System"::"Prod. Order")
        THEN BEGIN
            ProdOrderComp."Planning Level Code" := ProdOrderLine."Planning Level Code" + 1;
            Item2.GET(ProdOrderComp."Item No.");
            ProdOrderComp."Item Low-Level Code" := Item2."Low-Level Code";
        END;
        ProdOrderComp."Production jnl. flushing FND" := BomComponent."Production jnl. flushing FND";
        //HEI.01>>
        ProdOrderComp.BlockDynamicTracking(Blocked);
        ProdOrderComp.VALIDATE(
          "Quantity per",
                          ProdOrderComp."Quantity per");
        ProdOrderComp.VALIDATE("Routing Link Code", BomComponent."Routing Link Code");
        ProdOrderComp."Production jnl. flushing FND" := BomComponent."Production jnl. flushing FND";
        //HEI.01>>
        IF BomComponent."Bin Code FND" <> '' THEN
            ProdOrderComp."Bin Code" := BomComponent."Bin Code FND";

        IF BomComponent."Zone Code FND" <> '' THEN
            ProdOrderComp."Zone Code FND" := BomComponent."Zone Code FND";
        ProductionOrder.RESET();
        ProductionOrder.SETFILTER("No.", ProdOrderLine."Prod. Order No.");
        IF ProductionOrder.FINDFIRST() THEN
            IF (BomComponent."Bin Code FND" = '') AND (BomComponent."Zone Code FND" = '') THEN BEGIN
                RoutingVersion.RESET();
                // BC Upgrade RD03 - DITW Fields Commented >>
                //RoutingVersion.SETRANGE("Version Code", ProductionOrder."Routing Version Code");
                // BC Upgrade RD03 - DITW Fields Commented <<
                RoutingVersion.SETRANGE("Routing No.", ProductionOrder."Routing No.");
                IF RoutingVersion.FINDFIRST() THEN BEGIN
                    RoutingLine.RESET();
                    RoutingLine.SETRANGE("Routing No.", RoutingVersion."Routing No.");
                    // BC Upgrade RD03 - DITW Fields Commented >>
                    //RoutingLine.SETRANGE("Version Code", ProductionOrder."Routing Version Code");
                    // BC Upgrade RD03 - DITW Fields Commented <<
                    IF RoutingLine.FINDFIRST() THEN BEGIN
                        WorkCenter.RESET();
                        WorkCenter.SETRANGE("No.", RoutingLine."No.");
                        IF WorkCenter.FINDFIRST() THEN BEGIN
                            IF WorkCenter."To-Production Bin Code" <> '' THEN
                                ProdOrderComp."Bin Code" := WorkCenter."To-Production Bin Code";
                            IF Bin.GET(ProdOrderComp."Location Code", WorkCenter."To-Production Bin Code") THEN
                                ProdOrderComp."Zone Code FND" := Bin."Zone Code"
                            ELSE
                                ProdOrderComp."Bin Code" := GetDefaultBin(ProdOrderComp."Item No.", ProdOrderComp."Variant Code", ProdOrderComp."Location Code");
                            IF ProdOrderComp."Bin Code" <> '' THEN BEGIN
                                Bin.GET(ProductionOrder."Location Code", ProdOrderComp."Bin Code");
                                ProdOrderComp."Zone Code FND" := Bin."Zone Code";
                            END;
                        END;
                    END;
                END;
            END;
        ProdOrderComp.INSERT(TRUE);
        //HEI.01>>
    end;

    procedure GetDefaultBin(ItemNo: Code[20]; VariantCode: Code[10]; LocationCode: Code[10]) Bin_Code: Code[20];
    var
        BinContent: Record "Bin Content";
    BEGIN
        BinContent.SetCurrentKey(Default);
        BinContent.SetRange(Default, true);
        BinContent.SetRange("Location Code", LocationCode);
        BinContent.SetRange("Item No.", ItemNo);
        BinContent.SetRange("Variant Code", VariantCode);
        BinContent.SetLoadFields("Bin Code");
        if BinContent.FindFirst() then
            Bin_Code := BinContent."Bin Code";
    end;

    var
        //BomComponent: array[99] of Record "Production BOM Line";
        //rMANXLSetup: Record "2036302"; BC Upgrade Depricated table
        ItemAttribute: Record "Item Attribute";
        ItemAttributeValue: Record "Item Attribute Value";
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        ItemCommonMatGroup: Boolean;
        Line_QtyPerUOM, Item_QtyPerUOM : Decimal;
        //BC Upgrade RD03 - Calculate Prod. Order ---------------------------- >>
        GlobalProdOrderLine: Record "Prod. Order Line"; //BC Upgrade GUNREM01 -Bug fix
}
