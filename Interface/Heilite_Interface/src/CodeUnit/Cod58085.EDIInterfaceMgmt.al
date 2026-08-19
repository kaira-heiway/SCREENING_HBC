codeunit 58085 "EDI Interface Mgmt."
{
    //BC Upgrade GUNREM01 Old ID-50104
    // version HEI.10

    // HEI.01 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 04.10.2019 - #new object
    // HEI.02 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 08.01.2020
    //   # line commented in CreateOrder function
    //   # new parameter 'ForceCreation' in functions: CreateOrder, ProcessSalesOrder
    //   # new code in function CreateOrder
    //   # new local variable 'ErrorLine' in CreateOrder function
    // HEI.03 CHG2026335 HT653 IBM GAVANM01 30.03.2020  #FDD_La Reunion_EDI_EDI Order
    //   # remove all validations linked to EDI Order field
    //   # shipment date to be equal to the posting date in CreateOrder function
    //   # if an item is blocked it continues searching a GTIN for an Item which is not blocked.
    // HEI.04 Defect #5447 IBM GAVANM01 28.04.2020  #code added
    // HEI.05 CHG2078592 IBM GAVANM01 08.09.2020 EDI Numbering issue
    //   # code changes and new local var NoSeriesRel in function CreateOrder()
    // HEI.06 CHG2269173 IBM COSTES04 04.12.2024 Management of EANs in EDI-SALESORDER interface
    //   # manage duplicates of barcodes
    // HEI.08 CHG2297549 HB4258 IBM ADHIKG01 15.05.2025 La Réunion-Improvement of EDI-SALEORDER interface code error message
    //   # Code added in CreateOrder function to handle the error when item is blocked
    // HEI.10 CHG2302895 IBM COSTES04 04.06.2025 EDI interface enhancement for non Sales UoM EANs
    //   # Create Sales line with Sales Unit Of Measure instead of EDI UOM

    //BC Upgrade GUNREM01 
    //# DIT fields and code commented.
    //# SMTP code blocked

    trigger OnRun();
    begin
    end;

    var
        EDIInterfaceSetupRead: Boolean;
        EDIInterfaceSetup: Record "EDI Interface Setup INT";
        Err001: Label 'The length of the field should be 6 chr!';

    procedure ProcessSalesOrder(InterfaceEntryHeader: Record "Interface Entry Header INT"; ForceCreation: Boolean);
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        DocumentType: Option "Order","Return Order";
    begin
        InterfaceEntryHeader.CALCFIELDS("Negative Line Exist");
        if InterfaceEntryHeader."Negative Line Exist" then begin
            CreateOrder(InterfaceEntryHeader, InterfaceEntryLine, DocumentType::Order, ForceCreation);
            CreateOrder(InterfaceEntryHeader, InterfaceEntryLine, DocumentType::"Return Order", ForceCreation)
        end else
            CreateOrder(InterfaceEntryHeader, InterfaceEntryLine, DocumentType::Order, ForceCreation);
    end;

    local procedure CreateOrder(InterfaceEntryHeader: Record "Interface Entry Header INT"; InterfaceEntryLine: Record "Interface Entry Line INT"; DocumentType: Option "Order","Return Order"; ForceCreation: Boolean);
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesHeader2: Record "Sales Header";
        SalesSetup: Record "Sales & Receivables Setup";
        Customer: Record Customer;
        Text001: Label 'Customer doesn''t exist (%1) in accounting group (%2)';
        Text002: Label 'Customer %1 is blocked for shipment (GLN: %2)';
        CalendarMngt: Codeunit "Calendar Management";
        SourceType: Option Company,Customer,Vendor,Location,"Shipping Agent",Service;
        ShipToAddress: Record "Ship-to Address";
        //  ItemCrossReference : Record "Item Cross Reference";
        ItemCrossReference: Record "Item Reference";//BC Upgrade GUNREM01 -Replaced Item Cross Reference
        Item: Record Item;
        Text003: Label 'Item %1 is blocked (GTIN: %2)';
        Text004: Label 'Item %1 does not exist. (GTIN: %2)';
        Text005: Label 'Cross Ref not found (GTIN:%1)';
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series"; //BC Upgrade GUNREM01 -Replaced NoSeriesManagement
        NoOfCrossRef: Integer;
        ItemNo: Code[20];
        Text006: Label 'GTIN: %1 is assigned to several articles.';
        Text007: TextConst ENU = 'Item %1 doesn''t have a Cross Ref. with Unit of Measure = Sales Unit of Measure set in Item Card';
        UnitofMeasure: Code[10];
        Text008: Label 'QTY: %1 / %2';
        ErrorLine: Boolean;
        DateForm: DateFormula;
        AllItemsBlocked: Boolean;
        Text009: Label 'All items are blocked.';
        NoSeriesRel: Record "No. Series Relationship";
        UnitOfMeasureCode: Code[10];
        ItemUOMEDI: Record "Item Unit of Measure";
        ItemUOM: Record "Item Unit of Measure";
        SalesHook101FDW: Codeunit SalesHook101FDW;//BC Upgrade VAMSIU01 Added
    begin
        GetEDIInterfaceSetup;
        GeneralLedgerSetup.GET;
        SalesSetup.GET;
        SalesSetup.TESTFIELD("EDI Nos. FND");

        //FIND Customer No. with GLN Code
        Customer.RESET;
        Customer.SETCURRENTKEY(GLN);
        Customer.SETRANGE(GLN, InterfaceEntryHeader."Bill-to Customer No.");
        if EDIInterfaceSetup."Accounting group filter" <> '' then
            Customer.SETFILTER("Account Group FND", EDIInterfaceSetup."Accounting group filter");
        if not Customer.FINDFIRST then
            ERROR(Text001, InterfaceEntryHeader."Bill-to Customer No.", EDIInterfaceSetup."Accounting group filter");

        if Customer.Blocked in [Customer.Blocked::All, Customer.Blocked::Ship] then
            ERROR(Text002, Customer."No.", InterfaceEntryHeader."Bill-to Customer No.");

        InterfaceEntryHeader.TESTFIELD("Message Type", '220');

        //check if exists the same document based on External Document No. and Customer No
        CheckSOExist(InterfaceEntryHeader."External Document No.", Customer."No.");

        SalesHeader.INIT;
        if DocumentType = DocumentType::Order then begin
            /* //<<HEI.05
            SalesHeader.VALIDATE("Document Type",SalesHeader."Document Type"::Order);
            SalesHeader.VALIDATE("No.",NoSeriesMgt.GetNextNo(SalesSetup."EDI Nos.",0D,TRUE));
            SalesHeader.VALIDATE("No. Series",SalesSetup."EDI Nos.");
            */ //>>HEI.05
               //<<HEI.05
            SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
            if NoSeriesRel.GET(SalesSetup."Order Nos.", SalesSetup."EDI Nos. FND") then begin
                SalesHeader."No. Series" := SalesSetup."EDI Nos. FND";
                SalesHeader."No." := NoSeriesMgt.GetNextNo(SalesSetup."EDI Nos. FND", 0D, true);
            end else begin
                SalesHeader.VALIDATE("No. Series", SalesSetup."EDI Nos. FND");
                SalesHeader.VALIDATE("No.", NoSeriesMgt.GetNextNo(SalesSetup."EDI Nos. FND", 0D, true));
            end;
            //>>HEI.05
        end else begin
            /*SalesHeader.VALIDATE("Document Type",SalesHeader."Document Type"::"Return Order");
            SalesHeader.VALIDATE("No.",'');
            SalesHeader2.RESET;
            //SalesHeader2.SETRANGE("External Document No.",OrtecKStoreInterfaceSetup."Sales Order Prefix" + InterfaceEntryHeader."Source No.");
            SalesHeader2.SETRANGE("External Document No.",InterfaceEntryHeader."External Document No.");
            SalesHeader2.SETRANGE("Document Type",SalesHeader2."Document Type"::Order);
            IF SalesHeader2.FINDFIRST THEN BEGIN
              SalesHeader."Link Sales Document Type" := SalesHeader."Link Sales Document Type"::Order;
              SalesHeader."Link Sales Document No." := SalesHeader2."No.";
            END;*/
        end;
        SalesHeader.INSERT(true);

        SalesHeader.VALIDATE("Sell-to Customer No.", Customer."No.");
        SalesHeader.VALIDATE("External Document No.", InterfaceEntryHeader."External Document No.");

        SalesHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
        SalesHeader.VALIDATE("Document Date", InterfaceEntryHeader."Posting Date");
        SalesHeader.VALIDATE("Requested Delivery Date", InterfaceEntryHeader."Posting Date");
        SalesHeader.VALIDATE("Order Date", InterfaceEntryHeader."Document Date");
        SalesHeader.VALIDATE("Ealiest delivery Date Time FND", InterfaceEntryHeader."Delivery Date");
        SalesHeader.VALIDATE("Latest Delivery Date Time FND", InterfaceEntryHeader."Latest Delivery Date Time");
        SalesHeader.VALIDATE("Pick Date Time FND", InterfaceEntryHeader."Pick Date Time");
        SalesHeader.VALIDATE("System Date Time FND", InterfaceEntryHeader."System Date Time");
        //SalesHeader.VALIDATE("Time/Date Received",CURRENTDATETIME);  //HEI.02

        //SalesHeader.VALIDATE("Location Code",InterfaceEntryHeader."Location Code");
        //SalesHeader.VALIDATE("Shipment Method Code",InterfaceEntryHeader."Shipment Method");
        /* //commented by HEI.03>>
        EVALUATE(DateForm,'<1D>');
        SalesHeader.VALIDATE("Shipment Date",CalendarMngt.CalcDateBOC2(FORMAT(DateForm),InterfaceEntryHeader."Posting Date",
                SourceType::Location,SalesHeader."Location Code",'',
                SourceType::"Shipping Agent",SalesHeader."Shipping Agent Code",SalesHeader."Shipping Agent Service Code",TRUE));
        */ //commented by HEI.03<<
        SalesHeader.VALIDATE("Shipment Date", InterfaceEntryHeader."Posting Date");   //HEI.03

        if InterfaceEntryHeader.Name <> '' then begin
            ShipToAddress.RESET;
            ShipToAddress.SETCURRENTKEY(GLN);
            ShipToAddress.SETRANGE(GLN, InterfaceEntryHeader.Name);
            ShipToAddress.SETRANGE("Customer No.", SalesHeader."Sell-to Customer No.");
            if ShipToAddress.FINDFIRST then
                SalesHeader.VALIDATE("Ship-to Code", ShipToAddress.Code);
        end;

        //IF GeneralLedgerSetup."LCY Code" <> InterfaceEntryHeader."Currency Code" THEN
        //  SalesHeader.VALIDATE("Currency Code",InterfaceEntryHeader."Currency Code");

        //SalesHeader.VALIDATE("Posting No.",SalesHeader."External Document No.");
        //SalesHeader.VALIDATE("Doc. Amount Incl. VAT",InterfaceEntryHeader.Amount);
        //SalesHeader.VALIDATE("Doc. Amount VAT",InterfaceEntryHeader."VAT Amount");
        //SalesHeader.VALIDATE("Vans Sales Route",TRUE);

        //SalesHeader.VALIDATE("Your Reference",InterfaceEntryHeader."Your Reference");
        //BC Upgrade GUNREM01 -DIT Fields >>
        // SalesHeader."Last changed User ID" := USERID;
        // SalesHeader."Last changed Date/time" := CURRENTDATETIME;
        //BC Upgrade GUNREM01 -DIT Fields <<
        InsertSalesComment(SalesHeader."No.", 0, '', InterfaceEntryHeader.DocumentURL);

        SalesHeader.MODIFY(true);

        //LineNo := 10000;
        InterfaceEntryLine.SETCURRENTKEY("Source Line No.");
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        /*IF DocumentType = DocumentType::Order THEN
          InterfaceEntryLine.SETFILTER(Quantity,'>%1',0)
        ELSE
          InterfaceEntryLine.SETFILTER(Quantity,'<%1',0);*/
        if InterfaceEntryLine.FINDSET then
            repeat
                ErrorLine := false;  //HEI.02
                CLEAR(UnitOfMeasureCode);//HEI.10
                SalesLine.INIT;
                SalesLine.VALIDATE("Document Type", SalesHeader."Document Type");
                SalesLine.VALIDATE("Document No.", SalesHeader."No.");
                SalesLine.VALIDATE("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
                SalesLine.VALIDATE("Line No.", 10000 * InterfaceEntryLine."Source Line No.");
                SalesLine.INSERT(true);

                SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                ItemCrossReference.RESET;
                //HEI.06>>
                //  ItemCrossReference.SETCURRENTKEY("Item No.", "Variant Code", "Unit of Measure", "Cross-Reference Type", "Cross-Reference Type No.", "Cross-Reference No.");
                ItemCrossReference.SETCURRENTKEY("Item No.", "Variant Code", "Unit of Measure", "Reference Type", "Reference Type No.", "Reference No."); //BC Upgrade GUNREM01 -Replaces cross reference fields

                ItemCrossReference.SETASCENDING("Item No.", false);
                //HEI.06<<
                //ItemCrossReference.SETRANGE("Cross-Reference Type",ItemCrossReference."Cross-Reference Type"::"Bar Code");
                //  ItemCrossReference.SETRANGE("Cross-Reference No.", InterfaceEntryLine."Cross Reference No.");
                ItemCrossReference.SETRANGE("Reference No.", InterfaceEntryLine."Cross Reference No.");//BC Upgrade GUNREM01 -Replaces cross reference fields
                ItemCrossReference.SETFILTER("EAN Category Code FND", '%1', 'HE');

                //HEI.04>>
                if ItemCrossReference.FINDSET then
                    repeat
                        if Item.GET(ItemCrossReference."Item No.") and not Item.Blocked then
                            ItemCrossReference.MARK(true);
                    until ItemCrossReference.NEXT = 0;

                ItemCrossReference.MARKEDONLY(true);
                if ItemCrossReference.COUNT <> 1 then
                    ItemCrossReference.MARKEDONLY(false);
                //HEI.04<<

                /*IF ItemCrossReference.FINDFIRST THEN BEGIN
                  IF Item.GET(ItemCrossReference."Item No.") THEN BEGIN
                    IF Item.Blocked THEN BEGIN
                      SalesLine.VALIDATE(Type,SalesLine.Type::" ");
                      SalesLine.Description := STRSUBSTNO(Text003,ItemCrossReference."Item No.",InterfaceEntryLine."Cross Reference No.");
                      SalesLine.MODIFY(TRUE);
                      ERROR(Text003,ItemCrossReference."Item No.",InterfaceEntryLine."Cross Reference No.");
                    END ELSE
                      SalesLine.VALIDATE("No.",ItemCrossReference."Item No.");
                  END ELSE BEGIN
                    SalesLine.VALIDATE(Type,SalesLine.Type::" ");
                    SalesLine.Description := STRSUBSTNO(Text004,ItemCrossReference."Item No.",InterfaceEntryLine."Cross Reference No.");
                    SalesLine.MODIFY(TRUE);
                    ERROR(Text004,ItemCrossReference."Item No.",InterfaceEntryLine."Cross Reference No.");
                  END;
                END ELSE BEGIN
                  SalesLine.VALIDATE(Type,SalesLine.Type::" ");
                  SalesLine.Description := STRSUBSTNO(Text005,InterfaceEntryLine."Cross Reference No.");
                  SalesLine.MODIFY(TRUE);
                  ERROR(Text005,InterfaceEntryLine."Cross Reference No.");
                END;*/

                case ItemCrossReference.COUNT of
                    0:
                        begin
                            if ForceCreation then begin  //HEI.02
                                SalesLine.VALIDATE(Type, SalesLine.Type::" ");
                                SalesLine.Description := COPYSTR(STRSUBSTNO(Text005, InterfaceEntryLine."Cross Reference No."), 1, 50);
                                SalesLine."Description 2" := STRSUBSTNO(Text008, InterfaceEntryLine.Quantity, COPYSTR(InterfaceEntryLine."E-Mail 2", 1, 40));  //HEI.02
                                SalesLine.MODIFY(true);
                                ErrorLine := true;  //HEI.02
                            end else  //HEI.02
                                ERROR(Text005, InterfaceEntryLine."Cross Reference No.");
                        end;
                    1:
                        if ItemCrossReference.FINDFIRST and Item.GET(ItemCrossReference."Item No.") then begin
                            if Item.Blocked then begin
                                if ForceCreation then begin  //HEI.02
                                    SalesLine.VALIDATE(Type, SalesLine.Type::" ");
                                    SalesLine.Description := COPYSTR(STRSUBSTNO(Text003, ItemCrossReference."Item No.", InterfaceEntryLine."Cross Reference No."), 1, 50);
                                    SalesLine."Description 2" := STRSUBSTNO(Text008, InterfaceEntryLine.Quantity, COPYSTR(InterfaceEntryLine."E-Mail 2", 1, 40));  //HEI.02
                                    SalesLine.MODIFY(true);
                                    ErrorLine := true;  //HEI.02
                                end else  //HEI.02
                                    ERROR(Text003, ItemCrossReference."Item No.", InterfaceEntryLine."Cross Reference No.");
                            end else begin  //HEI.08
                                SalesLine.VALIDATE("No.", ItemCrossReference."Item No.");
                                //HEI.10>>
                                //SalesLine.VALIDATE("Unit of Measure Code",ItemCrossReference."Unit of Measure");
                                SalesLine.VALIDATE("Unit of Measure Code", Item."Sales Unit of Measure");
                                if Item."Sales Unit of Measure" <> ItemCrossReference."Unit of Measure" then
                                    UnitOfMeasureCode := ItemCrossReference."Unit of Measure";
                                //HEI.10<<
                            end;  //HEI.08
                        end else begin
                            if ForceCreation then begin  //HEI.02
                                SalesLine.VALIDATE(Type, SalesLine.Type::" ");
                                SalesLine.Description := COPYSTR(STRSUBSTNO(Text004, ItemCrossReference."Item No.", InterfaceEntryLine."Cross Reference No."), 1, 50);
                                SalesLine."Description 2" := STRSUBSTNO(Text008, InterfaceEntryLine.Quantity, COPYSTR(InterfaceEntryLine."E-Mail 2", 1, 40));  //HEI.02
                                SalesLine.MODIFY(true);
                                ErrorLine := true;  //HEI.02
                            end else  //HEI.02
                                ERROR(Text004, ItemCrossReference."Item No.", InterfaceEntryLine."Cross Reference No.");
                        end;
                    else
                      /*IF ItemCrossReference.FINDFIRST AND Item.GET(ItemCrossReference."Item No.") THEN BEGIN
                        ItemNo := ItemCrossReference."Item No.";
                        REPEAT
                          IF ItemCrossReference."Item No." <> ItemNo THEN
                            ERROR(Text006,InterfaceEntryLine."Cross Reference No.");

                          IF ItemCrossReference."Unit of Measure" = Item."Sales Unit of Measure" THEN BEGIN
                            SalesLine.VALIDATE("No.",ItemCrossReference."Item No.");
                            SalesLine.VALIDATE("Unit of Measure Code",ItemCrossReference."Unit of Measure");
                            BREAK;
                          END;
                        UNTIL ItemCrossReference.NEXT = 0;
                        IF ItemCrossReference."Unit of Measure" <> Item."Sales Unit of Measure" THEN
                          ERROR(Text007,ItemCrossReference."Item No.");
                      END ELSE BEGIN
                        SalesLine.VALIDATE(Type,SalesLine.Type::" ");
                        SalesLine.Description := STRSUBSTNO(Text004,ItemCrossReference."Item No.",InterfaceEntryLine."Cross Reference No.");
                        SalesLine.MODIFY(TRUE);
                        ERROR(Text004,ItemCrossReference."Item No.",InterfaceEntryLine."Cross Reference No.");
                      END;*/

                      begin
                        CLEAR(ItemNo);
                        CLEAR(UnitofMeasure);
                        AllItemsBlocked := true;
                        if ItemCrossReference.FINDFIRST then
                            repeat
                                Item.GET(ItemCrossReference."Item No.");
                                if not Item.Blocked then begin  //HEI.03
                                    AllItemsBlocked := false;  //HEI.03
                                    if ItemCrossReference."Unit of Measure" = Item."Sales Unit of Measure" then begin
                                        //HEI.06>>
                                        //IF (ItemNo <> '') AND (ItemCrossReference."Item No." <> ItemNo) THEN
                                        //ERROR(Text006,InterfaceEntryLine."Cross Reference No.");  //commented by HEI.02
                                        //HEI.02>>
                                        //IF ForceCreation THEN BEGIN
                                        //SalesLine.VALIDATE(Type,SalesLine.Type::" ");
                                        //SalesLine.Description := COPYSTR(STRSUBSTNO(Text006,InterfaceEntryLine."Cross Reference No."),1,50);
                                        //SalesLine."Description 2" := STRSUBSTNO(Text008,InterfaceEntryLine.Quantity,COPYSTR(InterfaceEntryLine."E-Mail 2",1,40));
                                        //SalesLine.MODIFY(TRUE);
                                        //ErrorLine := TRUE;  //HEI.02
                                        //END ELSE
                                        //ERROR(Text006,InterfaceEntryLine."Cross Reference No.");
                                        //HEI.02<<
                                        //HEI.06<<
                                        ItemNo := ItemCrossReference."Item No.";
                                        UnitofMeasure := ItemCrossReference."Unit of Measure";
                                    end;
                                end;  //HEI.03
                                      //HEI.06>>
                                      //UNTIL ItemCrossReference.NEXT = 0;
                            until (ItemCrossReference.NEXT = 0) or (ItemNo <> '');
                        //HEI.06<<
                        if not ErrorLine then begin   //HEI.02
                            if ItemNo <> '' then begin
                                SalesLine.VALIDATE("No.", ItemNo);
                                SalesLine.VALIDATE("Unit of Measure Code", UnitofMeasure);
                            end else
                              //HEI.03>>
                              begin
                                if AllItemsBlocked then
                                    if ForceCreation then begin
                                        SalesLine.VALIDATE(Type, SalesLine.Type::" ");
                                        SalesLine.Description := Text009;
                                        SalesLine."Description 2" := STRSUBSTNO(Text008, InterfaceEntryLine.Quantity, COPYSTR(InterfaceEntryLine."E-Mail 2", 1, 40));
                                        SalesLine.MODIFY(true);
                                        ErrorLine := true;
                                    end else
                                        ERROR(Text009);
                                //HEI.03<<
                                if ItemCrossReference."Unit of Measure" <> Item."Sales Unit of Measure" then
                                    //HEI.02>>
                                    if ForceCreation then begin
                                        SalesLine.VALIDATE(Type, SalesLine.Type::" ");
                                        SalesLine.Description := COPYSTR(STRSUBSTNO(Text007, ItemCrossReference."Item No."), 1, 50);
                                        SalesLine."Description 2" := STRSUBSTNO(Text008, InterfaceEntryLine.Quantity, COPYSTR(InterfaceEntryLine."E-Mail 2", 1, 40));
                                        SalesLine.MODIFY(true);
                                        ErrorLine := true;  //HEI.02
                                    end else
                                        //HEI.02<<
                                        ERROR(Text007, ItemCrossReference."Item No.");
                            end;  //HEI.03
                        end; //HEI.02
                    end;
                end;

                if not ErrorLine then begin  //HEI.02
                    SalesLine.VALIDATE("Location Code", SalesHeader."Location Code");
                    //HEI.10>>
                    if UnitOfMeasureCode <> '' then begin

                        ItemUOMEDI.GET(SalesLine."No.", UnitOfMeasureCode);
                        ItemUOM.GET(SalesLine."No.", SalesLine."Unit of Measure Code");

                        SalesLine.VALIDATE(Quantity, ROUND(InterfaceEntryLine.Quantity * ItemUOMEDI."Qty. per Unit of Measure" / ItemUOM."Qty. per Unit of Measure", 1, '>'));
                    end else
                        //HEI.10<<
                        SalesLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    // SalesLine.VALIDATE("Shipment Date",InterfaceEntryLine."Expected Delivery Date");
                    //SalesLine.VALIDATE("Requested Delivery Date",InterfaceEntryLine."Expected Delivery Date");
                    SalesLine.MODIFY(true);

                    InsertSalesComment(SalesLine."Document No.", SalesLine."Line No.", '', InterfaceEntryLine."E-Mail 2");
                end; //HEI.02

            //LineNo += 10000;
            until InterfaceEntryLine.NEXT = 0;

        //ApplyCharges(SalesHeader);//BC Upgrade VAMSIU01
        SalesHook101FDW.CalculateAttatchedSalesOrderLines(SalesHeader); //BC Upgrade VAMSIU01

        if not ForceCreation then  //HEI.02
            SalesHeader.VALIDATE("EDI Order FND", true);
        SalesHeader.MODIFY(true);

        //CODEUNIT.RUN(CODEUNIT::"Release Sales Document",SalesHeader);

    end;

    // [EventSubscriber(ObjectType::Table, 50004, 'OnAfterInsertEvent', '', false, false)]
    [EventSubscriber(ObjectType::Table, 58004, 'OnAfterInsertEvent', '', false, false)]

    local procedure T50004OnAfterInsert(var Rec: Record "Interface Log Header INT"; RunTrigger: Boolean);
    var
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
    begin
        /*GeneralInterfaceSetup.GET;
        IF USERID = GeneralInterfaceSetup."Interface Job Queue User ID" THEN BEGIN
          GetOrtecInterfaceSetup;
          IF NOT (Rec."Interface Code" IN [OrtecKStoreInterfaceSetup."SO/SRO Interface Request"]) THEN
            EXIT;
              OrtecKStoreInterfaceSetup.TESTFIELD("SO/SRO Interface Response");
              InterfaceEntryHeaderOut.INIT;
              InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
              InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
              InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
              InterfaceEntryHeaderOut."Interface Code" := OrtecKStoreInterfaceSetup."SO/SRO Interface Response";
              InterfaceEntryHeaderOut."Source No." := Rec."Source No.";
              InterfaceEntryHeaderOut."E-Mail" := '10';
              IF CheckPriceDifference(Rec."Source No.") THEN
                InterfaceEntryHeaderOut."Phone No." := 'Difference'
              ELSE
                InterfaceEntryHeaderOut."Phone No." := 'No Difference';
              InterfaceEntryHeaderOut.Name := '2';
              InterfaceEntryHeaderOut.INSERT(TRUE);
        END;
        */

    end;

    local procedure GetEDIInterfaceSetup();
    begin
        if not EDIInterfaceSetupRead then
            if EDIInterfaceSetup.GET then;
        EDIInterfaceSetupRead := true;
    end;

    local procedure CheckPriceDifference(OrderNo: Code[20]): Boolean;
    var
        SalesHeader: Record "Sales Header";
        SalesHeaderRO: Record "Sales Header";
        OrderVatAmount: Decimal;
        Err001: Label 'Sales Order %1 does not exist!';
        SalesLine: Record "Sales Line";
        SalesLineRO: Record "Sales Line";
        OrderAmount: Decimal;
    begin
        /*GetOrtecInterfaceSetup;
        CLEAR(OrderVatAmount);
        
        SalesHeader.RESET;
        SalesHeader.SETRANGE(SalesHeader."Document Type",SalesHeader."Document Type"::Order);
        SalesHeader.SETRANGE("External Document No.",OrtecKStoreInterfaceSetup."Sales Order Prefix" + OrderNo);
        IF SalesHeader.FINDFIRST THEN BEGIN
          SalesLine.RESET;
          SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::Order);
          SalesLine.SETRANGE("Document No.",SalesHeader."No.");
          SalesLine.CALCSUMS(Amount,"Amount Including VAT");
        END ELSE
          ERROR(Err001,OrderNo);
        
        SalesHeaderRO.RESET;
        SalesHeaderRO.SETRANGE(SalesHeaderRO."Document Type",SalesHeaderRO."Document Type"::"Return Order");
        SalesHeaderRO.SETRANGE("External Document No.",OrtecKStoreInterfaceSetup."Sales Return Order Prefix" + OrderNo);
        IF SalesHeaderRO.FINDFIRST THEN BEGIN
          SalesLineRO.RESET;
          SalesLineRO.SETRANGE("Document Type",SalesLineRO."Document Type"::Order);
          SalesLineRO.SETRANGE("Document No.",SalesHeaderRO."No.");
          SalesLineRO.CALCSUMS(Amount,"Amount Including VAT");
        END ELSE
          ERROR(Err001,OrderNo);
        
        OrderVatAmount := (SalesLine."Amount Including VAT" - SalesLineRO."Amount Including VAT")  - (SalesLine.Amount - SalesLineRO.Amount);
        OrderAmount := SalesLine."Amount Including VAT" - SalesLineRO."Amount Including VAT";
        IF (OrderVatAmount <> SalesHeader."Doc. Amount VAT") OR (OrderAmount <> SalesHeader."Doc. Amount Incl. VAT") THEN
          EXIT(TRUE);
        EXIT(FALSE);
        */

    end;

    local procedure CheckSOExist(ExtOrderNo: Code[20]; CustNo: Code[20]);
    var
        SalesHeader: Record "Sales Header";
        Err001: Label 'Sales Order %1 already exist!';
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Err002: Label 'Posted Sales Invoice %1 already exist!';
        SalesShpHeader: Record "Sales Shipment Header";
        Err003: Label 'Posted Sales Shipment %1 already exist!';
    begin
        SalesHeader.RESET;
        SalesHeader.SETCURRENTKEY("Sell-to Customer No.", "External Document No.");
        SalesHeader.SETRANGE("Sell-to Customer No.", CustNo);
        SalesHeader.SETRANGE("External Document No.", ExtOrderNo);
        if SalesHeader.FINDFIRST then
            ERROR(Err001, ExtOrderNo);

        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETCURRENTKEY("Sell-to Customer No.", "External Document No.");
        SalesInvoiceHeader.SETRANGE("External Document No.", ExtOrderNo);
        SalesInvoiceHeader.SETRANGE("Sell-to Customer No.", CustNo);
        if SalesInvoiceHeader.FINDFIRST then
            ERROR(Err002, ExtOrderNo);

        SalesShpHeader.RESET;
        SalesShpHeader.SETCURRENTKEY("Sell-to Customer No.", "External Document No.");
        SalesShpHeader.SETRANGE("External Document No.", ExtOrderNo);
        SalesShpHeader.SETRANGE("Sell-to Customer No.", CustNo);
        if SalesShpHeader.FINDFIRST then
            ERROR(Err003, ExtOrderNo);
    end;

    local procedure InsertSalesComment(DocumentNo: Code[20]; DocumentLineNo: Integer; CommentCode: Text; CommentText: Text);
    var
        SalesCommentLine: Record "Sales Comment Line";
        CommentLineNo: Integer;
        i: Integer;
    begin
        if (CommentText = '') then
            exit;

        for i := 1 to STRLEN(CommentText) do begin
            SalesCommentLine.SETRANGE("Document Type", SalesCommentLine."Document Type"::Order);
            SalesCommentLine.SETRANGE("No.", DocumentNo);
            SalesCommentLine.SETRANGE("Document Line No.", DocumentLineNo);
            if SalesCommentLine.FINDLAST then
                CommentLineNo := SalesCommentLine."Line No." + 10000
            else
                CommentLineNo := 10000;
            CLEAR(SalesCommentLine);
            SalesCommentLine.INIT;
            SalesCommentLine."Document Type" := SalesCommentLine."Document Type"::Order;
            SalesCommentLine."No." := DocumentNo;
            SalesCommentLine."Document Line No." := DocumentLineNo;
            SalesCommentLine."Line No." := CommentLineNo;
            SalesCommentLine.Date := TODAY;
            SalesCommentLine.Code := COPYSTR(CommentCode, 1, MAXSTRLEN(SalesCommentLine.Code));
            SalesCommentLine.Comment := COPYSTR(CommentText, i, MAXSTRLEN(SalesCommentLine.Comment));
            SalesCommentLine.INSERT(true);
            i += MAXSTRLEN(SalesCommentLine.Comment);
        end;
    end;

    local procedure ApplyCharges(SalesH: Record "Sales Header");
    var
        SalesLineCharge: Record "Sales Line";
        Item2: Record Item;
    begin
        SalesLineCharge.RESET;
        SalesLineCharge.SETRANGE("Document Type", SalesH."Document Type"::Order);
        SalesLineCharge.SETRANGE("Document No.", SalesH."No.");
        if SalesLineCharge.FINDSET then
            repeat
                if Item2.GET(SalesLineCharge."No.") then
                    // if SalesLineCharge.InsertCharges4(SalesLineCharge.FIELDNO("No."), true) then //BC Upgrade GUNREM01 DIT Function 
                    SalesLineCharge.MODIFY(true);
            until SalesLineCharge.NEXT = 0;
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnBeforeValidateEvent', 'No.', false, false)]
    local procedure T37OnBeforeValidateEvent_No(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer);
    var
        SH: Record "Sales Header";
        Text001: Label 'You cannot modify Item No. in an EDI order.';
    begin
        //commented by HEI.03>>
        /*IF Rec.ISTEMPORARY THEN EXIT;
        IF SH.GET(SH."Document Type"::Order, Rec."Document No.") AND SH."EDI Order" THEN
          IF Rec."No." <> xRec."No." THEN
            ERROR(Text001);*/
        //commented by HEI.03<<

    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnBeforeValidateEvent', 'Unit of Measure Code', false, false)]
    local procedure T37OnBeforeValidateEvent_UOM(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer);
    var
        SH: Record "Sales Header";
        Text001: Label 'You cannot modify UOM in an EDI order.';
    begin
        //commented by HEI.03>>
        /*IF Rec.ISTEMPORARY THEN EXIT;
        IF SH.GET(SH."Document Type"::Order, Rec."Document No.") AND SH."EDI Order" THEN
          IF Rec."Unit of Measure Code" <> xRec."Unit of Measure Code" THEN
            ERROR(Text001);*/
        //commented by HEI.03<<

    end;

    [EventSubscriber(ObjectType::Page, 46, 'OnNewRecordEvent', '', false, false)]
    local procedure P46OnNewRecordEvent(var Rec: Record "Sales Line"; BelowxRec: Boolean; var xRec: Record "Sales Line");
    var
        SH: Record "Sales Header";
        Text001: Label 'You cannot insert lines in an EDI order.';
    begin
        //commented by HEI.03>>
        /*IF Rec.ISTEMPORARY THEN EXIT;
        IF SH.GET(SH."Document Type"::Order, Rec."Document No.") AND SH."EDI Order" THEN
          ERROR(Text001);*/
        //commented by HEI.03<<

    end;
    //BC Upgrade GUNREM01 -Code commenetd by HEI.03 in NAV >>
    // [EventSubscriber(ObjectType::Page, 46, 'OnBeforeActionEvent', 'Action1100099000', false, false)]
    // local procedure P46OnBeforeActionEvent_NewLine(var Rec: Record "Sales Line");
    // var
    //     SH: Record "Sales Header";
    //     Text001: Label 'You cannot insert lines in an EDI order.';
    // begin
    //     //commented by HEI.03>>
    //     /*IF Rec.ISTEMPORARY THEN EXIT;
    //     IF SH.GET(SH."Document Type"::Order, Rec."Document No.") AND SH."EDI Order" THEN
    //       ERROR(Text001);*/
    //     //commented by HEI.03<<

    // end;
    //BC Upgrade GUNREM01 -Code commenetd by HEI.03 in NAV <<

    //BC Upgrade GUNREM01 -SMTP code Blocked >>
    // [EventSubscriber(ObjectType::Codeunit, 50000, 'OnAfterSetInterfaceError', '', false, false)]
    // [EventSubscriber(ObjectType::Codeunit, 58000, 'OnAfterSetInterfaceError', '', false, false)]

    // local procedure "Interface Framework Mgt_OnAfterSetInterfaceError"(InterfaceEntryHeader: Record "Interface Entry Header INT");
    // var
    //     SMTPMail: Codeunit "SMTP Mail";
    //     MessageText: Text;
    // begin
    //     GetEDIInterfaceSetup;
    //     if InterfaceEntryHeader."Interface Code" = EDIInterfaceSetup."SO/SRO Interface Request" then
    //         if EDIInterfaceSetup."Error email address" <> '' then begin
    //             MessageText := 'Error for Header entry no.: ' + FORMAT(InterfaceEntryHeader."Entry No.");
    //             MessageText += '<br>ERROR message: <font color="red">' + InterfaceEntryHeader."Error Message" + ' !</font><br><br><br>';
    //             SMTPMail.CreateMessage('NAV LOG ERROR EDI TECH', 'NAV_ERROR@heineken.com', EDIInterfaceSetup."Error email address",
    //                                     EDIInterfaceSetup."Error email subject", MessageText, true);
    //             SMTPMail.Send;
    //         end
    // end;
    //BC Upgrade GUNREM01 -SMTP code Blocked <<
}

