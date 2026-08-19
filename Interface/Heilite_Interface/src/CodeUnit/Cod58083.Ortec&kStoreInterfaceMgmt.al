codeunit 58083 "Ortec & KStore Interface Mgmt."
{
    //BC Upgrade GUNREM01 Old ID-50075
    // version HEI.09

    // HEI.01 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new object
    // HEI.02 FDD-SR_HT464_Ortec Interface IBM HORTOC01 09.07.2019 - #new fucntions
    // HEI.03 FDD-SR_HT464_Ortec Interface IBM HORTOC01 26.07.2019 - #new function
    // HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019 # CreateRASalesOrders,ProcessRASalesOrder,
    //                                                  InsertNewSOLine,FefoTrackingOrderLines,AssignQtyForitemCharge
    //                                                  ,GetAditionalAmountExclAmt,CreateRAPaymentJournal funcs. added
    // HEI.05 INC2441588 IBM HORTOC01 17.10.2019 #update source code for payment journal
    // HEI.06 CHG2025183 IBM GUNERE01 16.12.2019 # T50001OnAfterModify,T50004OnAfterInsert funcs. modified,
    //                                             DocumentExists func added
    // HEI.07 CHG2025183 IBM GUNERE01 24.01.2020 # T50005OnAfterInsert func. created
    // HEI.08 HB1753 - CHG2083594 IBM NASTAA02 16.11.2020 # Surplus Charges Suriname
    //   # 3 new fields added to the header of the interface
    // HEI.09 CHG2204844 IBM MARTIR52 16.05.2023 # Update Order Date based on the Interface source date.
    //   # New line of code added to consider this information inthe document created.

    //BC Upgrade GUNREM01 -Commenetd DIT code and fields.
    // BC Upgrade SHUKLP03 >> Restructured old DIT fields and code of RA payment journal and RA sales order.

    trigger OnRun();
    begin
    end;

    var
        OrtecInterfaceSetupRead: Boolean;
        OrtecKStoreInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";
        Err001: Label 'The length of the field should be 6 chr!';
        // NoSeriesMgt: Codeunit NoSeriesManagement;4
        NoSeriesMgt: Codeunit "No. Series";
        SOCreated: Boolean;

    procedure UpdateSO(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        SalesHeader: Record "Sales Header";
        SalesHeaderSR: Record "Sales Header";
    begin
        InterfaceEntryLine.RESET();
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET() then
            repeat
                SalesHeader.RESET();
                SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.SETRANGE("No.", InterfaceEntryLine."Order No.");
                if SalesHeader.FINDSET() then
                    repeat
                        //BC Upgrade GUNREM01 -DIT Field >>
                        // SalesHeader.SetCurrField(SalesHeader.FIELDNO(Route));
                        // SalesHeader.VALIDATE(Route, InterfaceEntryLine."Truck Code");
                        //BC Upgrade GUNREM01 -DIT Field <<
                        SalesHeader.VALIDATE("Load No. FND", InterfaceEntryLine."Order Line No.");
                        SalesHeader.VALIDATE("Sequence No. FND", InterfaceEntryLine."Source Line No.");
                        SalesHeader.MODIFY();
                        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
                            CreatePaymentJournal(SalesHeader);
                    until SalesHeader.NEXT() = 0;

                SalesHeaderSR.RESET();
                SalesHeaderSR.SETRANGE("Document Type", SalesHeaderSR."Document Type"::"Return Order");
                //  SalesHeaderSR.SETRANGE("Link Sales Document No.", InterfaceEntryLine."Order No."); //BC Upgrade GUNREM01-DIT Field
                if SalesHeaderSR.FINDSET() then
                    repeat
                        //BC Upgrade GUNREM01-DIT Field >>
                        // SalesHeaderSR.SetCurrField(SalesHeaderSR.FIELDNO(Route));
                        // SalesHeaderSR.VALIDATE(Route, InterfaceEntryLine."Truck Code");
                        //BC Upgrade GUNREM01-DIT Field <<
                        SalesHeaderSR.VALIDATE("Load No. FND", InterfaceEntryLine."Order Line No.");
                        SalesHeaderSR.VALIDATE("Sequence No. FND", InterfaceEntryLine."Source Line No.");
                        SalesHeaderSR.MODIFY();
                    until SalesHeaderSR.NEXT() = 0;
            until InterfaceEntryLine.NEXT() = 0;
    end;

    local procedure CreatePaymentJournal(SalesHeader: Record "Sales Header");
    var
        GenJournalLine: Record "Gen. Journal Line";
        // Route: Record Route; //BC Upgrade GUNREM01-DIT Table
        LineNo: Integer;
        SalesHeaderSRO: Record "Sales Header";
        SalesHeaderSRO2: Record "Sales Header";
        GenJournalTemplate: Record "Gen. Journal Template";
    begin
        //BC Upgrade GUNREM01-Dependecny with DIT Fields >>
        // Route.GET(SalesHeader.Route);
        // Route.TESTFIELD("Journal Template Name");
        // Route.TESTFIELD("Journal Batch Name");
        // GenJournalTemplate.GET(Route."Journal Template Name");//HEI.05
        // CLEAR(LineNo);
        // GenJournalLine.RESET;
        // GenJournalLine.SETRANGE("Journal Batch Name", Route."Journal Batch Name");
        // GenJournalLine.SETRANGE("Journal Template Name", Route."Journal Template Name");

        //     if GenJournalLine.FINDLAST then
        //         LineNo := GenJournalLine."Line No.";

        //     GenJournalLine.RESET;
        //     GenJournalLine.INIT;
        //     GenJournalLine.VALIDATE("Source Code", GenJournalTemplate."Source Code");//HEI.05
        //                                                                              // GenJournalLine.VALIDATE("Journal Template Name", Route."Journal Template Name");
        //                                                                              // GenJournalLine.VALIDATE("Journal Batch Name", Route."Journal Batch Name");

        //     GenJournalLine.VALIDATE("Line No.", LineNo + 10000);
        //     GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
        //     GenJournalLine.VALIDATE("Document No.", 'P' + SalesHeader."No.");
        //     GenJournalLine.VALIDATE("Posting Date", SalesHeader."Shipment Date");
        //     GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
        //     GenJournalLine.VALIDATE("Account No.", SalesHeader."Bill-to Customer No.");

        //     SalesHeaderSRO.RESET;
        //     SalesHeaderSRO.SETRANGE(SalesHeaderSRO."Document Type", SalesHeaderSRO."Document Type"::"Return Order");

        //     // SalesHeaderSRO.SETRANGE("Link Sales Document Type", SalesHeaderSRO."Link Sales Document Type"::Order);
        //     // SalesHeaderSRO.SETRANGE("Link Sales Document No.", SalesHeader."No.");

        //     //SalesHeaderSRO.SETRANGE("External Document No.",SalesHeader."External Document No.");

        //     if SalesHeaderSRO.FINDFIRST then begin
        //         SalesHeaderSRO.CALCFIELDS("Amount Including VAT");
        //         SalesHeader.CALCFIELDS("Amount Including VAT");
        //         GenJournalLine.VALIDATE("Amount (LCY)", -(SalesHeader."Amount Including VAT" - SalesHeaderSRO."Amount Including VAT"));
        //     end else begin
        //         SalesHeader.CALCFIELDS("Amount Including VAT");
        //         GenJournalLine.VALIDATE("Amount (LCY)", -SalesHeader."Amount Including VAT");
        //     end;

        //     //amount to be calculated

        //     // GenJournalLine.VALIDATE("Route Planning No.", SalesHeader."Route Planning No.");
        //     // GenJournalLine.VALIDATE("Driver Code", SalesHeader."Driver Code");

        //     //GenJournalLine.VALIDATE("Applies-to Doc. Type",GenJournalLine."Applies-to Doc. Type"::Invoice);
        //     GenJournalLine."Applies-to Doc. Type" := GenJournalLine."Applies-to Doc. Type"::Invoice;
        //     GenJournalLine."Applies-to Doc. No." := SalesHeader."External Document No.";//posted invoice should have the same no like the Sales Invoice
        //     if GenJournalLine."Amount (LCY)" <> 0 then
        //         GenJournalLine.INSERT(true);
    end;
    //BC Upgrade GUNREM01-Dependecny with DIT Fields <<
    procedure ProcessSalesOrder(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        DocumentType: Option "Order","Return Order";
    begin
        InterfaceEntryHeader.CALCFIELDS("Negative Line Exist");
        if InterfaceEntryHeader."Negative Line Exist" then begin
            CreateOrder(InterfaceEntryHeader, InterfaceEntryLine, DocumentType::Order);
            CreateOrder(InterfaceEntryHeader, InterfaceEntryLine, DocumentType::"Return Order")
        end else
            CreateOrder(InterfaceEntryHeader, InterfaceEntryLine, DocumentType::Order);
    end;

    local procedure CreateOrder(InterfaceEntryHeader: Record "Interface Entry Header INT"; InterfaceEntryLine: Record "Interface Entry Line INT"; DocumentType: Option "Order","Return Order");
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesHeader2: Record "Sales Header";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Resource: Record Resource;
        InterfaceEntryLine2: Record "Interface Entry Line INT";
        DimensionManagement: Codeunit DimensionManagement;
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        DimensionSetEntry: Record "Dimension Set Entry";
        SKUDimensionValue: Code[20];
        ItemLineNo: Integer;
    begin
        CheckDuplicateSalesOrder(InterfaceEntryHeader."Source No.", DocumentType); //HEI.05
        GetOrtecInterfaceSetup();
        GeneralLedgerSetup.GET();
        OrtecKStoreInterfaceSetup.TESTFIELD("Sales Order Prefix");
        OrtecKStoreInterfaceSetup.TESTFIELD("Sales Return Order Prefix");
        CheckSOExist(InterfaceEntryHeader."Source No.");
        SalesHeader.INIT();
        if DocumentType = DocumentType::Order then begin
            SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::Order);
            SalesHeader.VALIDATE("No.", '');
        end else begin
            SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::"Return Order");
            SalesHeader.VALIDATE("No.", '');
            SalesHeader2.RESET();
            SalesHeader2.SETRANGE("External Document No.", InterfaceEntryHeader."Source No.");
            SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::Order);
            //BC Upgrade GUNREM01-Dependecny with DIT Fields >>
            // if SalesHeader2.FINDFIRST then begin
            //     SalesHeader."Link Sales Document Type" := SalesHeader."Link Sales Document Type"::Order;
            //     SalesHeader."Link Sales Document No." := SalesHeader2."No.";
            // end;
            //BC Upgrade GUNREM01-Dependecny with DIT Fields <<
        end;
        SalesHeader.INSERT(true);
        SalesHeader.VALIDATE("Sell-to Customer No.", InterfaceEntryHeader."Bill-to Customer No.");
        //SalesHeader.VALIDATE("Bill-to Customer No.",InterfaceEntryHeader."Bill-to Customer No.");

        SalesHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
        SalesHeader.VALIDATE("Document Date", InterfaceEntryHeader."Posting Date");
        //HEI.09 >>
        SalesHeader.VALIDATE("Order Date", InterfaceEntryHeader."Posting Date");
        //HEI.09 <<
        SalesHeader.VALIDATE("External Document No.", InterfaceEntryHeader."External Document No.");
        SalesHeader.VALIDATE("Location Code", InterfaceEntryHeader."Location Code");
        SalesHeader.VALIDATE("Shipment Method Code", InterfaceEntryHeader."Shipment Method");
        SalesHeader.VALIDATE("Shipment Date", InterfaceEntryHeader."Expected Delivery Date");
        SalesHeader.VALIDATE("Requested Delivery Date", InterfaceEntryHeader."Expected Delivery Date");

        if GeneralLedgerSetup."LCY Code" <> InterfaceEntryHeader."Currency Code" then
            SalesHeader.VALIDATE("Currency Code", InterfaceEntryHeader."Currency Code");

        SalesHeader.VALIDATE("External Document No.", InterfaceEntryHeader."Source No.");

        SalesHeader.VALIDATE("Posting No.", SalesHeader."External Document No.");
        SalesHeader.VALIDATE("Doc. Amount Incl. VAT FND", InterfaceEntryHeader.Amount);
        SalesHeader.VALIDATE("Doc. Amount VAT FND", InterfaceEntryHeader."VAT Amount");
        SalesHeader.VALIDATE("Vans Sales Route FND", true);
        //HEI.08>>
        if InterfaceEntryHeader."Payment Terms Code" <> '' then
            SalesHeader.VALIDATE("Payment Method Code", InterfaceEntryHeader."Payment Terms Code");
        //HEI.08<<
        SalesHeader.MODIFY(true);

        LineNo := 10000;
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if DocumentType = DocumentType::Order then
            InterfaceEntryLine.SETFILTER(Quantity, '>%1', 0)
        else
            InterfaceEntryLine.SETFILTER(Quantity, '<%1', 0);
        if InterfaceEntryLine.FINDSET() then
            repeat
                if InterfaceEntryLine."Item No." <> '' then begin //HEI.08
                    SalesLine.INIT();
                    SalesLine.VALIDATE("Document Type", SalesHeader."Document Type");
                    SalesLine.VALIDATE("Document No.", SalesHeader."No.");
                    SalesLine.VALIDATE("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
                    SalesLine.VALIDATE("Line No.", LineNo);
                    SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                    SalesLine.VALIDATE("No.", InterfaceEntryLine."Item No.");
                    SalesLine.VALIDATE("Location Code", SalesHeader."Location Code");
                    SalesLine.VALIDATE(Quantity, ABS(InterfaceEntryLine.Quantity));
                    SalesLine.VALIDATE("Shipment Date", InterfaceEntryLine."Expected Delivery Date");
                    SalesLine.VALIDATE("Requested Delivery Date", InterfaceEntryLine."Expected Delivery Date");
                    SalesLine.INSERT(true);
                    LineNo += 10000;

                    //HEI.08>>
                    ItemLineNo := SalesLine."Line No.";

                    //Search SKU Dimension for the Item line
                    SKUDimensionValue := '';
                    if GeneralLedgerSetup."SKU Dimension Code FND" <> '' then begin
                        DimensionSetEntry.RESET();
                        DimensionSetEntry.SETRANGE("Dimension Set ID", SalesLine."Dimension Set ID");
                        DimensionSetEntry.SETRANGE("Dimension Code", GeneralLedgerSetup."SKU Dimension Code FND");
                        if DimensionSetEntry.FINDFIRST() then
                            SKUDimensionValue := DimensionSetEntry."Dimension Value Code";
                    end;

                    if DocumentType = DocumentType::Order then begin
                        InterfaceEntryLine2.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                        InterfaceEntryLine2.SETRANGE(Quantity, 0);
                        InterfaceEntryLine2.SETRANGE("Item No.", InterfaceEntryLine."Item No.");
                        InterfaceEntryLine2.SETFILTER(Description, '<>%1', '');
                        InterfaceEntryLine2.SETFILTER("Unit Amount", '<>%1', 0);
                        if InterfaceEntryLine2.FINDSET() then
                            repeat
                                Resource.SETRANGE(Name, InterfaceEntryLine2.Description);
                                if Resource.FINDFIRST() then begin
                                    SalesLine.INIT();
                                    SalesLine.VALIDATE("Document Type", SalesHeader."Document Type");
                                    SalesLine.VALIDATE("Document No.", SalesHeader."No.");
                                    SalesLine.VALIDATE("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
                                    SalesLine.VALIDATE("Line No.", LineNo);
                                    SalesLine.VALIDATE(Type, SalesLine.Type::Resource);
                                    SalesLine.VALIDATE("No.", Resource."No.");
                                    SalesLine.VALIDATE("Location Code", SalesHeader."Location Code");
                                    SalesLine.VALIDATE(Quantity, 1);
                                    SalesLine.VALIDATE("Unit Price", InterfaceEntryLine2."Unit Amount");

                                    //Update Dimension Set Entries
                                    if GeneralLedgerSetup."SKU Dimension Code FND" <> '' then begin
                                        CLEAR(TempDimensionSetEntry);
                                        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, SalesLine."Dimension Set ID");
                                        TempDimensionSetEntry.SETRANGE("Dimension Code", GeneralLedgerSetup."SKU Dimension Code FND");
                                        if TempDimensionSetEntry.FINDFIRST() and (TempDimensionSetEntry."Dimension Value Code" <> SKUDimensionValue) then
                                            TempDimensionSetEntry.DELETE();
                                        if SKUDimensionValue <> '' then begin
                                            TempDimensionSetEntry.INIT();
                                            TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup."SKU Dimension Code FND";
                                            TempDimensionSetEntry."Dimension Value Code" := SKUDimensionValue;
                                            if TempDimensionSetEntry.INSERT(true) then;
                                        end;
                                        SalesLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                                        SalesLine."Attached to Line No." := ItemLineNo;
                                    end;

                                    SalesLine.INSERT(true);

                                    LineNo += 10000;
                                end;
                            until InterfaceEntryLine2.NEXT() = 0;
                    end;
                end;
            //HEI.08>>
            until InterfaceEntryLine.NEXT() = 0;

        //CODEUNIT.RUN(CODEUNIT::"Release Sales Document",SalesHeader);
        //ReleaseSalesDocument.PerformManualRelease(SalesHeader);

        if SalesHeader."Payment Terms Code" <> 'C000' then begin
            if ApprovalsMgmt.CheckSalesApprovalPossible(SalesHeader) then
                ApprovalsMgmt.OnSendSalesDocForApproval(SalesHeader);
        end else
            CODEUNIT.RUN(CODEUNIT::"Release Sales Document", SalesHeader);
    end;

    //  [EventSubscriber(ObjectType::Table, 50004, 'OnAfterInsertEvent', '', false, false)]
    [EventSubscriber(ObjectType::Table, 58004, 'OnAfterInsertEvent', '', false, false)]

    local procedure T50004OnAfterInsert(var Rec: Record "Interface Log Header INT"; RunTrigger: Boolean);
    var
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
    begin
        GeneralInterfaceSetup.GET();
        if USERID = GeneralInterfaceSetup."Interface Job Queue User ID" then begin
            GetOrtecInterfaceSetup();
            if not (Rec."Interface Code" in [OrtecKStoreInterfaceSetup."SO/SRO Interface Request", OrtecKStoreInterfaceSetup."RA Payment/Refund Request"
                                             , OrtecKStoreInterfaceSetup."RA SO/SRO Interface Request"]) then // HEI.06
                exit;
            //>> HEI.06
            case Rec."Interface Code" of
                OrtecKStoreInterfaceSetup."SO/SRO Interface Request":
                    begin
                        OrtecKStoreInterfaceSetup.TESTFIELD("SO/SRO Interface Response");
                        InterfaceEntryHeaderOut.INIT();
                        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
                        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
                        InterfaceEntryHeaderOut."Interface Code" := OrtecKStoreInterfaceSetup."SO/SRO Interface Response";
                        InterfaceEntryHeaderOut."Source No." := Rec."Source No.";
                        InterfaceEntryHeaderOut."E-Mail" := '10';
                        if CheckPriceDifference(Rec."Source No.") then
                            InterfaceEntryHeaderOut."Phone No." := 'Difference'
                        else
                            InterfaceEntryHeaderOut."Phone No." := 'No Difference';
                        InterfaceEntryHeaderOut.Name := '2';
                        InterfaceEntryHeaderOut.INSERT(true);
                    end;
                OrtecKStoreInterfaceSetup."RA SO/SRO Interface Request":
                    begin
                        OrtecKStoreInterfaceSetup.TESTFIELD("RA SO/SRO Interface Response");
                        InterfaceEntryHeaderOut.INIT();
                        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
                        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
                        InterfaceEntryHeaderOut."Interface Code" := OrtecKStoreInterfaceSetup."RA SO/SRO Interface Response";
                        InterfaceEntryHeaderOut."Source No." := Rec."Source No.";
                        InterfaceEntryHeaderOut."E-Mail" := 'OK';
                        InterfaceEntryHeaderOut.Name := Rec."Type ID";
                        InterfaceEntryHeaderOut.INSERT(true);
                    end;
                OrtecKStoreInterfaceSetup."RA Payment/Refund Request":
                    begin
                        OrtecKStoreInterfaceSetup.TESTFIELD("RA Payment/Refund Response");
                        InterfaceEntryHeaderOut.INIT();
                        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
                        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
                        InterfaceEntryHeaderOut."Interface Code" := OrtecKStoreInterfaceSetup."RA Payment/Refund Response";
                        InterfaceEntryHeaderOut."Source No." := Rec."Source No.";
                        InterfaceEntryHeaderOut."E-Mail" := 'OK';
                        InterfaceEntryHeaderOut.Name := Rec."Type ID";
                        InterfaceEntryHeaderOut.INSERT(true);
                    end;
            end;
            //<< HEI.06
        end;
    end;

    //  [EventSubscriber(ObjectType::Table, 50001, 'OnAfterModifyEvent', '', false, false)]
    [EventSubscriber(ObjectType::Table, 58001, 'OnAfterModifyEvent', '', false, false)]

    local procedure T50001OnAfterModify(var Rec: Record "Interface Entry Header INT"; var xRec: Record "Interface Entry Header INT"; RunTrigger: Boolean);
    var
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
    begin
        GeneralInterfaceSetup.GET();
        if (USERID = GeneralInterfaceSetup."Interface Job Queue User ID") and
           (Rec.Status = Rec.Status::Error)
        then begin
            GetOrtecInterfaceSetup();
            if not (Rec."Interface Code" in [OrtecKStoreInterfaceSetup."SO/SRO Interface Request", OrtecKStoreInterfaceSetup."RA Payment/Refund Request",
                                             OrtecKStoreInterfaceSetup."RA SO/SRO Interface Request"]) then // HEI.06
                exit;
            //>> HEI.06
            case Rec."Interface Code" of
                OrtecKStoreInterfaceSetup."SO/SRO Interface Request":
                    begin
                        OrtecKStoreInterfaceSetup.TESTFIELD("SO/SRO Interface Response");
                        InterfaceEntryHeaderOut.INIT();
                        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
                        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
                        InterfaceEntryHeaderOut."Interface Code" := OrtecKStoreInterfaceSetup."SO/SRO Interface Response";
                        InterfaceEntryHeaderOut."Source No." := Rec."Source No.";
                        InterfaceEntryHeaderOut."E-Mail" := '10';
                        InterfaceEntryHeaderOut."Phone No." := 'ERROR';
                        InterfaceEntryHeaderOut.Name := '2';
                        InterfaceEntryHeaderOut.INSERT(true);
                    end;
                OrtecKStoreInterfaceSetup."RA SO/SRO Interface Request":
                    begin
                        OrtecKStoreInterfaceSetup.TESTFIELD("RA SO/SRO Interface Response");
                        InterfaceEntryHeaderOut.INIT();
                        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
                        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
                        InterfaceEntryHeaderOut."Interface Code" := OrtecKStoreInterfaceSetup."RA SO/SRO Interface Response";
                        InterfaceEntryHeaderOut."Source No." := Rec."Source No.";
                        InterfaceEntryHeaderOut."E-Mail" := 'NOK';
                        InterfaceEntryHeaderOut.Name := Rec."Type ID";
                        InterfaceEntryHeaderOut.INSERT(true);
                    end;
                OrtecKStoreInterfaceSetup."RA Payment/Refund Request":
                    begin
                        OrtecKStoreInterfaceSetup.TESTFIELD("RA Payment/Refund Response");
                        InterfaceEntryHeaderOut.INIT();
                        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
                        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
                        InterfaceEntryHeaderOut."Interface Code" := OrtecKStoreInterfaceSetup."RA Payment/Refund Response";
                        InterfaceEntryHeaderOut."Source No." := Rec."Source No.";
                        InterfaceEntryHeaderOut."E-Mail" := 'NOK';
                        InterfaceEntryHeaderOut.Name := Rec."Type ID";
                        InterfaceEntryHeaderOut.INSERT(true);
                    end;
            end;
            //<< HEI.06
        end;
    end;

    local procedure GetOrtecInterfaceSetup();
    begin
        if not OrtecInterfaceSetupRead then
            if OrtecKStoreInterfaceSetup.GET() then;
        OrtecInterfaceSetupRead := true;
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
        GetOrtecInterfaceSetup();
        CLEAR(OrderVatAmount);

        SalesHeader.RESET();
        SalesHeader.SETRANGE(SalesHeader."Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETRANGE("External Document No.", OrderNo);
        if SalesHeader.FINDFIRST() then begin
            SalesHeader.CALCFIELDS(Amount, "Amount Including VAT");

            /*
            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::Order);
            SalesLine.SETRANGE("Document No.",SalesHeader."No.");
            SalesLine.CALCSUMS(Amount,"Amount Including VAT");
            */
        end else
            ERROR(Err001, OrderNo);

        SalesHeaderRO.RESET();
        SalesHeaderRO.SETRANGE(SalesHeaderRO."Document Type", SalesHeaderRO."Document Type"::"Return Order");
        SalesHeaderRO.SETRANGE("External Document No.", OrderNo);
        if SalesHeaderRO.FINDFIRST() then begin
            SalesHeaderRO.CALCFIELDS(Amount, "Amount Including VAT");
            /*
            SalesLineRO.RESET;
            SalesLineRO.SETRANGE("Document Type",SalesLineRO."Document Type"::Order);
            SalesLineRO.SETRANGE("Document No.",SalesHeaderRO."No.");
            SalesLineRO.CALCSUMS(Amount,"Amount Including VAT");
            */
        end;


        OrderVatAmount := (SalesHeader."Amount Including VAT" - SalesHeader.Amount) - (SalesHeaderRO."Amount Including VAT" - SalesHeaderRO.Amount);
        OrderAmount := SalesHeader."Amount Including VAT" - SalesHeaderRO."Amount Including VAT";
        if (OrderVatAmount <> SalesHeader."Doc. Amount VAT FND") or (OrderAmount <> SalesHeader."Doc. Amount Incl. VAT FND") then
            exit(true);
        exit(false);

    end;

    local procedure CheckSOExist(ExtOrderNo: Code[20]);
    var
        SalesHeader: Record "Sales Header";
        Err001: Label 'Sales Order %1 already exist!';
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Err002: Label 'Posted Sales Invoice %1 already exist!';
    begin
        /*
        GetOrtecInterfaceSetup;
        SalesHeader.RESET;
        SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Order);
        SalesHeader.SETRANGE("No.",OrtecKStoreInterfaceSetup."Sales Order Prefix" + ExtOrderNo);
        IF SalesHeader.FINDFIRST THEN
          ERROR(Err001,OrtecKStoreInterfaceSetup."Sales Order Prefix" + ExtOrderNo);
        
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE("No.",OrtecKStoreInterfaceSetup."Sales Order Prefix" + ExtOrderNo);
        IF SalesInvoiceHeader.FINDFIRST THEN
          ERROR(Err002,OrtecKStoreInterfaceSetup."Sales Order Prefix" + ExtOrderNo);
        */

    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterValidateEvent', 'Latitude Coordinate FND', false, false)]
    local procedure T18OnAfterValidateLatitude(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer);
    var
        SalesPrice: Record "Sales Price";
    begin
        /*
        //HEI.02>>
        GetOrtecInterfaceSetup;
        IF OrtecKStoreInterfaceSetup."SO Update Interface" <> '' THEN BEGIN
          IF STRLEN(FORMAT(Rec."Latitude Coordinate")) <> 5 THEN
             ERROR(Err001);
        END;
        //HEI.02<<
        */

    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterValidateEvent', 'Longitude Coordinate FND', false, false)]
    local procedure T18OnAfterValidateLongitude(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer);
    var
        Longitude: Integer;
    begin
        /*
        //HEI.02>>
        GetOrtecInterfaceSetup;
        IF OrtecKStoreInterfaceSetup."SO Update Interface" <> '' THEN BEGIN
          IF STRLEN(FORMAT(Rec."Longitude Coordinate")) <> 7 THEN
             ERROR(Err001);
        END;
        //HEI.02<<
        */

    end;

    [EventSubscriber(ObjectType::Table, 50148, 'OnAfterValidateEvent', 'Item No', false, false)]
    local procedure T50148OnAfterValidateItemNo(var Rec: Record "Sales Rep Budget/Target FND"; var xRec: Record "Sales Rep Budget/Target FND"; CurrFieldNo: Integer);
    var
        SalesPrice: Record "Sales Price";
    begin
        //HEI.03>>
        GetOrtecInterfaceSetup();
        SalesPrice.RESET();
        SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"Customer Price Group");
        SalesPrice.SETRANGE("Sales Code", OrtecKStoreInterfaceSetup."Customer Price Group Code");
        SalesPrice.SETRANGE("Item No.", Rec."Item No");
        SalesPrice.SETFILTER("Starting Date", '<>%1|>%2', 0D, TODAY);
        SalesPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, TODAY);
        if SalesPrice.FINDFIRST() then
            Rec."Unit Price" := SalesPrice."Unit Price";
        //HEI.03<<
    end;

    local procedure CheckDuplicateSalesOrder(ExternalDocNo: Code[35]; DocumentType: Option "Order","Return Order");
    var
        SalesHeader: Record "Sales Header";
        Error01: Label 'External Document No. %1 already exist for Sales Order %2.';
        SalesHeader2: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Error02: Label 'External Document No. %1 already exist for Posted Sales Invoice %2.';
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        Error03: Label 'External Document No. %1 already exist for Posted Sales Credit Memo %2.';
    begin
        //HEI.05>>
        SalesHeader2.RESET();
        SalesHeader2.SETRANGE("External Document No.", ExternalDocNo);
        SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::"Return Order");
        if SalesHeader2.FINDFIRST() and (SalesHeader2."External Document No." <> '') then
            ERROR(Error01, ExternalDocNo, SalesHeader2."No.");

        SalesHeader.RESET();
        SalesHeader.SETRANGE("External Document No.", ExternalDocNo);
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        if SalesHeader.FINDFIRST() and (SalesHeader."External Document No." <> '') and
          (DocumentType <> DocumentType::"Return Order")
        then
            ERROR(Error01, ExternalDocNo, SalesHeader."No.");

        SalesCrMemoHeader.RESET();
        SalesCrMemoHeader.SETRANGE("External Document No.", ExternalDocNo);
        if SalesCrMemoHeader.FINDFIRST() and (SalesCrMemoHeader."External Document No." <> '') then
            ERROR(Error03, ExternalDocNo, SalesCrMemoHeader."No.");

        SalesInvoiceHeader.RESET();
        SalesInvoiceHeader.SETRANGE("External Document No.", ExternalDocNo);
        if SalesInvoiceHeader.FINDFIRST() and (SalesInvoiceHeader."External Document No." <> '') then
            ERROR(Error02, ExternalDocNo, SalesInvoiceHeader."No.");
        //HEI.05<<
    end;

    procedure CreateRAPaymentJournal(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        GenJournalLine: Record "Gen. Journal Line";
        Route: Record Route107FDW; //BC Upgrade SHUKLP03 -DIT table
        LineNo: Integer;
        InterfaceEntryLine: Record "Interface Entry Line INT";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        GenJournalTemplate: Record "Gen. Journal Template";
        BillToCustomer: Record Customer;
        GenJournalBatch: Record "Gen. Journal Batch";
        Error01: Label 'Payment Document No. %1 already exists.';
        GenJournalLine2: Record "Gen. Journal Line";
        Error02: Label 'Payment Document No. %1 is already posted.';
        GLEntry: Record "G/L Entry";
        LogisticsSetup107FDWR: Record LogisticsSetup107FDW; //BC Upgrade SHUKLP03 - DIT table
        GenJournalBatchRec: Record "Gen. Journal Batch"; //BC Upgrade SHUKLP03 
    begin
        //>> HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019
        GetOrtecInterfaceSetup();
        //Route.GET(InterfaceEntryHeader."External Contract No.");
        LogisticsSetup107FDWR.GET(); //BC Upgrade SHUKLP03
        Route.SETRANGE(Driver, InterfaceEntryHeader."External Contract No.");
        if Route.FINDFIRST() then begin
            //BC Upgrade SHUKLP03 >> Created new batch as per Driver of Route table.
            LogisticsSetup107FDWR.TESTFIELD("Cash Payment Journal");
            GenJournalBatchRec.RESET();
            GenJournalBatchRec.SETRANGE("Journal Template Name", LogisticsSetup107FDWR."Cash Payment Journal");
            GenJournalBatchRec.SETRANGE(Name, Route.Driver);
            If not GenJournalBatchRec.FINDFIRST() then Begin
                GenJournalBatchRec.Init();
                GenJournalBatchRec."Journal Template Name" := LogisticsSetup107FDWR."Cash Payment Journal";
                GenJournalBatchRec.Name := Route.Driver;
                GenJournalBatchRec."Bal. Account Type" := GenJournalBatch."Bal. Account Type"::"G/L Account";
                GenJournalBatchRec."Bal. Account No." := OrtecKStoreInterfaceSetup."Bal. Account No.";
                GenJournalBatchRec.INSERT();
            End
            //BC Upgrade SHUKLP03 << Created new batch as per Driver of Route table.
        end;
        GenJournalTemplate.GET(LogisticsSetup107FDWR."Cash Payment Journal");//HEI.05 //BC Upgrade SHUKLP03

        CLEAR(LineNo);
        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Batch Name", Route.Driver); //BC Upgrade SHUKLP03 - Route.Driver is used as batch name
        GenJournalLine.SETRANGE("Journal Template Name", LogisticsSetup107FDWR."Cash Payment Journal"); //BC Upgrade SHUKLP03
        if GenJournalLine.FINDLAST() then
            LineNo := GenJournalLine."Line No.";

        GenJournalLine.RESET();
        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Source Code", GenJournalTemplate."Source Code");//HEI.05
        GenJournalLine.VALIDATE("Journal Template Name", LogisticsSetup107FDWR."Cash Payment Journal"); //BC Upgrade SHUKLP03
        GenJournalLine.VALIDATE("Journal Batch Name", Route.Driver); //BC Upgrade SHUKLP03 - Route.Driver is used as batch name
        GenJournalBatch.GET(LogisticsSetup107FDWR."Cash Payment Journal", Route.Driver); //BC Upgrade SHUKLP03
        GenJournalLine.VALIDATE("Line No.", LineNo + 10000);
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET() then begin
            //Duplicate checks
            GenJournalLine2.RESET();
            GenJournalLine2.SETRANGE("Journal Template Name", LogisticsSetup107FDWR."Cash Payment Journal"); //BC Upgrade SHUKLP03
            GenJournalLine2.SETRANGE("Journal Batch Name", Route.Driver); //BC Upgrade SHUKLP03 - Route.Driver is used as batch name
            GenJournalLine2.SETRANGE("Document No.", 'P' + InterfaceEntryHeader."Source No.");
            if GenJournalLine2.FINDFIRST() then
                ERROR(Error01, 'P' + InterfaceEntryHeader."Source No.");

            GLEntry.RESET();
            GLEntry.SETRANGE("Journal Templ. Name", LogisticsSetup107FDWR."Cash Payment Journal"); //BC Upgrade SHUKLP03
            GLEntry.SETRANGE("Journal Batch Name", Route.Driver); //BC Upgrade SHUKLP03 - Route.Driver is used as batch name
            GLEntry.SETRANGE("Document No.", 'P' + InterfaceEntryHeader."Source No.");
            if GLEntry.FINDFIRST() then
                ERROR(Error02, 'P' + InterfaceEntryHeader."Source No.");
            if InterfaceEntryLine."Type ID" = OrtecKStoreInterfaceSetup."Payment Prefix" then begin
                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
                GenJournalLine.VALIDATE("Document No.", 'P' + InterfaceEntryHeader."Source No.");
                GenJournalLine.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
                GenJournalLine.VALIDATE("Bal. Account Type", GenJournalBatch."Bal. Account Type");
                GenJournalLine.VALIDATE("Bal. Account No.", GenJournalBatch."Bal. Account No.");
                if BillToCustomer.GET(InterfaceEntryHeader."Sell-to Customer No.") then;
                GenJournalLine.VALIDATE("Account No.", BillToCustomer."Bill-to Customer No.");
                GenJournalLine.VALIDATE("Amount (LCY)", -InterfaceEntryLine."Line Amount");
                //amount to be calculated
                GenJournalLine.VALIDATE("Driver Code HNK FND", Route.Driver);  //BC Upgrade SHUKLP03 
                SalesInvoiceHeader.RESET();
                SalesInvoiceHeader.SETRANGE("Your Reference", InterfaceEntryHeader."Source No.");
                if SalesInvoiceHeader.FINDFIRST() then begin
                    GenJournalLine."Applies-to Doc. Type" := GenJournalLine."Applies-to Doc. Type"::Invoice;
                    GenJournalLine."Applies-to Doc. No." := SalesInvoiceHeader."No."; //posted invoice should have the same no like the Sales Invoice
                end else begin
                    GenJournalLine."Applies-to Doc. Type" := GenJournalLine."Applies-to Doc. Type"::" ";
                    GenJournalLine."Applies-to Doc. No." := '';
                end;
                if GenJournalLine."Amount (LCY)" <> 0 then
                    GenJournalLine.INSERT(true);

            end else if InterfaceEntryLine."Type ID" = OrtecKStoreInterfaceSetup."Refund Prefix" then begin
                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Refund);
                GenJournalLine.VALIDATE("Document No.", 'R' + InterfaceEntryHeader."Source No.");
                GenJournalLine.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
                GenJournalLine.VALIDATE("Bal. Account Type", GenJournalBatch."Bal. Account Type");
                GenJournalLine.VALIDATE("Bal. Account No.", GenJournalBatch."Bal. Account No.");
                if BillToCustomer.GET(InterfaceEntryHeader."Sell-to Customer No.") then;
                GenJournalLine.VALIDATE("Account No.", BillToCustomer."Bill-to Customer No.");
                GenJournalLine.VALIDATE("Amount (LCY)", InterfaceEntryLine."Line Amount");
                //amount to be calculated
                GenJournalLine.VALIDATE("Driver Code HNK FND", Route.Driver);  //BC Upgrade SHUKLP03 
                SalesCrMemoHeader.RESET();
                SalesCrMemoHeader.SETRANGE("Your Reference", InterfaceEntryHeader."Source No.");
                if SalesCrMemoHeader.FINDFIRST() then begin
                    GenJournalLine."Applies-to Doc. Type" := GenJournalLine."Applies-to Doc. Type"::"Credit Memo";
                    GenJournalLine."Applies-to Doc. No." := SalesCrMemoHeader."No."; //posted invoice should have the same no like the Sales Invoice
                end else begin
                    GenJournalLine."Applies-to Doc. Type" := GenJournalLine."Applies-to Doc. Type"::" ";
                    GenJournalLine."Applies-to Doc. No." := '';
                end;
                if GenJournalLine."Amount (LCY)" <> 0 then
                    GenJournalLine.INSERT(true);
            end;
        end;
        //<< HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019
    end;

    local procedure GetAditionalAmountExclAmt(AmountInclVAT: Decimal; SalesHeader: Record "Sales Header"): Decimal;
    var
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        VATPostingSetup: Record "VAT Posting Setup";
        GLAccount: Record "G/L Account";
    begin
        //>> HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019
        GetOrtecInterfaceSetup();
        GLAccount.GET(OrtecKStoreInterfaceSetup."RA SO G/L Account Difference");
        VATPostingSetup.GET(SalesHeader."VAT Bus. Posting Group", GLAccount."VAT Prod. Posting Group");
        exit(AmountInclVAT / (1 + (VATPostingSetup."VAT %" / 100)));
        //<< HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019
    end;

    local procedure AssignQtyForitemCharge(SalesHeader: Record "Sales Header");
    var
        SalesLine: Record "Sales Line";
        ItemChargeAssignmentSales: Record "Item Charge Assignment (Sales)";
    begin
        //>> HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019
        //COMMIT;
        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::"Charge (Item)");
        if SalesLine.FINDSET() then
            repeat

                //    ItemChargeAssignmentSales.RESET;
                //    ItemChargeAssignmentSales.SETRANGE("Document Type",SalesLine."Document Type");
                //    ItemChargeAssignmentSales.SETRANGE("Document No.",SalesLine."Document No.");
                //    ItemChargeAssignmentSales.SETRANGE("Document Line No.",SalesLine."Line No.");
                //    ItemChargeAssignmentSales.SETRANGE("Item Charge No.",SalesLine."No.");
                //    IF ItemChargeAssignmentSales.FINDFIRST THEN BEGIN
                //      ItemChargeAssignmentSales.VALIDATE("Qty. to Assign",SalesLine.Quantity);
                //      ItemChargeAssignmentSales.MODIFY(TRUE);
                //    END;
                //SetCurrFieldNo(SalesLine,SalesLine,SalesLine.FIELDNO(Quantity));
                //HEI.02>>
                SalesLine.SetCurrFieldNo(SalesLine.FIELDNO(Quantity));
                SalesLine.VALIDATE(Quantity, SalesLine.Quantity);
                SalesLine.SetCurrFieldNo(SalesLine.FIELDNO("Location Code"));
                SalesLine.VALIDATE("Location Code", SalesLine."Location Code");
            //HEI.02<<
            //    SalesLine.MODIFY;
            until SalesLine.NEXT() = 0;
        //>> HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019
    end;

    local procedure FefoTrackingOrderLines(SalesHeader: Record "Sales Header");
    var
        SalesLineReserve: Codeunit "Sales Line-Reserve";
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        FEFOTrac: Codeunit GenFunctions108FDW;  // BC Upgrade SHUKLP03 <<

        HeinekenInterfaceBCUpgrade: Codeunit "Heineken Interface BC Upgrade";
    begin
        //>> HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019
        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETFILTER("No.", '<>%1', '');
        SalesLine.SETFILTER("Quantity (Base)", '>%1', 0);
        SalesLine.SETRANGE("Job Contract Entry No.", 0);
        SalesLine2.COPY(SalesLine);
        if SalesLine.FINDSET() then
            repeat
                SalesLine2 := SalesLine;
                //  SalesLineReserve.ShowConfirmationMessage(true); //BC Upgrade GUNREM01 Commented 
                HeinekenInterfaceBCUpgrade.ShowConfirmationMessage(true); //BC Upgrade GUNREM01 added
                                                                          //  SalesLineReserve.FEFOTracking(SalesLine2, '', 0);  //BC Upgrade GUNREM01 DIT Function
                FEFOTrac.AssignFEFOTracking(SalesLine2);

            until SalesLine.NEXT() = 0;
        //<< HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019
    end;

    local procedure InsertNewSOLine(SalesHeader: Record "Sales Header");
    var
        SalesLine: Record "Sales Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        ReleaseSalesDocument: Codeunit "Release Sales Document";
        MaxOrderDiffAmtLCY: Decimal;
        DiffUnitPrice: Decimal;
        Error001: Label 'The Difference between the Doc. Amount Incl VAT %1 and Total Amount incl VAT %2 is bigger than the allowed limit %3!';
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
        //>> HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019
        CLEAR(DiffUnitPrice);
        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::"G/L Account");
        SalesLine.DELETEALL(true);

        GetOrtecInterfaceSetup();
        GeneralLedgerSetup.GET();
        OrtecKStoreInterfaceSetup.TESTFIELD("RA SO G/L Account Difference");
        OrtecKStoreInterfaceSetup.TESTFIELD("Max Order Difference Amt.");
        if SalesHeader."Currency Code" <> '' then begin
            CurrencyExchangeRate.RESET();
            CurrencyExchangeRate.SETRANGE("Currency Code", SalesHeader."Currency Code");
            CurrencyExchangeRate.SETFILTER("Starting Date", '<=%1', TODAY);
            if CurrencyExchangeRate.FINDLAST() then
                MaxOrderDiffAmtLCY := OrtecKStoreInterfaceSetup."Max Order Difference Amt." / CurrencyExchangeRate."Relational Exch. Rate Amount";
        end else
            MaxOrderDiffAmtLCY := OrtecKStoreInterfaceSetup."Max Order Difference Amt.";

        if (SalesHeader."Doc. Amount Incl. VAT FND" <> 0) and (SalesHeader."Doc. Amount VAT FND" <> 0) then begin
            SalesHeader.CALCFIELDS("Amount Including VAT", Amount);
            if ABS((SalesHeader."Doc. Amount Incl. VAT FND" - SalesHeader."Amount Including VAT")) > 0 then
                if ABS((SalesHeader."Doc. Amount Incl. VAT FND" - SalesHeader."Amount Including VAT")) <= MaxOrderDiffAmtLCY then begin
                    DiffUnitPrice := GetAditionalAmountExclAmt(SalesHeader."Doc. Amount Incl. VAT FND" - SalesHeader."Amount Including VAT", SalesHeader);
                    ReleaseSalesDocument.Reopen(SalesHeader);//HEI.02
                    SalesLine.INIT();
                    SalesLine.VALIDATE("Document Type", SalesHeader."Document Type");
                    SalesLine.VALIDATE("Document No.", SalesHeader."No.");
                    SalesLine.VALIDATE("Line No.", 1);
                    SalesLine.INSERT(true);
                    SalesLine.VALIDATE(Type, SalesLine.Type::"G/L Account");
                    SalesLine.VALIDATE("No.", OrtecKStoreInterfaceSetup."RA SO G/L Account Difference");
                    SalesLine.VALIDATE(Quantity, 1);
                    SalesLine.VALIDATE("Unit Price", DiffUnitPrice);

                    SalesLine.MODIFY(true);
                end else
                    ERROR(Error001, SalesHeader."Doc. Amount Incl. VAT FND", SalesHeader."Amount Including VAT", MaxOrderDiffAmtLCY);
        end;
        //<< HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019
    end;

    procedure ProcessRASalesOrder(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
    begin
        //>> HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019
        GetOrtecInterfaceSetup();
        if InterfaceEntryHeader."Type ID" = OrtecKStoreInterfaceSetup."Sales Order Prefix" then
            CreateRASalesOrders(InterfaceEntryHeader, DocumentType::Order)
        else
            if InterfaceEntryHeader."Type ID" = OrtecKStoreInterfaceSetup."Sales Return Order Prefix" then
                CreateRASalesOrders(InterfaceEntryHeader, DocumentType::"Return Order");
        //<< HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019
    end;

    procedure CreateRASalesOrders(var InterfaceEntryHeader: Record "Interface Entry Header INT"; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order");
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        Route: Record Route107FDW;   //BC Upgrade SHUKLP03 DIT table
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesOrderExist: Boolean;
        ReleaseSalesDocument: Codeunit "Release Sales Document";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        LineNo: Integer;
        SalesHook: Codeunit SalesHook101FDW;  // BC Upgrade SHUKLP03 <<
    begin
        //>> HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019
        //Sales Order Creation
        GetOrtecInterfaceSetup();
        GeneralLedgerSetup.GET();
        CLEAR(SalesOrderExist);


        if not DocumentExists(DocumentType, InterfaceEntryHeader."Source No.") then begin
            SalesHeader.RESET();
            SalesHeader.SETRANGE("External Document No.", InterfaceEntryHeader."Source No.");
            if not SalesHeader.FINDFIRST() then begin

                SalesHeader.INIT();
                SalesHeader.VALIDATE("Document Type", DocumentType);
                SalesHeader.VALIDATE("No.", '');
                SalesHeader.INSERT(true);
                SalesOrderExist := true;

                SalesHeader.SetHideValidationDialog(true);
                SalesHeader.VALIDATE("Posting No.", InterfaceEntryHeader."Source No.");

                if InterfaceEntryHeader."Currency Code" <> GeneralLedgerSetup."LCY Code" then
                    SalesHeader.VALIDATE("Currency Code", InterfaceEntryHeader."Currency Code");
                SalesHeader.VALIDATE("Sell-to Customer No.", InterfaceEntryHeader."Sell-to Customer No.");
                SalesHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                if InterfaceEntryHeader."Currency Code" <> GeneralLedgerSetup."LCY Code" then
                    SalesHeader.VALIDATE("Currency Code", InterfaceEntryHeader."Currency Code");
                SalesHeader.VALIDATE("Document Date", InterfaceEntryHeader."Posting Date");
                //HEI.09 >>
                SalesHeader.VALIDATE("Order Date", InterfaceEntryHeader."Posting Date");
                //HEI.09>>
                SalesHeader.VALIDATE("Shipment Date", InterfaceEntryHeader."Posting Date");
                //SalesHeader.VALIDATE(Route,InterfaceEntryHeader."External Contract No.");
                SalesHeader.VALIDATE("Your Reference", UPPERCASE(InterfaceEntryHeader."Your Reference"));
                //Route.GET(InterfaceEntryHeader."External Contract No.");
                Route.SETRANGE(Driver, InterfaceEntryHeader."External Contract No.");
                if Route.FINDFIRST() then begin
                    Route.TESTFIELD("Van Sales Route FND");
                    // Route.TESTFIELD("Salesperson/Purchaser Code"); HEI.05
                    Route.TESTFIELD(Driver);
                    Route.TESTFIELD(Vehicle);
                    Route.TESTFIELD("Shipping Location");
                end;
                SalesHeader.VALIDATE("Route 107FDW", Route.Code);
                SalesHeader.VALIDATE("Location Code", Route."Shipping Location");
                SalesHeader.VALIDATE("Log Driver 107FDW", Route.Driver);
                SalesHeader.VALIDATE("Vehicle Code 101FDW", Route.Vehicle);
                SalesHeader."RA SO FND" := TRUE;  // BC Upgrade SHUKLP03

                //SalesHeader.VALIDATE("Shipment status",SalesHeader."Shipment status"::Invoice);
                SalesHeader.VALIDATE("Doc. Amount Incl. VAT FND", InterfaceEntryHeader."Amount Including VAT");
                SalesHeader.VALIDATE("Doc. Amount VAT FND", InterfaceEntryHeader."VAT Amount");
                SalesHeader.VALIDATE("External Document No.", InterfaceEntryHeader."Source No.");
                if DocumentType = DocumentType::Order then
                    SalesHeader.Ship := true;
                if DocumentType = DocumentType::"Return Order" then
                    SalesHeader.Receive := true;
                SalesHeader.Invoice := true;
                SalesHeader.MODIFY(true);
                InterfaceEntryLine.RESET();
                InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                LineNo := 10000;
                if InterfaceEntryLine.FINDSET() then
                    repeat
                        if not SalesLine.GET(SalesHeader."Document Type", SalesHeader."No.", InterfaceEntryLine."Source Line No.") then begin
                            SalesLine.INIT();
                            SalesLine.VALIDATE("Document Type", DocumentType);
                            SalesLine.VALIDATE("Document No.", SalesHeader."No.");
                            SalesLine.VALIDATE("Line No.", LineNo);
                            SalesLine.INSERT(true);
                            LineNo := LineNo + 10000;
                        end;

                        SalesLine.VALIDATE("Sell-to Customer No.", InterfaceEntryLine."Sell-to Customer No.");
                        SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                        SalesLine.VALIDATE("No.", InterfaceEntryLine."No.");
                        SalesLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                        SalesLine.VALIDATE("Unit of Measure Code", InterfaceEntryLine."Unit of Measure Code");
                        SalesLine.MODIFY(true);
                    until InterfaceEntryLine.NEXT() = 0;
                SalesHook.RecalculateAttatchedSalesOrderLines(SalesHeader); // BC Upgrade SHUKLP03
                InsertNewSOLine(SalesHeader);//GAP07
                if SalesHeader.Status = SalesHeader.Status::Released then
                    ReleaseSalesDocument.Reopen(SalesHeader);//HEI.02
                AssignQtyForitemCharge(SalesHeader);
                if DocumentType <> DocumentType::"Return Order" then
                    FefoTrackingOrderLines(SalesHeader);
            end else begin
                if SalesHeader.Status = SalesHeader.Status::Released then
                    ReleaseSalesDocument.Reopen(SalesHeader);//HEI.02
                AssignQtyForitemCharge(SalesHeader);
                if DocumentType <> DocumentType::"Return Order" then
                    FefoTrackingOrderLines(SalesHeader);
            end;
            CODEUNIT.RUN(CODEUNIT::"Release Sales Document", SalesHeader);
            CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);
        end;//order already exist
        //<< HEI.04 FDD-HT736 IBM GUNERE01 15.09.2019
    end;

    local procedure DocumentExists(DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; SourceNo: Code[20]): Boolean;
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        //>> HEI.06
        case DocumentType of
            DocumentType::Order:
                begin
                    SalesInvoiceHeader.RESET();
                    SalesInvoiceHeader.SETRANGE("External Document No.", SourceNo);
                    if SalesInvoiceHeader.FINDFIRST() then
                        exit(true)
                    else
                        exit(false);
                end;
            DocumentType::"Return Order":
                begin
                    SalesCrMemoHeader.RESET();
                    SalesCrMemoHeader.SETRANGE("External Document No.", SourceNo);
                    if SalesCrMemoHeader.FINDFIRST() then
                        exit(true)
                    else
                        exit(false);
                end;
        end;
        //<< HEI.06
    end;

    //  [EventSubscriber(ObjectType::Table, 50002, 'OnAfterInsertEvent', '', false, false)]
    [EventSubscriber(ObjectType::Table, 58002, 'OnAfterInsertEvent', '', false, false)]

    local procedure T50002OnAfterInsert(var Rec: Record "Interface Entry Line INT"; RunTrigger: Boolean);
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceEntryHeader: Record "Interface Entry Header INT";
    begin
        //>> HEI.07
        GeneralInterfaceSetup.GET();
        if USERID = GeneralInterfaceSetup."Interface Job Queue User ID" then begin
            GetOrtecInterfaceSetup();
            if InterfaceEntryHeader.GET(Rec."Header Entry No.") then
                if not (InterfaceEntryHeader."Interface Code" in [OrtecKStoreInterfaceSetup."RA Payment/Refund Request"
                                               ]) then
                    exit;

            InterfaceEntryHeader."Type ID" := Rec."Type ID";
            InterfaceEntryHeader.MODIFY();
        end;
        //<< HEI.07
    end;

    // BC Upgrade SHUKLP03 >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::SalesSubs101FDW, OnBeforeSalesTestFieldOnAttachedLineType, '', false, false)]
    local procedure OnBeforeSalesTestFieldOnAttachedLineType(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        SalesH: Record "Sales Header";
    begin
        IF SalesH.GET(SalesLine."Document Type", SalesLine."Document No.") then
            IF SalesH."RA SO FND" THEN
                IsHandled := true;
    end;
    // BC Upgrade SHUKLP03 <<

}

