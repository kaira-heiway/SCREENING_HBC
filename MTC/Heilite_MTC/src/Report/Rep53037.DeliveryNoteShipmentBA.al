report 53037 "Delivery Note - Shipment BA"
{
    // version HEI.03

    // FDD-BA_LOGGAP05 Delivery Note , IBM.NAIKH01 28.08.2018
    //   #Created a new Report.
    // 
    // HEI.01 FDD PTPGAP06 delivery note IBM ISYED01 01.30.2019.
    //   #Made changes according to FDD.
    // HEI.02 Bugfixing Bahamas IBM NASTAA02 20.02.2019 # Delivery Note Bahamas
    //   # Adjusted layout
    // HEI.03 Bugfixing Bahamas IBM NASTAA02 01.04.2019 # Sales Invoice - Layout
    //   # Increased font
    // HEI.04 RFC-CHG2042986 IBM.AB 23.12.2019
    //   # Layout Change for 2nd Page onwards
    //**********************************************************//
    //BC UPGRADE ATHUKS01 //
    //1.HEI.01 Commented "Shortcut Unit of Measure1 Code",Shortcut Unit of Measure2 Code& Shortcut Unit of Measure3 Code Drink IT fields & and its associated code have been commented out.
    //2.HEI.02,HEI.03,HEI.04 No Layout changes.  
    //3.Comment overflow warning in procedure InsertCommentLine Comment Param set lentgh 80 because table field is used same field length.   
    //4.the FindInteractTmplCode procedure name is changed to FindInteractionTemplateCode.
    //5.Commented Drink IT Code in dataitems  OnafterGetrecord & Predataitem Trigger 
    //6.CurrReport.PAGENO is deprecated and unsupported in modern Business Central (AL language) RDLC layouts, often returning a constant value of 1 or causing compilation warnings. 
    //To display page numbers, use built-in RDLC expressions like Globals!PageNumber and Globals!TotalPages directly in the report layout's header or footer instead.  
    //7.Old Report ID 50172. 
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Delivery Note - Shipment BA.rdl';

    CaptionML = ENU = 'Delivery Note - Shipment BA',
                FRA = 'Ventes : Expédition';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            RequestFilterHeadingML = ENU = 'Posted Sales Shipment',
                                     FRA = 'Expédition vente enregistrée';
            column(No_SalesShptHeader; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(SalesShptCopyText; STRSUBSTNO(Text002, CopyText))
                    {
                    }
                    column(CustBillName; CustBillName)
                    {
                    }
                    column(CustAddressBill; CustAddressBill)
                    {
                    }
                    column(CustAddressBill1; CustAddressBill1)
                    {
                    }
                    column(CustAddressBill2; CustAddressBill2)
                    {
                    }
                    column(CustShipName; CustShipName)
                    {
                    }
                    column(CustAddressShip; CustAddressShip)
                    {
                    }
                    column(CustAddressShip1; CustAddressShip1)
                    {
                    }
                    column(CustAddressShip2; CustAddressShip2)
                    {
                    }
                    column(OrderNo_SalesShptHeader; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(SalesShipmentHeader_OrderDate; FORMAT("Sales Shipment Header"."Order Date"))
                    {
                    }
                    column(ExtDocNo; "Sales Shipment Header"."External Document No.")
                    {
                    }
                    column(SalesShipmentHeader_ShipmentMethodCode; ShipmentMethod.Description)
                    {
                    }
                    column(SalesShipmentHeader_PaymentTermsCode; PaymentTerms.Description)
                    {
                    }
                    column(SalesShipmentHeader_RequestedDeliveryDate; FORMAT("Sales Shipment Header"."Requested Delivery Date"))
                    {
                    }
                    column(SalesShipmentHeader_SelltoCustomerNo; "Sales Shipment Header"."Sell-to Customer No.")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(UOMEquivalent1; UOMEquivalent1)
                    {
                    }
                    column(UOMEquivalent2; UOMEquivalent2)
                    {
                    }
                    column(UOMEquivalent3; UOMEquivalent3)
                    {
                    }
                    column(TotalIndvUnits; TotalIndvUnits)
                    {
                    }
                    column(TotalCases; TotalCases)
                    {
                    }
                    column(TotalBarrels; TotalBarrels)
                    {
                    }
                    column(TotalPallets; TotalPallets)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FINDSET() then
                                    CurrReport.BREAK();
                            end else
                                if not Continue then
                                    CurrReport.BREAK();

                            CLEAR(DimText);
                            Continue := false;
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := STRSUBSTNO('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1; %2 - %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry1.NEXT() = 0;
                        end;

                        trigger OnPreDataItem();
                        begin
                            if not ShowInternalInfo then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Sales Shipment Line"; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = CONST(Item));
                        column(SerialNo; SerialNo)
                        {
                        }
                        column(No_SalesShptLine; "No.")
                        {
                        }
                        column(Description_SalesShptLine; Description)
                        {
                        }
                        column(DocumentNo_SalesShptLine; "Document No.")
                        {
                        }
                        column(Qty_SalesShptLine; SalesLine_Qty)
                        {
                        }
                        column(UOM_SalesShptLine; "Unit of Measure Code")
                        {
                        }
                        column(Packing_Size; PackageSize)
                        {
                        }
                        column(PerUnit; "Qty. per Unit of Measure")
                        {
                        }
                        column(QtyShippedNotInvoiced_SalesShipmentLine; "Sales Shipment Line".Quantity)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            LinNo := "Line No.";

                            DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");
                            if DisplayAssemblyInformation then
                                AsmHeaderExists := AsmToShipmentExists(PostedAsmHeader);

                            //BC UPGRADE ATHUKS01<< Drink IT code
                            //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                            // FreeReasonDesc := '';
                            // if "Free Item" then
                            //     if FreeReasonCode.GET("Free Reason Code") then
                            //         FreeReasonDesc := FreeReasonCode.Description
                            //     else
                            //         FreeReasonDesc := 'Free';
                            // if ("Item Charge Type" = "Item Charge Type"::Deposit) and ("Empty Goods Item No." <> '') then begin
                            //     //<<MSF

                            //     if EmptyDetailsExists() then begin
                            //         //<<Empty Goods Details
                            //         TempSalesShptLine.RESET();
                            //         TempSalesShptLine.SETRANGE("Document No.", "Document No.");
                            //         TempSalesShptLine.SETFILTER("Empty Goods Item No.", '%1', "Empty Goods Item No.");
                            //         TempSalesShptLine.SETRANGE("Item Charge Type", "Item Charge Type");
                            //         if not TempSalesShptLine.FINDSET() then begin
                            //             TempSalesShptLine.INIT();
                            //             TempSalesShptLine := "Sales Shipment Line";
                            //             TempSalesShptLine.Quantity := 0;  //Qty Shipped
                            //             TempSalesShptLine."Quantity (Base)" := 0;  //Qty Returned
                            //             TempSalesShptLine.Amount := 0;  //Value Shipped
                            //             TempSalesShptLine."Amount Including VAT" := 0;  //Value Returned
                            //             TempSalesShptLine."Line Amount" := 0;  //Deposit
                            //             TempSalesShptLine."Gross Weight" := 0;
                            //             TempSalesShptLine."Net Weight" := 0;
                            //             if Quantity > 0 then begin
                            //                 TempSalesShptLine.Quantity := Quantity;
                            //                 TempSalesShptLine.Amount := "Line Amount";
                            //             end else begin
                            //                 TempSalesShptLine."Quantity (Base)" := -Quantity;
                            //                 TempSalesShptLine."Amount Including VAT" := -"Line Amount";
                            //             end;
                            //             TempSalesShptLine."Line Amount" := "Line Amount";
                            //             if Item.GET("Sales Shipment Line"."Empty Goods Item No.") then
                            //                 TempSalesShptLine.Description := Item.Description;
                            //             TempSalesShptLine.INSERT();
                            //         end else begin
                            //             if Quantity > 0 then begin
                            //                 TempSalesShptLine.Quantity += Quantity;
                            //                 TempSalesShptLine.Amount += "Line Amount";
                            //             end else begin
                            //                 TempSalesShptLine."Quantity (Base)" += -Quantity;
                            //                 TempSalesShptLine."Amount Including VAT" += -"Line Amount";
                            //             end;
                            //             TempSalesShptLine."Line Amount" += "Line Amount";
                            //             TempSalesShptLine.MODIFY();
                            //         end;
                            //     end;
                            // end;
                            // //>>Empty Goods Details

                            // LineQtyinHL := 0;
                            // if Type = Type::Item then begin
                            //     if Quantity = 0 then
                            //         CurrReport.SKIP();
                            //     //IF Item.GET("No.") THEN BEGIN
                            //     //  Item.CALCFIELDS("As Empty Good");
                            //     //  IF Item."As Empty Good" THEN
                            //     //    CurrReport.SKIP;
                            //     //END;

                            //     LineQtyinHL := Quantity * "Unit Volume HL";
                            // end;
                            //>>DITW17.00.02 RPG DIT-770 #235
                            //BC UPGRADE ATHUKS01>> Drink IT code 

                            //PackageSize := '';
                            PerUnit := 0;
                            /*
                            IF Type = Type::Item THEN BEGIN
                              ItemUnitofMeasure.RESET;
                              ItemUnitofMeasure.SETRANGE("Item No.","No.");
                              ItemUnitofMeasure.SETRANGE(Code,"Unit of Measure Code");
                              IF ItemUnitofMeasure.FINDSET THEN BEGIN
                               PackageSize:= FORMAT(ItemUnitofMeasure."Qty. per Unit of Measure") + ' '+ ItemUnitofMeasure."Unit of Weight";
                               PerUnit := ItemUnitofMeasure."Qty. per Unit of Measure"
                              END;
                            END;
                            */

                            if Type = Type::Item then begin
                                PackageSize := '';
                                ItemAttributeValueMapping.SETRANGE("Table ID", DATABASE::Item);
                                ItemAttributeValueMapping.SETRANGE("No.", "No.");
                                ItemAttributeValueMapping.SETRANGE("Item Attribute ID", 9);
                                if ItemAttributeValueMapping.FINDFIRST() then
                                    if ItemAttributeValue.GET(9, ItemAttributeValueMapping."Item Attribute Value ID") then
                                        PackageSize := ItemAttributeValue."Description FND";
                            end;


                            SalesLine.RESET();
                            SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                            SalesLine.SETRANGE("Document No.", "Order No.");
                            SalesLine.SETRANGE("No.", "No.");
                            if SalesLine.FINDFIRST() then
                                SalesLine_Qty := SalesLine.Quantity
                            else
                                SalesLine_Qty := "Sales Shipment Line".Quantity;
                            //HEI.01>>
                            if ItemRec.GET("Sales Shipment Line"."No.") then begin
                                if ItemRec."Item Category Code" = '16' then
                                    ItemLedgerEntry.RESET();
                                ItemLedgerEntry.SETRANGE("Document No.", "Sales Shipment Line"."Document No.");
                                ItemLedgerEntry.SETRANGE("Item No.", "Sales Shipment Line"."No.");
                                if ItemLedgerEntry.FINDFIRST() then
                                    SerialNo := ItemLedgerEntry."Serial No.";
                            end;
                            //HEI.01>>

                        end;

                        trigger OnPostDataItem();
                        begin
                            // Item Tracking:
                            //BC UPGRADE ATHUKS01>> Drink IT Code 
                            //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                            //<<Empty Goods Details
                            // TempSalesShptLine.RESET();
                            // if TempSalesShptLine.FINDSET() then
                            //     repeat
                            //         TempSalesShptLine."Unit Volume" := TempSalesShptLine.Quantity - TempSalesShptLine."Quantity (Base)";  //Deposit Difference
                            //         TempSalesShptLine.MODIFY();
                            //     until TempSalesShptLine.NEXT() = 0;
                            //>>Empty Goods Details
                            //>>DITW17.00.02 RPG DIT-770 #235
                            //BC UPGRADE ATHUKS01<<  Drink IT Code
                        end;

                        trigger OnPreDataItem();
                        begin
                            MoreLines := FIND('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) do
                                MoreLines := NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(Comments; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(Comment; TempCommentLine.Comment)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                TempCommentLine.FINDFIRST()
                            else
                                TempCommentLine.NEXT();
                        end;

                        trigger OnPreDataItem();
                        begin
                            TempCommentLine.RESET();
                            SETRANGE(Number, 1, TempCommentLine.COUNT);
                        end;
                    }

                    trigger OnPreDataItem();
                    begin
                        // Item Tracking:
                        if ShowLotSN then begin
                            TrackingSpecCount := 0;
                            OldRefNo := 0;
                            ShowGroup := false;
                        end;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then begin
                        CopyText := Text001;
                        OutputNo += 1;
                    end;
                    // CurrReport.PAGENO := 1;  //BC UPGRADE ATHUKS01
                    TotalQty := 0;
                    // Item Tracking
                    //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                    //TempSalesShptLine.DELETEALL();BC UPGRADE ATHUKS01
                    //>>DITW17.00.02 RPG DIT-770 #235
                end;

                trigger OnPostDataItem();
                begin
                    if not CurrReport.PREVIEW then
                        ShptCountPrinted.RUN("Sales Shipment Header");
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := 1 + ABS(NoOfCopies);
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                //BC UPGRADE ATHUKS01>>LanguageMgt
                //CurrReport.LANGUAGE := LanguageR.GetLanguageID("Language Code");
                CurrReport.LANGUAGE := LanguageMgt.GetLanguageId("Language Code");
                //BC UPGRADE ATHUKS01<<LanguageMgt

                if RespCenter.GET("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");
                //BC UPGRADE ATHUKS01>> Drink IT code
                //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                // BarcodeValueLeft := '';
                // BarcodeValueRight := '';
                // BarcodeValueCenter := '';
                // case CompanyInfo."Barcode Position on Documents" of
                //     CompanyInfo."Barcode Position on Documents"::"No Barcode":
                //         ;
                //     CompanyInfo."Barcode Position on Documents"::Left:
                //         BarcodeValueLeft := "No.";
                //     CompanyInfo."Barcode Position on Documents"::Center:
                //         BarcodeValueCenter := "No.";
                //     CompanyInfo."Barcode Position on Documents"::Right:
                //         BarcodeValueRight := "No.";
                // end;
                //>>DITW17.00.02 RPG DIT-770 #235
                //BC UPGRADE ATHUKS01<< Drink IT code

                if "Salesperson Code" = '' then begin
                    SalesPurchPerson.INIT();
                    SalesPersonText := '';
                end else begin
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
                end;
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := FIELDCAPTION("Your Reference");
                FormatAddr.SalesShptShipTo(ShipToAddr, "Sales Shipment Header");
                //BC UPGRADE ATHUKS01>>
                //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                //IF ShipToAddr[8] = '' THEN
                //  ShipToAddr[8] := FIELDCAPTION("Ship-to Address Key No.") + ' ' + "Ship-to Address Key No."
                //ELSE
                //  ShiptoAddrKeyNo := FIELDCAPTION("Ship-to Address Key No.") + ' ' + "Ship-to Address Key No.";
                //COMPRESSARRAY(ShipToAddr);

                //<<DITW17.00.02 AT 07/01/2014 DIT-770 #235
                //ShiptoAddrKeyNo := FIELDCAPTION("Ship-to Address Key No.") + ' ' + "Ship-to Address Key No.";
                //>>DITW17.00.02 AT 07/01/2014 DIT-770 #235
                //>>DITW17.00.02 RPG DIT-770 #235

                // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
                //FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, "Sales Shipment Header");
                // >>DITW110.00.08 DDR NRQ#0
                // ShowCustAddr := "Bill-to Customer No." <> "Sell-to Customer No.";
                // for i := 1 to ARRAYLEN(CustAddr) do
                //     if CustAddr[i] <> ShipToAddr[i] then
                //         ShowCustAddr := true;

                //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                //BC UPGRADE ATHUKS01<<
                SelltoContactPhoneNo := '';
                if not Contact.GET("Sell-to Contact No.") then
                    CLEAR(Contact);
                SelltoContactPhoneNo := Contact."Phone No.";

                //BC UPGRADE ATHUKS01<< Drink IT code.
                //UOMEquivalent1Caption := STRSUBSTNO(UOMEquivalent1lbl, WhseSetup."Shortcut Unit of Measure1 Code");
                // UOMEquivalent2Caption := STRSUBSTNO(UOMEquivalent2lbl, WhseSetup."Shortcut Unit of Measure2 Code");
                //UOMEquivalent3Caption := STRSUBSTNO(UOMEquivalent3lbl, WhseSetup."Shortcut Unit of Measure3 Code");
                //<<DITW18.00.06 MSF 08/09/2015 DIT-770 #1533
                // if not SelltoCust.GET("Sell-to Customer No.") then
                //   CLEAR(SelltoCust);
                //>>DITW18.00.06 MSF 08/09/2015 DIT-770 #1533
                //BC UPGRADE ATHUKS01>> Drink  IT Code.
                GrossWt := 0;
                NetWt := 0;
                TotalQtyinHL := 0;
                UOMEquivalent1 := 0;
                UOMEquivalent2 := 0;
                UOMEquivalent3 := 0;

                SalesShptLine.RESET();
                SalesShptLine.SETRANGE("Document No.", "No.");
                SalesShptLine.SETRANGE(Type, SalesShptLine.Type::Item);
                if SalesShptLine.FINDSET() then
                    repeat
                        if SalesShptLine.Quantity > 0 then begin
                            GrossWt += SalesShptLine."Gross Weight" * SalesShptLine."Quantity (Base)";
                            NetWt += SalesShptLine."Net Weight" * SalesShptLine."Quantity (Base)";
                            //UomQtyCodeMgt.SalesShptLineCalcShortcuts(SalesShptLine,ShortcutQtyUomValue,SalesShptLine.FIELDNO("Quantity (Base)"));

                            //<<NEw
                            ShourtUnitofmeasureFilter := WhseSetup."Short Unit of Meas2 Filt FND";
                            SalesShipmentLine1.RESET();
                            SalesShipmentLine1.SETRANGE("Document No.", SalesShptLine."Document No.");
                            SalesShipmentLine1.SETRANGE("No.", SalesShptLine."No.");
                            SalesShipmentLine1.SETFILTER("Unit of Measure Code", ShourtUnitofmeasureFilter);
                            if SalesShipmentLine1.FINDFIRST() then begin
                                //UOMEquivalent1 += SalesShptLine."Quantity (Base)";
                                UOMEquivalent2 += SalesShptLine.Quantity;
                            end;
                            //>>New

                            //  IF WhseSetup."Shortcut Unit of Measure1 Code" = SalesShptLine."Unit of Measure Code" THEN
                            UOMEquivalent1 += SalesShptLine."Quantity (Base)";
                            // IF WhseSetup."Shortcut Unit of Measure2 Code" = SalesShptLine."Unit of Measure Code" THEN
                            //UOMEquivalent2 += SalesShptLine.Quantity;
                            //IF WhseSetup."Shortcut Unit of Measure3 Code" = SalesShptLine."Unit of Measure Code" THEN
                            //UOMEquivalent3 += SalesShptLine."Quantity (Base)";

                            //BC UPGRADE ATHUKS01>> Drink IT Field
                            //HEI.01>>
                            //ShourtUnitofmeasureFilter := WhseSetup."Shortcut Unit of Measure1 Code";//BC UPGRADE ATHUKS01 Drink  IT field.
                            // SalesShipmentLine1.RESET();
                            // SalesShipmentLine1.SETRANGE("Document No.", SalesShptLine."Document No.");
                            // SalesShipmentLine1.SETRANGE("Unit of Measure Code", ShourtUnitofmeasureFilter);
                            // if SalesShipmentLine1.FINDSET() then
                            //     repeat
                            //         TotalIndvUnits1 += SalesShipmentLine1.Quantity;
                            //     until SalesShipmentLine1.NEXT() = 0;


                            //                            if TotalIndvUnits = 0 then
                            //                                TotalIndvUnits := TotalIndvUnits1; 
                            //BC UPGRADE ATHUKS01<< Drink IT Field     

                            ShourtUnitofmeasureFilter := WhseSetup."Short Unit of Meas2 Filt FND";
                            SalesShipmentLine1.RESET();
                            SalesShipmentLine1.SETRANGE("Document No.", SalesShptLine."Document No.");
                            SalesShipmentLine1.SETFILTER("Unit of Measure Code", ShourtUnitofmeasureFilter);
                            if SalesShipmentLine1.FINDSET() then
                                repeat
                                    TotalCases1 += SalesShipmentLine1.Quantity;
                                until SalesShipmentLine1.NEXT() = 0;


                            if TotalCases = 0 then
                                TotalCases := TotalCases1;
                            // BC UPGRADE ATHUKS01 >> Drink  IT field(Shortcut Unit of Measure3 Code).     
                            // ShourtUnitofmeasureFilter := WhseSetup."Shortcut Unit of Measure3 Code";//
                            // SalesShipmentLine1.RESET();
                            // SalesShipmentLine1.SETRANGE("Document No.", SalesShptLine."Document No.");
                            // SalesShipmentLine1.SETFILTER("Unit of Measure Code", ShourtUnitofmeasureFilter);
                            // if SalesShipmentLine1.FINDFIRST() then
                            //     repeat
                            //         TotalBarrels1 += SalesShipmentLine1.Quantity;
                            //     until SalesShipmentLine1.NEXT() = 0;


                            // if TotalBarrels = 0 then
                            //     TotalBarrels := TotalBarrels1;
                            // BC UPGRADE ATHUKS01 << Drink  IT field(Shortcut Unit of Measure3 Code)

                            ShourtUnitofmeasureFilter := WhseSetup."Shortcut Unit of Meas4Code FND";
                            SalesShipmentLine1.RESET();
                            SalesShipmentLine1.SETRANGE("Document No.", SalesShptLine."Document No.");
                            SalesShipmentLine1.SETFILTER("Unit of Measure Code", ShourtUnitofmeasureFilter);
                            if SalesShipmentLine1.FINDFIRST() then
                                repeat
                                    TotalPallets1 += SalesShipmentLine1.Quantity;
                                until SalesShipmentLine1.NEXT() = 0;


                            if TotalPallets = 0 then
                                TotalPallets := TotalPallets1;
                            //HEI.01<<
                        end;
                    //TotalQtyinHL += SalesShptLine.Quantity * SalesShptLine."Unit Volume HL";//BC UPGRADE ATHUKS01 Drink  IT field.
                    until SalesShptLine.NEXT() = 0;

                EmptyDetailsExists := false;
                //BC UPGRADE ATHUKS01<< Drink IT code
                //<<DITW18.00.06 MSF 08/09/2015 DIT-770 #1533
                // if (SelltoCust."Empty Goods Statement On" = SelltoCust."Empty Goods Statement On"::"Delivery Note") or
                //  (SelltoCust."Empty Goods Statement On" = SelltoCust."Empty Goods Statement On"::"Invoice + Delivery Note") then begin
                //>>DITW18.00.06 MSF 08/09/2015 DIT-770 #1533
                // SalesShptLine.RESET();
                // SalesShptLine.SETRANGE("Document No.", "No.");
                // SalesShptLine.SETRANGE(Type, SalesShptLine.Type::"Charge (Item)");
                // SalesShptLine.SETFILTER("Empty Goods Item No.", '<>%1', '');
                // SalesShptLine.SETRANGE("Item Charge Type", SalesShptLine."Item Charge Type"::Deposit);
                // if not SalesShptLine.ISEMPTY then
                //     EmptyDetailsExists := true;
                //<<DITW18.00.06 MSF 08/09/2015 DIT-770 #1533
                //end;
                //>>DITW18.00.06 MSF 08/09/2015 DIT-770 #1533
                //TempCommentLine.DELETEALL();
                //CommentLineNo := 10000;
                /*
                CommentLine.RESET;
                CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::"Countries/Region");
                CommentLine.SETRANGE("No.","Sell-to Country/Region Code");
                CommentLine.SETRANGE("Print on Shipment",TRUE);
                IF CommentLine.FINDSET THEN
                  REPEAT
                    InsertCommentLine(CommentLine.Comment);
                  UNTIL CommentLine.NEXT = 0;
                */
                // CommentLine.RESET();
                // CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Customer);
                // CommentLine.SETRANGE("No.", "Sell-to Customer No.");
                // CommentLine.SETRANGE("Print on Shipment", true);
                // if CommentLine.FINDSET() then
                //     repeat
                //         InsertCommentLine(CommentLine.Comment);
                //     until CommentLine.NEXT() = 0;

                // SalesCommentLine.RESET();
                // SalesCommentLine.SETRANGE("Document Type", SalesCommentLine."Document Type"::Order);
                // //SalesCommentLine.SETRANGE("No.","No.");
                // SalesCommentLine.SETRANGE("No.", "Sales Shipment Header"."Order No.");
                // //SalesCommentLine.SETRANGE("Print on Shipment",TRUE);
                // SalesCommentLine.SETRANGE("Print on Delivery Note", true);

                // if SalesCommentLine.FINDSET() then
                //     repeat
                //         InsertCommentLine(SalesCommentLine.Comment);
                //     until SalesCommentLine.NEXT() = 0;

                // if "Delivery Time 1 To" <> 000000T then
                //     DeliveryTime1 := FORMAT("Delivery Time 1 From") + ' to ' + FORMAT("Delivery Time 1 To")
                // else
                //     DeliveryTime1 := FORMAT("Delivery Time 1 From");

                // if "Delivery Time 2 To" <> 000000T then
                //     DeliveryTime2 := FORMAT("Delivery Time 2 From") + ' to ' + FORMAT("Delivery Time 2 To")
                // else
                //     DeliveryTime2 := FORMAT("Delivery Time 2 From");
                //>>DITW17.00.02 RPG DIT-770 #235


                //<<DITW17.10.05 MSF 06/10/2014 DIT-770 #943
                // if ShowLotSN then begin
                //     ItemTrackingMgt.SetRetrieveAsmItemTracking(true);
                //     TrackingSpecCount := ItemTrackingMgt.RetrieveDocumentItemTracking(TrackingSpecBuffer, "Sales Shipment Header"."No.",
                //          DATABASE::"Sales Shipment Header", 0);
                //     ItemTrackingMgt.SetRetrieveAsmItemTracking(false);
                // end;
                //>>DITW17.10.05 MSF 06/10/2014 DIT-770 #943
                //BC UPGRADE ATHUKS01>> Drink IT code


                if LogInteraction then
                    if not CurrReport.PREVIEW then
                        SegManagement.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                          "Campaign No.", "Posting Description", '');

                //NAIKH01
                if CustInvoiceTo.GET("Sales Shipment Header"."Bill-to Customer No.") then begin
                    CustBillName := CustInvoiceTo.Name;
                    CustAddressBill := CustInvoiceTo.Address;
                    CustAddressBill1 := CustInvoiceTo."Post Code";
                    CustAddressBill2 := CustInvoiceTo.City + '  ' + CustInvoiceTo."Country/Region Code";
                end;

                if CustShipTo.GET("Sales Shipment Header"."Sell-to Customer No.") then begin
                    CustShipName := CustShipTo.Name;
                    CustAddressShip := CustShipTo.Address;
                    CustAddressShip1 := CustShipTo."Post Code";
                    CustAddressShip2 := CustShipTo.City + '  ' + CustShipTo."Country/Region Code";
                end;

                PaymentTerms.GET("Payment Terms Code");
                ShipmentMethod.GET("Shipment Method Code");
                //NAIKH01>>

            end;
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

        trigger OnInit();
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage();
        begin
            InitLogInteraction();
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
        Shiptolbl = 'Ship To:'; Invoicetolbl = 'Invoice To:'; SoNolbl = 'SO No.'; SoDate = 'SO Date'; CustomerPOlbl = 'Customer PO'; DeliveryMethodlbl = 'Delivery Method'; PaymentTermlbl = 'Payment Term'; RequestedDatelbl = 'Requested Date'; CustomerCodelbl = 'Customer Code'; ToalQuantitiesunitslbl = 'Total Quantities Units'; ToatlCases = 'Total Cases'; Commentslbl = 'Comments :'; Returnlbl = 'Returns'; KegsnCylinederslbl = 'Kegs and Cylinders'; NonProductItemslbl = 'Non Product Items'; Driverlbl = 'Driver'; CustomerSiglbl = 'Customer Signature'; TotalIndvUnitslbl = 'Total Indv. Units:'; TotalCaseslbl = 'Total Cases:'; TotalPalletslbl = 'Total Pallets:'; TotalBarrelslbl = 'Total Barrels:';
    }

    trigger OnInitReport();
    begin
        CompanyInfo.GET();
        SalesSetup.GET();
        WhseSetup.GET();

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo3.GET();
                    CompanyInfo3.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.GET();
                    CompanyInfo1.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.GET();
                    CompanyInfo2.CALCFIELDS(Picture);
                end;
        end;
        //BC UPGRADE ATHUKS01<< Drink IT code 
        //<<DITW17.00.02 RPG 07/11/2013 DIT-770 #235
        // CompanyInfo.GET();
        // AddressLeft() := false;
        // AddressRight() := false;
        // case CompanyInfo."Address Position on Documents" of
        //     CompanyInfo."Address Position on Documents"::Left:
        //         AddressLeft := true;
        //     CompanyInfo."Address Position on Documents"::Right:
        //         AddressRight := true;
        // end;
        //>>DITW17.00.02 RPG DIT-770 #235
        //BC UPGRADE ATHUKS01>> Drink IT code
    end;

    trigger OnPreReport();
    begin
        /*
        IF NOT CurrReport.USEREQUESTPAGE THEN
          InitLogInteraction;
        AsmHeaderExists := FALSE;

        */

    end;

    var
        Text000: TextConst ENU = 'Salesperson', FRA = 'Vendeur';
        Text001: TextConst ENU = 'COPY', FRA = 'COPIE';
        Text002: TextConst ENU = 'Delivery Note %1', FRA = 'Note de livraison %1';
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        LanguageR: Record Language;
        LanguageMgt: Codeunit Language;
        TrackingSpecBuffer: Record "Tracking Specification" temporary;
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        ShptCountPrinted: Codeunit "Sales Shpt.-Printed";
        SegManagement: Codeunit SegManagement;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        RespCenter: Record "Responsibility Center";
        ItemTrackingAppendix: Report "Item Tracking Appendix";
        CustAddr: array[8] of Text[60];
        ShipToAddr: array[8] of Text[60];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[20];
        ReferenceText: Text[80];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        OutputNo: Integer;
        NoOfLoops: Integer;
        TrackingSpecCount: Integer;
        OldRefNo: Integer;
        OldNo: Code[20];
        CopyText: Text[30];
        ShowCustAddr: Boolean;
        i: Integer;
        FormatAddr: Codeunit "Format Address";
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        ShowCorrectionLines: Boolean;
        ShowLotSN: Boolean;
        ShowTotal: Boolean;
        ShowGroup: Boolean;
        TotalQty: Decimal;

        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmHeaderExists: Boolean;
        LinNo: Integer;
        ItemTrackingAppendixCaptionLbl: TextConst ENU = 'Item Tracking - Appendix', FRA = 'Traçabilité - Annexe';
        PhoneNoCaptionLbl: TextConst ENU = 'Phone No.', FRA = 'N° téléphone';
        VATRegNoCaptionLbl: TextConst ENU = 'VAT Reg. No.', FRA = 'N° enreg. TVA';
        GiroNoCaptionLbl: TextConst ENU = 'Giro No.', FRA = 'N° CCP';
        BankNameCaptionLbl: TextConst ENU = 'Bank', FRA = 'Banque';
        BankAccNoCaptionLbl: TextConst ENU = 'Account No.', FRA = 'N° compte';
        ShipmentNoCaptionLbl: TextConst ENU = 'Shipment No.', FRA = 'N° expédition';
        ShipmentDateCaptionLbl: TextConst ENU = 'Shipment Date', FRA = 'Date d''expédition';
        HomePageCaptionLbl: TextConst ENU = 'Home Page', FRA = 'Page d''accueil';
        EmailCaptionLbl: TextConst ENU = 'E-Mail', FRA = 'E-mail';
        DocumentDateCaptionLbl: TextConst ENU = 'Document Date', FRA = 'Date document';
        HeaderDimensionsCaptionLbl: TextConst ENU = 'Header Dimensions', FRA = 'Analytique en-tête';
        LineDimensionsCaptionLbl: TextConst ENU = 'Line Dimensions', FRA = 'Analytique ligne';
        BilltoAddressCaptionLbl: TextConst ENU = 'Bill-to Address', FRA = 'Adresse facturation';
        QuantityCaptionLbl: TextConst ENU = 'Quantity', FRA = 'Quantité';
        SerialNoCaptionLbl: TextConst ENU = 'Serial No.', FRA = 'N° de série';
        LotNoCaptionLbl: TextConst ENU = 'Lot No.', FRA = 'N° lot';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        NoCaptionLbl: TextConst ENU = 'No.', FRA = 'N°';
        BarcodeValueLeft: Code[20];
        BarcodeValueRight: Code[20];
        BarcodeValueCenter: Code[20];
        Contact: Record Contact;
        SelltoCust: Record Customer;
        ShiptoAddrCust: Record "Ship-to Address";
        //FreeReasonCode: Record "Free Reason Code";
        FreeReasonDesc: Text[50];
        GrossWt: Decimal;
        NetWt: Decimal;
        TotalQtyinHL: Decimal;
        CommentLine: Record "Comment Line";
        SalesCommentLine: Record "Sales Comment Line";
        TempCommentLine: Record "Comment Line" temporary;
        CommentLineNo: Integer;
        LineQtyinHL: Decimal;
        Item: Record Item;
        EmptyDetailsExists: Boolean;
        SalesShptLine: Record "Sales Shipment Line";
        TempSalesShptLine: Record "Sales Shipment Line" temporary;
        SelltoContactPhoneNo: Text[30];
        ExtDocNoCaptionLbl: TextConst ENU = 'External Document No.', FRA = 'N° document externe';
        SellToAddrCaptionLbl: TextConst ENU = 'Order Address', FRA = 'Adresse commande';
        UOMCaptionLbl: TextConst ENU = 'UOM', FRA = 'UM';
        TotalHLCaptionLbl: TextConst ENU = 'Total HL', FRA = 'Total HL';
        DepositQtyShippedCaptionLbl: TextConst ENU = 'Qty Shipped', FRA = 'Qté expédié';
        DepositQtyReturnedCaptionLbl: TextConst ENU = 'Qty Returned', FRA = 'Quantité retournée';
        DepositDifferenceCaptionLbl: TextConst ENU = 'Difference', FRA = 'Différence';
        EmptyGoodsDetailsCaptionLbl: TextConst ENU = 'Empty Goods Detail', FRA = 'Détail marchandises vides';
        TotalQtyInHLCaptionLbl: TextConst ENU = 'Quantity HL', FRA = 'Quantité HL';
        CompanyInfoFaxNoCaptionLbl: TextConst ENU = 'Fax', FRA = 'Fax';
        CompanyInfoIBANCaptionLbl: TextConst ENU = 'IBAN', FRA = 'IBAN';
        CompanyInfoSwiftCodeCaptionLbl: TextConst ENU = 'SWIFT Code', FRA = 'Code SWIFT';
        SelltoContactPhNoCaptionLbl: TextConst ENU = 'Sell-to Contact Phone No.', FRA = 'N° téléphone contact donneur d''ordre';
        ShippingAgentCodeCaptionLbl: TextConst ENU = 'Shipping Agent', FRA = 'Transporteur';
        Driver1CaptionLbl: TextConst ENU = 'Driver 1', FRA = 'Chauffeur 1';
        Driver2CaptionLbl: TextConst ENU = 'Driver 2', FRA = 'CHauffeur 2';
        TruckCaptionLbl: TextConst ENU = 'Truck', FRA = 'Camion';
        LocationCaptionLbl: TextConst ENU = 'Location', FRA = 'Magasin';
        ArrivalDateTimeCaptionLbl: TextConst ENU = 'Arrival Date/Time', FRA = 'Arrivée Date-Heure';
        DepartureDateTimeCaptionLbl: TextConst ENU = 'Departure Date/Time', FRA = 'Départ Date / Heure';
        BreakStartDateTimeCaptionLbl: TextConst ENU = 'Break Start Date/Time', FRA = 'Début de la pause  Date / Heure';
        BreakEndDateTimeCaptionLbl: TextConst ENU = 'Break End Date/Time', FRA = 'Fin de la pause Date / Heure';
        DriverNameCaptionLbl: TextConst ENU = 'Driver Name', FRA = 'Nom chauffeur';
        DriverName2CaptionLbl: TextConst ENU = 'Driver Name 2', FRA = 'Nom chauffeur 2';
        DriverSignatureCaptionLbl: TextConst ENU = 'Driver Signature', FRA = 'Signature chauffeur';
        Driver2SignatureCaptionLbl: TextConst ENU = 'Driver 2 Signature', FRA = 'Signature chauffeur 2';
        DriverCommentsCaptionLbl: TextConst ENU = 'Driver Comments', FRA = 'Commentaires chauffeur';
        Driver2CommentsCaptionLbl: TextConst ENU = 'Driver 2 Comments', FRA = 'Commentaires chauffeur 2';
        CustomerSignatureCaptionLbl: TextConst ENU = 'Customer signature for goods receipt', FRA = 'Signature du client pour la réception des marchandises';
        ShiptoAddrCaptionLbl: TextConst ENU = 'Ship-to Address', FRA = 'Adresse destinataire';
        DeliveryTime1: Text[100];
        DeliveryTime2: Text[100];
        ShiptoAddrKeyNo: Text[100];
        DeliveryTime1CaptionLbl: TextConst ENU = 'Delivery Time 1', FRA = 'Heure de livraison 1';
        DeliveryTime2CaptionLbl: TextConst ENU = 'Delivery Time 2', FRA = 'Heure de livraison 2';
        AddressLeft: Boolean;
        AddressRight: Boolean;
        QtyCaptionLbl: TextConst ENU = 'QTY', FRA = 'Qté';
        //UomQtyCodeMgt: Codeunit "UOM Qty.Code Mgt.";
        ShortcutQtyUomValue: array[3] of Decimal;
        UOMEquivalent1: Decimal;
        UOMEquivalent2: Decimal;
        UOMEquivalent3: Decimal;
        WhseSetup: Record "Warehouse Setup";
        UOMEquivalent1Caption: Text[50];
        UOMEquivalent2Caption: Text[50];
        UOMEquivalent3Caption: Text[50];
        UOMEquivalent1lbl: TextConst ENU = 'Quantity (Base) %1', FRA = 'Quantité (Base) %1';
        UOMEquivalent2lbl: TextConst ENU = 'Quantity (Base) %1', FRA = 'Quantité (Base) %1';
        UOMEquivalent3lbl: TextConst ENU = 'Quantity (Base) %1', FRA = 'Quantité (Base) %1';
        TrailerCaptionLbl: TextConst ENU = 'Trailer', FRA = 'Remorque';
        ItemUnitofMeasure: Record "Item Unit of Measure";
        CustShipTo: Record Customer;
        CustInvoiceTo: Record Customer;
        CustBillName: Text;
        CustShipName: Text;
        CustAddressBill: Text;
        CustAddressBill1: Text;
        CustAddressBill2: Text;
        CustAddressShip: Text;
        CustAddressShip1: Text;
        CustAddressShip2: Text;
        PaymentTerms: Record "Payment Terms";
        ShipmentMethod: Record "Shipment Method";
        PackageSize: Text;
        PerUnit: Decimal;
        SalesLine: Record "Sales Line";
        SalesLine_Qty: Decimal;
        ShourtUnitofmeasureFilter: Text[100];
        SalesShipmentLine1: Record "Sales Shipment Line";
        ItemRec: Record Item;
        SerialNo: Text[30];
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalIndvUnits: Decimal;
        TotalIndvUnits1: Decimal;
        TotalCases: Decimal;
        TotalCases1: Decimal;
        TotalBarrels: Decimal;
        TotalBarrels1: Decimal;
        TotalPallets: Decimal;
        TotalPallets1: Decimal;
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        ItemAttributeValue: Record "Item Attribute Value";

    procedure InitLogInteraction();
    var
    enumvalue: Enum "Interaction Log Entry Document Type";
    begin
        //BC UPGRADE ATHUKS01>>
        // LogInteraction := SegManagement.FindInteractTmplCode(5) <> '';
        LogInteraction := SegManagement.FindInteractionTemplateCode(enumvalue::"Sales Shpt. Note") <> '';
        //BC UPGRADE ATHUKS01<< 
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean; NewShowLotSN: Boolean; DisplayAsmInfo: Boolean);
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        ShowCorrectionLines := NewShowCorrectionLines;
        ShowLotSN := NewShowLotSN;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10];
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.GET(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10];
    begin
        exit(PADSTR('', 2, ' '));
    end;

    procedure InsertCommentLine(Comment: Text[80]);
    begin
        //BC UPGRADE ATHUKS01>> CommentParmLengthIncre
        TempCommentLine.INIT();
        TempCommentLine."Line No." := CommentLineNo;
        TempCommentLine.Comment := Comment;
        TempCommentLine.INSERT();
        CommentLineNo += 10000;
    end;
}

