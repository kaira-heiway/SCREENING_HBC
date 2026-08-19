codeunit 58093 "Integration Framework WS"
{
    //BC Upgrade GUNREM01 Old ID-50160
    // version HEI.03

    // HEI.01 CHG2084921 IBM KUMARN15 29.10.2020
    //   # New codeunit created
    // HEI.02 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables
    // HEI.03 CHG2222895 IBM SISUM01 28.12.2023 HB3628-FM Promo Interface enhancements
    //   # add promotions with Sales_Type “Customer Discount Group”

    //BC Upgrade GUNREM01 
    // # Replaced dotnet varibales to XML varibales
    // # Commenetd DIT Code 
    // # Modified code using XML Variables

    // BC Upgrade MISHRS14 >>
    // Changed table name from "FM Discount Charges" to "FM Discount Charges FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    TableNo = "Integration Framework Log INT";

    trigger OnRun();
    var
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
    begin
        // NOTE: If to be used for others interfaces also then seperate processing logic
        IntFrameworkLogG := Rec;
        LegacyFuturMasterIntSetup.GET;
        case IntFrameworkLogG."Interface Code" of
            LegacyFuturMasterIntSetup."Customer Discount Req":
                begin
                    ProcessCustomerDiscounts;
                end;
        end;
        Rec := IntFrameworkLogG;
    end;

    var
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';
        ErrorMsg: Label 'Error Code: %1, Error Text: %2, Call Stack Trace: %3.';
        JobQueueProcessMsg: Label 'Process Entry No. %1.';
        IntFrameworkLogG: Record "Integration Framework Log INT";
        MissingNodeErr: Label '%1 node missing from XML.';
        TextMissingErr: Label 'Text missing for node %1 in XML.';
        SalesTyepErr: Label 'Sales Type must be ''Customer''.';
        EndDateErr: Label 'End date must be after %1.';
        StartDateErr: Label 'Start Date cannot be empty for Customer %1 Item %2.';
        EndDateErr2: Label 'End Date %1 must be after Start Date %2.';
        LineDiscountErr: Label 'Line Discount should have a value if Min Qty is %1.';
        FMDiscountError: Label 'FM Discount Charge already exist for Item No. %1.';
        FMSalesTypeError: Label 'Sales Type must be Customer or Customer Discount Group. The current value is %1.';

    procedure SendFMCustomerDiscounts(var ReqResMessage: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
        IntFrameworkLog: Record "Integration Framework Log INT";
        RequestFileOStream: OutStream;
    begin
        LegacyFuturMasterIntSetup.GET;
        LegacyFuturMasterIntSetup.TESTFIELD("Customer Discount Req");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."Customer Discount Req");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        IntFrameworkLog.INIT;
        IntFrameworkLog."Entry No" := 0;
        IntFrameworkLog."Interface Code" := LegacyFuturMasterIntSetup."Customer Discount Req";
        IntFrameworkLog."Request Sync. Date/Time" := CURRENTDATETIME;
        IntFrameworkLog."Request File".CREATEOUTSTREAM(RequestFileOStream);
        ReqResMessage.WRITE(RequestFileOStream);
        IntFrameworkLog."Processing Codeunit" := CODEUNIT::"Integration Framework WS";  // NOTE: If to be used for others interfaces also then seperate processing logic
        IntFrameworkLog."Call Type" := InterfaceSetup."Call Type";
        IntFrameworkLog."Job Queue Category Code" := '';
        IntFrameworkLog.INSERT(true);

        DoProcessing(IntFrameworkLog);

        CLEAR(RequestFileOStream); //HEI.02
    end;

    local procedure DoProcessing(var IntFrameworkLog: Record "Integration Framework Log INT");
    var
        ErrorOStream: OutStream;
        JobQueueEntry: Record "Job Queue Entry";
    begin
        if IntFrameworkLog."Call Type" = IntFrameworkLog."Call Type"::Synchronous then begin
            COMMIT;
            if CODEUNIT.RUN(IntFrameworkLog."Processing Codeunit", IntFrameworkLog) then begin
                IntFrameworkLog.FIND;
                IntFrameworkLog.Status := IntFrameworkLog.Status::Processed;
                IntFrameworkLog.MODIFY;
            end else begin
                IntFrameworkLog.FIND;
                IntFrameworkLog.Status := IntFrameworkLog.Status::Error;
                IntFrameworkLog."Error Message".CREATEOUTSTREAM(ErrorOStream);
                ErrorOStream.WRITETEXT(STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK));
                IntFrameworkLog."Display Error" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                IntFrameworkLog.MODIFY;
            end;
        end else begin
            JobQueueEntry.INIT;
            JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
            JobQueueEntry."Object ID to Run" := CODEUNIT::"Intgrtn. Frmwk. Async. Process";
            JobQueueEntry."Record ID to Process" := IntFrameworkLog.RECORDID;
            JobQueueEntry.Description := STRSUBSTNO(JobQueueProcessMsg, IntFrameworkLog."Entry No");
            JobQueueEntry."Job Queue Category Code" := IntFrameworkLog."Job Queue Category Code";
            CODEUNIT.RUN(CODEUNIT::"Job Queue - Enqueue", JobQueueEntry);

            IntFrameworkLog."Job Queue Entry ID" := JobQueueEntry.ID;
            IntFrameworkLog.MODIFY;
        end;

        CLEAR(ErrorOStream); //HEI.02
    end;

    local procedure ProcessCustomerDiscounts();
    var
        RequestFileIStream: InStream;
        //BC Upgrade GUNREM01 >>
        // RequestXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // XMLNamespaceMgr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNamespaceManager";
        // DiscountsXmlNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
        // DiscountXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        RequestXmlDocument: XmlDocument;
        XMLNamespaceMgr: XmlNamespaceManager;
        DiscountsXmlNodeList: XmlNodeList;
        DiscountXmlNode: XmlNode;
        TempXmlNode: XmlNode;
        //BC Upgrade GUNREM01 <<
        Customer: Record Customer;
        Item: Record Item;

        SalesCode: Code[20];
        SourceNo: Code[20];
        StartingDate: Date;
        EndingDate: Date;
        MinimumQuantity: Decimal;
        UnitofMeasure: Code[10];
        Discount: Decimal;
        FMDiscountCharges: Record "FM Discount Charges FND";
        ItemChargeNo: Code[20];
        //BC Upgrade GUNREM01 DIT tables >>
        // DrinkDiscountGroup: Record "Drink Discount Group";
        // SalesDiscountItemCharge: Record "Sales Discount Item Charge";
        // SalesDiscountItemCharge2: Record "Sales Discount Item Charge";
        //BC Upgrade GUNREM01 DIT tables <<
        SalesTypeOptionCust: Text;
        SalesTypeOptionCustDiscGr: Text;
        SalesType: Text;
    begin
        // NOTE: If to be used for others interfaces also then seperate processing logic
        IntFrameworkLogG.CALCFIELDS("Request File");
        IntFrameworkLogG."Request File".CREATEINSTREAM(RequestFileIStream);
        //BC Upgrade GUNREM01 >>
        // RequestXmlDocument := RequestXmlDocument.XmlDocument;
        // RequestXmlDocument.Load(RequestFileIStream);
        RequestXmlDocument := XmlDocument.Create();
        XmlDocument.ReadFrom(RequestFileIStream, RequestXmlDocument);
        //BC Upgrade GUNREM01 <<

        //BC Upgrade GUNREM01 >>
        // XMLNamespaceMgr := XMLNamespaceMgr.XmlNamespaceManager(RequestXmlDocument.DocumentElement.OwnerDocument.NameTable);
        // XMLNamespaceMgr.AddNamespace('ns1', 'urn:microsoft-dynamics-schemas/codeunit/LegacyFMInterfaces');
        // DiscountsXmlNodeList := RequestXmlDocument.SelectNodes('/ns1:CustomerDiscount/Discounts', XMLNamespaceMgr);
        // if ISNULL(DiscountsXmlNodeList) then
        //     ERROR(MissingNodeErr, 'Discounts');
        XMLNamespaceMgr.NameTable := RequestXmlDocument.NameTable;
        XMLNamespaceMgr.AddNamespace('ns1', 'urn:microsoft-dynamics-schemas/codeunit/LegacyFMInterfaces');
        if not RequestXmlDocument.SelectNodes('/ns1:CustomerDiscount/Discounts', DiscountsXmlNodeList) then
            Error(MissingNodeErr, 'Discounts');
        //BC Upgrade GUNREM01 <<

        //HEI.03>>
        //BC Upgrade GUNREM01 DIT code >>
        // SalesTypeOptionCust := FORMAT(SalesDiscountItemCharge."Sales Type"::Customer);
        // SalesTypeOptionCustDiscGr := FORMAT(SalesDiscountItemCharge."Sales Type"::"Customer Discount Group");
        //BC Upgrade GUNREM01 DIT code <<
        //HEI.03<<

        foreach DiscountXmlNode in DiscountsXmlNodeList do begin
            CLEAR(SalesCode);
            CLEAR(SourceNo);
            CLEAR(StartingDate);
            CLEAR(EndingDate);
            CLEAR(MinimumQuantity);
            CLEAR(UnitofMeasure);
            CLEAR(Discount);

            CLEAR(SalesType);//HEI.03>>

            //BC Upgrade GUNREM01 >>
            // TempXmlNode := DiscountXmlNode.SelectSingleNode('SalesType');
            // if ISNULL(TempXmlNode) then
            //     ERROR(MissingNodeErr, 'SalesType');
            DiscountXmlNode.SelectSingleNode('SalesType', TempXmlNode);
            if not TempXmlNode.IsXmlElement then
                Error(MissingNodeErr, 'SalesType');
            //BC Upgrade GUNREM01 <<
            //HEI.03>>
            /*
            IF TempXmlNode.InnerText <> 'Customer' THEN
              ERROR(SalesTyepErr);
            */
            //BC Upgrade GUNREM01 >>
            //  SalesType := TempXmlNode.InnerText;
            SalesType := TempXmlNode.AsXmlElement().InnerText;
            //BC Upgrade GUNREM01 <<

            if ((STRPOS(SalesType, SalesTypeOptionCust) = 0) or (STRLEN(SalesType) <> STRLEN(SalesTypeOptionCust)))
              and
              ((STRPOS(SalesType, SalesTypeOptionCustDiscGr) = 0) or (STRLEN(SalesType) <> STRLEN(SalesTypeOptionCustDiscGr)))
            then
                ERROR(FMSalesTypeError, SalesType);
            //HEI.03<<
            //BC Upgrade GUNREM01 >>
            // TempXmlNode := DiscountXmlNode.SelectSingleNode('SalesCode');
            // if ISNULL(TempXmlNode) then
            //     ERROR(MissingNodeErr, 'SalesCode');
            // SalesCode := TempXmlNode.InnerText;
            DiscountXmlNode.SelectSingleNode('SalesCode', TempXmlNode);
            if not TempXmlNode.IsXmlElement then
                Error(MissingNodeErr, 'SalesCode');
            SalesCode := TempXmlNode.AsXmlElement().InnerText;
            //BC Upgrade GUNREM01 <<
            //HEI.03>>

            //BC Upgrade GUNREM01 >>
            // if (STRPOS(SalesType, SalesTypeOptionCustDiscGr) <> 0) and
            //   (STRLEN(SalesType) = STRLEN(SalesTypeOptionCustDiscGr))
            // then
            //     DrinkDiscountGroup.GET(DrinkDiscountGroup."Source Type"::Customer, SalesCode)
            // else
            //     //HEI.03<<
            //     Customer.GET(SalesCode);
            //BC Upgrade GUNREM01 <<

            // TempXmlNode := DiscountXmlNode.SelectSingleNode('ItemCode');
            // if ISNULL(TempXmlNode) then
            //     ERROR(MissingNodeErr, 'ItemCode');
            // SourceNo := TempXmlNode.InnerText;
            // Item.GET(SourceNo);

            // TempXmlNode := DiscountXmlNode.SelectSingleNode('EndDate');
            // if ISNULL(TempXmlNode) then
            //     ERROR(MissingNodeErr, 'EndDate');
            // EndingDate := ReturnDate(TempXmlNode.InnerText);
            // if EndingDate <= WORKDATE then
            //     ERROR(EndDateErr, WORKDATE);

            // TempXmlNode := DiscountXmlNode.SelectSingleNode('StartDate');
            // if ISNULL(TempXmlNode) then
            //     ERROR(MissingNodeErr, 'StartDate');
            // if TempXmlNode.InnerText = '' then
            //     ERROR(StartDateErr, SalesCode, SourceNo);
            // StartingDate := ReturnDate(TempXmlNode.InnerText);

            // if EndingDate < StartingDate then
            //     ERROR(EndDateErr2, EndingDate, StartingDate);

            // TempXmlNode := DiscountXmlNode.SelectSingleNode('UoM');
            // if not ISNULL(TempXmlNode) then
            //     UnitofMeasure := TempXmlNode.InnerText;

            // TempXmlNode := DiscountXmlNode.SelectSingleNode('MinQty');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(MinimumQuantity, TempXmlNode.InnerText);

            // TempXmlNode := DiscountXmlNode.SelectSingleNode('LineDiscount');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         EVALUATE(Discount, TempXmlNode.InnerText);

            DiscountXmlNode.SelectSingleNode('ItemCode', TempXmlNode);
            if not TempXmlNode.IsXmlElement then
                ERROR(MissingNodeErr, 'ItemCode');
            SourceNo := TempXmlNode.AsXmlElement().InnerText;
            Item.GET(SourceNo);

            DiscountXmlNode.SelectSingleNode('EndDate', TempXmlNode);
            if not TempXmlNode.IsXmlElement then
                ERROR(MissingNodeErr, 'EndDate');
            EndingDate := ReturnDate(TempXmlNode.AsXmlElement().InnerText);
            if EndingDate <= WORKDATE then
                ERROR(EndDateErr, WORKDATE);

            DiscountXmlNode.SelectSingleNode('StartDate', TempXmlNode);
            if not TempXmlNode.IsXmlElement then
                ERROR(MissingNodeErr, 'StartDate');
            if TempXmlNode.AsXmlElement().InnerText = '' then
                ERROR(StartDateErr, SalesCode, SourceNo);
            StartingDate := ReturnDate(TempXmlNode.AsXmlElement().InnerText);

            if EndingDate < StartingDate then
                ERROR(EndDateErr2, EndingDate, StartingDate);

            DiscountXmlNode.SelectSingleNode('UoM', TempXmlNode);
            if TempXmlNode.IsXmlElement then
                UnitofMeasure := TempXmlNode.AsXmlElement().InnerText;

            DiscountXmlNode.SelectSingleNode('MinQty', TempXmlNode);
            if TempXmlNode.IsXmlElement then
                if TempXmlNode.AsXmlElement().InnerText <> '' then
                    EVALUATE(MinimumQuantity, TempXmlNode.AsXmlElement().InnerText);

            DiscountXmlNode.SelectSingleNode('LineDiscount', TempXmlNode);
            if TempXmlNode.IsXmlElement then
                if TempXmlNode.AsXmlElement().InnerText <> '' then
                    EVALUATE(Discount, TempXmlNode.AsXmlElement().InnerText);
            //BC Upgrade GUNREM01 <<



            if (Discount = 0) and (MinimumQuantity <> 0) then
                ERROR(LineDiscountErr, MinimumQuantity);

            FMDiscountCharges.SETRANGE("Item No.", Item."No.");
            if not FMDiscountCharges.FINDFIRST then
                ERROR(FMDiscountError, Item."No.");
            ItemChargeNo := FMDiscountCharges."Item Charge No.";

            //BC Upgrade GUNREM01 Dependency with DIT >>
            // SalesDiscountItemCharge.RESET;
            // SalesDiscountItemCharge.SETRANGE("Calculate per", SalesDiscountItemCharge."Calculate per"::Item);
            // //HEI.03>>
            // /*
            // SalesDiscountItemCharge.SETRANGE("Sales Type",SalesDiscountItemCharge."Sales Type"::Customer);
            // SalesDiscountItemCharge.SETRANGE("Sales Code",Customer."No.");
            // */
            // SalesDiscountItemCharge.SETFILTER("Sales Type", '%1|%2', SalesDiscountItemCharge."Sales Type"::Customer, SalesDiscountItemCharge."Sales Type"::"Customer Discount Group");
            // SalesDiscountItemCharge.SETRANGE("Sales Code", SalesCode);
            // //HEI.03<<

            // SalesDiscountItemCharge.SETRANGE("Source Type", SalesDiscountItemCharge."Source Type"::Item);
            // SalesDiscountItemCharge.SETRANGE("Source No.", Item."No.");
            // SalesDiscountItemCharge.SETRANGE("Starting Date", StartingDate);
            // SalesDiscountItemCharge.SETRANGE("FM Discount", true);
            // if SalesDiscountItemCharge.FINDFIRST then begin
            //     //Deletion
            //     if ((Discount = 0) or (FORMAT(Discount) = '')) and
            //         ((MinimumQuantity = 0) or (FORMAT(MinimumQuantity) = ''))
            //     then
            //         SalesDiscountItemCharge.DELETE(true)
            //     else begin
            //         //Modification
            //         if SalesDiscountItemCharge."Minimum Quantity" <> MinimumQuantity then
            //             SalesDiscountItemCharge.VALIDATE("Minimum Quantity", MinimumQuantity);
            //         if ItemChargeNo <> '' then
            //             SalesDiscountItemCharge.VALIDATE("No.", ItemChargeNo);
            //         if SalesDiscountItemCharge."Ending Date" <> EndingDate then
            //             SalesDiscountItemCharge.VALIDATE("Ending Date", EndingDate);
            //         if SalesDiscountItemCharge."Unit of Measure Code" <> UnitofMeasure then
            //             SalesDiscountItemCharge.VALIDATE("Unit of Measure Code", UnitofMeasure);
            //         if SalesDiscountItemCharge.Percentage <> Discount then
            //             SalesDiscountItemCharge.VALIDATE(Percentage, Discount);
            //         SalesDiscountItemCharge.MODIFY(true);
            //     end;
            // end else
            //     if not (((Discount = 0) or (FORMAT(Discount) = '')) and
            //         ((MinimumQuantity = 0) or (FORMAT(MinimumQuantity) = '')))
            //     then begin
            //         //Creation
            //         SalesDiscountItemCharge2.INIT;
            //         SalesDiscountItemCharge2.VALIDATE("Calculate per", SalesDiscountItemCharge2."Calculate per"::Item);
            //         //HEI.03>>
            //         //SalesDiscountItemCharge2.VALIDATE("Sales Type",SalesDiscountItemCharge2."Sales Type"::Customer);
            //         //SalesDiscountItemCharge2.VALIDATE("Sales Code",Customer."No.");
            //         if (STRPOS(SalesType, SalesTypeOptionCust) <> 0) and (STRLEN(SalesType) = STRLEN(SalesTypeOptionCust)) then
            //             SalesDiscountItemCharge2.VALIDATE("Sales Type", SalesDiscountItemCharge2."Sales Type"::Customer)
            //         else
            //             SalesDiscountItemCharge2.VALIDATE("Sales Type", SalesDiscountItemCharge2."Sales Type"::"Customer Discount Group");
            //         SalesDiscountItemCharge2.VALIDATE("Sales Code", SalesCode);
            //         //HEI.03<<
            //         SalesDiscountItemCharge2.VALIDATE("Source Type", SalesDiscountItemCharge2."Source Type"::Item);
            //         SalesDiscountItemCharge2.VALIDATE("Source No.", Item."No.");
            //         SalesDiscountItemCharge2.VALIDATE("Starting Date", StartingDate);
            //         SalesDiscountItemCharge2.VALIDATE("Ending Date", EndingDate);
            //         SalesDiscountItemCharge2.VALIDATE("Minimum Quantity", MinimumQuantity);
            //         SalesDiscountItemCharge2.VALIDATE("Unit of Measure Code", UnitofMeasure);
            //         SalesDiscountItemCharge2.VALIDATE(Type, SalesDiscountItemCharge2.Type::"Charge (Item)");
            //         if ItemChargeNo <> '' then
            //             SalesDiscountItemCharge2.VALIDATE("No.", ItemChargeNo);
            //         SalesDiscountItemCharge2.VALIDATE("Extra Charge Type", SalesDiscountItemCharge2."Extra Charge Type"::"Price %");
            //         SalesDiscountItemCharge2.VALIDATE(Percentage, Discount);
            //         SalesDiscountItemCharge2.VALIDATE("FM Discount", true);
            //         SalesDiscountItemCharge2."Using Qty. (Base)" := false;
            //         SalesDiscountItemCharge2.INSERT(true);
            //     end;
            //BC Upgrade GUNREM01 Dependency with DIT >>
        end;

        //HEI.02>>
        CLEAR(RequestFileIStream);
        CLEAR(RequestXmlDocument);
        CLEAR(XMLNamespaceMgr);
        CLEAR(DiscountsXmlNodeList);
        CLEAR(DiscountXmlNode);
        CLEAR(TempXmlNode);
        //HEI.02<<

    end;

    local procedure ReturnDate(DateText: Text): Date;
    var
        MM: Integer;
        DD: Integer;
        YY: Integer;
        ParsedDate: Date;
    begin
        if DateText = '' then
            exit(0D);
        EVALUATE(MM, SELECTSTR(1, CONVERTSTR(DateText, '/', ',')));
        EVALUATE(DD, SELECTSTR(2, CONVERTSTR(DateText, '/', ',')));
        EVALUATE(YY, SELECTSTR(3, CONVERTSTR(DateText, '/', ',')));
        exit(DMY2DATE(DD, MM, YY));
    end;
}

