codeunit 58039 "SEM Interface Mgmt."
{
    //Heilite Navision Old Id - 50218

    // version HEI.08

    // HEI.01 CHG2115040 HB2342 IBM GAVANM01 16.08.2021 #SEM Customer Integration
    //   # New object created for SEM Interface
    // HEI.02 CHG2132531 INC3788002 IBM GAVANM01 22.10.2021 B2B flag issue
    //   # code changed
    // HEI.03 CHG2178366-HB3189 IBM SOICAD02 22.11.2022 Customer Masterdata interface to DOT change
    //   #New field Customer Promotion
    // HEI.04 CHG2178366-HB3189 IBM COSTES04 17.01.2023 Customer Masterdata interface to DOT change
    //   # Bug fix
    // HEI.05 CHG2178366-HB3189 IBM COSTES04 15.02.2023 Customer Masterdata interface to DOT change
    //   # Bug fix
    // HEI.06 CHG2187475 IBM COSTES04 09.05.2023  SEM Sales Information
    //   # New interface Send Sales Information
    // HEI.07 CHG2178366-HB3189 IBM COSTES04 10.05.2023 Customer Masterdata interface to DOT change
    //   # Move to log unprocessed customer entries
    //   # skip populate entry no. on autoincrement field
    // HEI.08 CHG2207891 IBM COSTES04 23.06.2023  SEM Sales Information
    //   # Code Improvment

    // BC Upgrade PATELP08>>
    // Changed name of table from "B2B Customer Included/Excluded" to "B2B Cust Inc/Exc FND"
    // BC Upgrade PATELP08<<

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "SEM Customer Included/Excluded" to "SEM Customer Included
    // BC UPGRADE PATELS08 <<

    trigger OnRun();
    begin
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        SEMInterfaceSetup: Record "SEM Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
        CreationDateFilter: Date;
        DocumentNoFilter: Text;
        DocumentTypeFilter: Option " ",Invoice,"Credit Memo";
        CustomerFilter: Record Customer;
        SEMInterfaceSetupRead: Boolean;
        GeneralLedgerSetupRead: Boolean;
        NoOfDocProcessed: Integer;

    procedure ProcessSEMCustomerOutbound(CustomerToSend: Record Customer; CustomerNew: Record Customer; CustomerOld: Record Customer; CheckFields: Boolean);
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        //check the setup
        if not SEMInterfaceSetup.GET or not SEMInterfaceSetup."Enable SEM Interface" then
            exit;
        SEMInterfaceSetup.TESTFIELD("SEM Customer Interface");
        InterfaceSetup.GET(SEMInterfaceSetup."SEM Customer Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if CustomerIsValid(CustomerToSend, CustomerNew, CustomerOld, CheckFields) then begin
            InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CreateSEMCustomerOutbound(CustomerToSend);
        end;
    end;

    procedure CreateSEMCustomerOutbound(Customer: Record Customer);
    var
        InterfaceEntryHeaderVIPOut: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPOut: Record "Interface Entry Line VIP INT";
        EntryNo: Integer;
        BillToCustomer: Record Customer;
        Country: Record "Country/Region";
        CustAttr: Record "Customer Attributes FND";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ServiceZone: Record "Service Zone";
        SalesRoutes: Record "Sales Routes FND";
        BusinessSegment: Record "Business Segment FND";
        BusinessOrganizationalSegment: Record "Business Org Segment FND";
        CustomerType: Record "Customer Type FND";
        CustomerSubType: Record "Customer Sub-Type FND";
        LocalCustomerSubType: Record "Local Customer Sub-Type FND";
        ClassificationFND: Record ClassificationFND;
        B2BCustomerIncludedExcluded: Record "B2B Cust Inc/Exc FND";
        //TempDrinkPromotionRelation : Record "Drink Promotion Relation" temporary; //BC Upograde VAMSIU01 - Drinkit
        LineNo: Integer;
        TempDrinkPromotionRelation: Record GroupRelation105FDW temporary; //BC UPGRADE KUMARR78 ++

    begin
        CLEAR(InterfaceEntryHeaderVIPOut);
        CLEAR(InterfaceEntryLineVIPOut);
        EntryNo := 0;
        //HEI.05>>
        InterfaceEntryHeaderVIP.RESET;
        InterfaceEntryHeaderVIP.SETRANGE("Interface Code", SEMInterfaceSetup."SEM Customer Interface");
        InterfaceEntryHeaderVIP.SETRANGE(Status, InterfaceEntryHeaderVIP.Status::Pending);
        InterfaceEntryHeaderVIP.SETRANGE("Source Type", DATABASE::Customer);
        InterfaceEntryHeaderVIP.SETRANGE("Source No.", Customer."No.");
        if not InterfaceEntryHeaderVIP.ISEMPTY then begin
            InterfaceEntryHeaderVIP.LOCKTABLE;
            InterfaceFrameworkMgtVIP.LogErrorInterfaceEntries(InterfaceEntryHeaderVIP);
        end;
        //HEI.07<<

        InterfaceEntryHeaderVIPOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIPOut."Interface Code" := SEMInterfaceSetup."SEM Customer Interface";
        InterfaceEntryHeaderVIPOut.Direction := InterfaceEntryHeaderVIPOut.Direction::Outbound;
        InterfaceEntryHeaderVIPOut."Source Type" := DATABASE::Customer;
        InterfaceEntryHeaderVIPOut."Source No." := Customer."No.";
        InterfaceEntryHeaderVIPOut."Msg. Sender Business System ID" := TENANTID;
        InterfaceEntryHeaderVIPOut."Msg. Recv. Business System ID" := COMPANYNAME;
        InterfaceEntryHeaderVIPOut.INSERT(true);

        InterfaceEntryHeaderVIPOut."Sell-to Customer No." := Customer."SEM Id FND";
        InterfaceEntryHeaderVIPOut.Name := Customer.Name;
        InterfaceEntryHeaderVIPOut.Name2 := Customer."Name 2";
        InterfaceEntryHeaderVIPOut.Address := Customer.Address;
        InterfaceEntryHeaderVIPOut.Name3 := Customer."Address 2";
        InterfaceEntryHeaderVIPOut."Your Reference" := Customer.City;
        InterfaceEntryHeaderVIPOut."Location Code" := Customer."Country/Region Code";
        if Country.GET(Customer."Country/Region Code") then
            InterfaceEntryHeaderVIPOut.Name4 := Country.Name;
        InterfaceEntryHeaderVIPOut."Buy-from Vendor No." := Customer."Post Code";
        InterfaceEntryHeaderVIPOut.County := Customer.County;
        InterfaceEntryHeaderVIPOut."Phone No." := Customer."Phone No.";
        InterfaceEntryHeaderVIPOut."Vendor Shipment No." := Customer."Fax No.";
        InterfaceEntryHeaderVIPOut.Comment := Customer."E-Mail";
        InterfaceEntryHeaderVIPOut."Bill-to Customer No." := Customer."Bill-to Customer No.";
        if BillToCustomer.GET(Customer."Bill-to Customer No.") then begin
            InterfaceEntryHeaderVIPOut.Name5 := BillToCustomer.Name;
            InterfaceEntryHeaderVIPOut."External Document No." := BillToCustomer."VAT Registration No.";

            CustAttr.RESET;
            if CustAttr.GET(BillToCustomer."No.") then
                InterfaceEntryHeaderVIPOut."Pay-to Vendor No." := CustAttr."License No.";

            if B2BCustomerIncludedExcluded.GET(Customer."Bill-to Customer No.") and B2BCustomerIncludedExcluded.Included then
                InterfaceEntryHeaderVIPOut.Closed := true;
        end;

        InterfaceEntryHeaderVIPOut."Bin Code" := COPYSTR(Customer."Latitude Coordinate FND", 1, 20);
        InterfaceEntryHeaderVIPOut.EAN := COPYSTR(Customer."Longitude Coordinate FND", 1, 20);
        InterfaceEntryHeaderVIPOut."Prod. Order Line No." := Customer.Blocked.AsInteger();
        InterfaceEntryHeaderVIPOut."Prod. Order Item No." := Customer."Blocked Reason Code FND";
        InterfaceEntryHeaderVIPOut."Currency Code" := Customer."Payment Method Code";
        InterfaceEntryHeaderVIPOut."Payment Terms Code" := Customer."Payment Terms Code";
        //InterfaceEntryHeaderVIPOut.Blocked := Customer."Credit Limit";//BC Upgrade VAMSIU01 blocked temporarily assuming it is drinkit
        InterfaceEntryHeaderVIPOut.Amount := Customer."Credit Limit (LCY)";
        InterfaceEntryHeaderVIPOut."Shipment Method Code" := Customer."Salesperson Code";
        if SalespersonPurchaser.GET(Customer."Salesperson Code") then
            InterfaceEntryHeaderVIPOut.Name6 := SalespersonPurchaser.Name;
        InterfaceEntryHeaderVIPOut."Zone Code" := Customer."Service Zone Code";
        if ServiceZone.GET(Customer."Service Zone Code") then
            InterfaceEntryHeaderVIPOut.Name7 := ServiceZone.Description;
        InterfaceEntryHeaderVIPOut."Type ID" := Customer."Sales Routes FND";
        if SalesRoutes.GET(Customer."Sales Routes FND") then
            InterfaceEntryHeaderVIPOut."Delivery Method" := SalesRoutes.Description;

        CustAttr.RESET;
        if CustAttr.GET(Customer."No.") then begin
            InterfaceEntryHeaderVIPOut.ApproverID := CustAttr."Name 3";
            InterfaceEntryHeaderVIPOut.Description := CustAttr."Name 4";
            InterfaceEntryHeaderVIPOut."Address 3" := CustAttr."Street 3";
            InterfaceEntryHeaderVIPOut."Address 4" := CustAttr."Street 4";
            InterfaceEntryHeaderVIPOut."Address 5" := CustAttr."Street 5";
            InterfaceEntryHeaderVIPOut."Legal Entity" := CustAttr."House No. 1";
            InterfaceEntryHeaderVIPOut."Version No." := CustAttr."House Supplement 2";
            InterfaceEntryHeaderVIPOut."Global No." := CustAttr."Business Segment";
            if BusinessSegment.GET(CustAttr."Business Segment") then
                InterfaceEntryHeaderVIPOut."Business Segment Name" := BusinessSegment.Name;
            InterfaceEntryHeaderVIPOut."Legal Form" := CustAttr."Business OrganizationalSegment";
            if BusinessOrganizationalSegment.GET(CustAttr."Business OrganizationalSegment") then
                InterfaceEntryHeaderVIPOut."Business Seg. Org. Name" := BusinessOrganizationalSegment.Name;
            InterfaceEntryHeaderVIPOut."Customer Type" := CustAttr."Customer Type";
            if CustomerType.GET(CustAttr."Customer Type") then
                InterfaceEntryHeaderVIPOut."Customer Type Name" := CustomerType.Name;
            InterfaceEntryHeaderVIPOut."Customer Subtype" := CustAttr."Customer Sub-Type";
            if CustomerSubType.GET(CustAttr."Customer Sub-Type") then
                InterfaceEntryHeaderVIPOut."Customer Subtype Name" := CustomerSubType.Name;
            InterfaceEntryHeaderVIPOut."Category Code" := CustAttr."Local Customer Sub-Type";
            if LocalCustomerSubType.GET(CustAttr."Local Customer Sub-Type") then
                InterfaceEntryHeaderVIPOut.Name8 := LocalCustomerSubType.Name;
            InterfaceEntryHeaderVIPOut."External Contract No." := CustAttr.Classification;
            if ClassificationFND.GET(CustAttr.Classification) then
                InterfaceEntryHeaderVIPOut.Name9 := ClassificationFND.Description;
            InterfaceEntryHeaderVIPOut."Flag for Deletion" := CustAttr."Flag for Deletion";
        end;
        InterfaceEntryHeaderVIPOut.MODIFY;
        //BC Upgrade VAMSIU01>> blocked temporarily assuming it is drinkit
        // if SEMInterfaceSetup."Enable Promotion Interface" then begin
        //   GetCustomerPromotion(Customer."No.",TempDrinkPromotionRelation);
        //   TempDrinkPromotionRelation.RESET;
        //   if TempDrinkPromotionRelation.FINDSET(false,false) then
        //     repeat
        //       LineNo += 1;
        //       InterfaceEntryLineVIPOut."Header Entry No." := InterfaceEntryHeaderVIPOut."Entry No.";
        //       InterfaceEntryLineVIPOut."Entry No." := LineNo;
        //       InterfaceEntryLineVIPOut."No." := TempDrinkPromotionRelation.Code;
        //       InterfaceEntryLineVIPOut.INSERT(true);
        //     until TempDrinkPromotionRelation.NEXT = 0;
        // end;
        //BC Upgrade VAMSIU01<<blocked temporarily assuming it is drinkit
        //HEI.05<<
        //BC UPGRADE KUMARR78 >> 13-05-2025
        if SEMInterfaceSetup."Enable Promotion Interface" then begin
            GetCustomerPromotion(Customer."No.", TempDrinkPromotionRelation);
            TempDrinkPromotionRelation.RESET;
            if TempDrinkPromotionRelation.FINDSET(false) then
                repeat
                    LineNo += 1;
                    InterfaceEntryLineVIPOut."Header Entry No." := InterfaceEntryHeaderVIPOut."Entry No.";
                    InterfaceEntryLineVIPOut."Entry No." := LineNo;
                    InterfaceEntryLineVIPOut."No." := TempDrinkPromotionRelation."No.";
                    InterfaceEntryLineVIPOut.INSERT(true);
                until TempDrinkPromotionRelation.NEXT = 0;
        end;
        //BC UPGRADE KUMARR78 << 13-05-2026

    end;

    procedure CustomerIsValid(CustomerToSend: Record Customer; CustomerNew: Record Customer; CustomerOld: Record Customer; CheckFields: Boolean): Boolean;
    var
        Customer: Record Customer;
        CustomersIncludeExclude: Record "SEM Cust Inc/Exc FND";
    begin
        CustomersIncludeExclude.RESET;
        Customer.RESET;

        Customer.SETRANGE("No.", CustomerToSend."No.");
        if not CustomersIncludeExclude.GET(CustomerToSend."No.") then
            Customer.SETFILTER("Account Group FND", SEMInterfaceSetup."Customer Acc Group Filter");
        if Customer.FINDFIRST then begin
            if CustomersIncludeExclude.Code <> '' then
                if CustomersIncludeExclude.Excluded then
                    exit(false);
        end else
            exit(false);

        if CheckFields then
            if (CustomerNew.Name = CustomerOld.Name) and
            (CustomerNew."Name 2" = CustomerOld."Name 2") and
            (CustomerNew.Address = CustomerOld.Address) and
            (CustomerNew."Address 2" = CustomerOld."Address 2") and
            (CustomerNew.City = CustomerOld.City) and
            (CustomerNew."Country/Region Code" = CustomerOld."Country/Region Code") and
            (CustomerNew."Post Code" = CustomerOld."Post Code") and
            (CustomerNew.County = CustomerOld.County) and
            (CustomerNew."Phone No." = CustomerOld."Phone No.") and
            (CustomerNew."Fax No." = CustomerOld."Fax No.") and
            (CustomerNew."E-Mail" = CustomerOld."E-Mail") and
            (CustomerNew."Bill-to Customer No." = CustomerOld."Bill-to Customer No.") and
            (CustomerNew."VAT Registration No." = CustomerOld."VAT Registration No.") and
            (CustomerNew."Latitude Coordinate FND" = CustomerOld."Latitude Coordinate FND") and
            (CustomerNew."Longitude Coordinate FND" = CustomerOld."Longitude Coordinate FND") and
            (CustomerNew.Blocked = CustomerOld.Blocked) and
            (CustomerNew."Blocked Reason Code FND" = CustomerOld."Blocked Reason Code FND") and
            (CustomerNew."Payment Terms Code" = CustomerOld."Payment Terms Code") and
            (CustomerNew."Payment Method Code" = CustomerOld."Payment Method Code") and
            //(CustomerNew."Credit Limit" = CustomerOld."Credit Limit") and //BC Upgrade VAMSIU01 blocked temporarily assuming it is drinkit
            (CustomerNew."Credit Limit (LCY)" = CustomerOld."Credit Limit (LCY)") then
                exit(false);

        exit(true);
    end;
    //BC UPGRADE KUMARR78 <<
    local procedure GetCustomerPromotion(CustomerNo: Code[20]; var TempDrinkPromotionRelation: Record GroupRelation105FDW temporary): Text;
    var
        DrinkPromotionRelation: Record GroupRelation105FDW;
        CustPromotion: Text;
        RecordNo: Integer;
        TotalRecords: Integer;
        Cust2: Record Customer;
        Cust: Record Customer;
    begin
        //HEI.03>>
        if not Cust.GET(CustomerNo) then
            exit;
        DrinkPromotionRelation.SETRANGE(Type, DrinkPromotionRelation.Type::Customer);//HEI.04
        if Cust."Bill-to Customer No." = '' then begin
            DrinkPromotionRelation.SETRANGE("No.", CustomerNo);
            if DrinkPromotionRelation.FINDSET(false) then
                repeat
                    TempDrinkPromotionRelation.TRANSFERFIELDS(DrinkPromotionRelation);
                    if TempDrinkPromotionRelation.INSERT then;
                until DrinkPromotionRelation.NEXT = 0;
        end;

        if Cust."Bill-to Customer No." <> '' then
            if Cust2.GET(Cust."Bill-to Customer No.") then begin
                DrinkPromotionRelation.SETRANGE("No.", Cust."Bill-to Customer No.");
                if DrinkPromotionRelation.FINDSET(false) then
                    repeat
                        TempDrinkPromotionRelation.TRANSFERFIELDS(DrinkPromotionRelation);
                        if TempDrinkPromotionRelation.INSERT then;
                    until DrinkPromotionRelation.NEXT = 0;
            end;
        //HEI.05>>
        //TempDrinkPromotionRelation.RESET;
        //TotalRecords := TempDrinkPromotionRelation.COUNT;
        //IF TempDrinkPromotionRelation.FINDSET(FALSE,FALSE) THEN
        //  REPEAT
        //    RecordNo += 1;
        //    CustPromotion += TempDrinkPromotionRelation.Code;
        //    IF RecordNo < TotalRecords THEN
        //      CustPromotion += ';';
        //  UNTIL TempDrinkPromotionRelation.NEXT = 0;
        //EXIT(CustPromotion);
        //HEI.05<<
        //HEI.03<<
    end;
    //BC UPGRADE KUMARR78 >>
    //BC Upgrade VAMSIU01>> - Blocked Drinkit Dependency
    // local procedure GetCustomerPromotion(CustomerNo : Code[20];var TempDrinkPromotionRelation : Record "Drink Promotion Relation" temporary) : Text;
    // var
    //     //DrinkPromotionRelation : Record "Drink Promotion Relation";//BC Upgrade VAMSIU01
    //     CustPromotion : Text;
    //     RecordNo : Integer;
    //     TotalRecords : Integer;
    //     Cust2 : Record Customer;
    //     Cust : Record Customer;
    // begin
    //     //HEI.03>>
    //     if not Cust.GET(CustomerNo) then
    //       exit;
    //     DrinkPromotionRelation.SETRANGE("Source Type",DrinkPromotionRelation."Source Type"::Customer);//HEI.04
    //     if Cust."Bill-to Customer No." = '' then begin
    //       DrinkPromotionRelation.SETRANGE("Source No.",CustomerNo);
    //       if DrinkPromotionRelation.FINDSET(false,false) then
    //         repeat
    //           TempDrinkPromotionRelation.TRANSFERFIELDS(DrinkPromotionRelation);
    //           if TempDrinkPromotionRelation.INSERT then;
    //         until DrinkPromotionRelation.NEXT = 0;
    //     end;

    //     if Cust."Bill-to Customer No." <> '' then
    //       if Cust2.GET(Cust."Bill-to Customer No.") then begin
    //         DrinkPromotionRelation.SETRANGE("Source No.",Cust."Bill-to Customer No.");
    //         if DrinkPromotionRelation.FINDSET(false,false) then
    //           repeat
    //             TempDrinkPromotionRelation.TRANSFERFIELDS(DrinkPromotionRelation);
    //             if TempDrinkPromotionRelation.INSERT then;
    //           until DrinkPromotionRelation.NEXT = 0;
    //       end;
    //     //HEI.05>>
    //     //TempDrinkPromotionRelation.RESET;
    //     //TotalRecords := TempDrinkPromotionRelation.COUNT;
    //     //IF TempDrinkPromotionRelation.FINDSET(FALSE,FALSE) THEN
    //     //  REPEAT
    //     //    RecordNo += 1;
    //     //    CustPromotion += TempDrinkPromotionRelation.Code;
    //     //    IF RecordNo < TotalRecords THEN
    //     //      CustPromotion += ';';
    //     //  UNTIL TempDrinkPromotionRelation.NEXT = 0;
    //     //EXIT(CustPromotion);
    //     //HEI.05<<
    //     //HEI.03<<
    // end;
    //BC Upgrade VAMSIU01<< - Blocked Drinkit Dependency

    //BC Upgrade VAMSIU01>> - Blocked Drinkit Dependency

    // [EventSubscriber(ObjectType::Table, 2013763, 'OnAfterInsertEvent', '', false, false)]
    // local procedure OnAfterInsertEventDrinkPromotionRelation(var Rec: Record "Drink Promotion Relation"; RunTrigger: Boolean);
    // var
    //     Cust: Record Customer;
    //     Cust2: Record Customer;
    // begin
    //     //HEI.03>>
    //     if Rec.ISTEMPORARY then
    //         exit;
    //     SEMInterfaceSetup.GET;
    //     //HEI.05>>
    //     if not SEMInterfaceSetup."Enable Promotion Interface" then
    //         exit;
    //     //HEI.05<<
    //     if not Cust.GET(Rec."Source No.") then
    //         exit;
    //     if not CustomerIsValid(Cust, Cust, Cust, false) then begin
    //         CLEAR(Cust);
    //         Cust.SETRANGE("Bill-to Customer No.", Rec."Source No.");
    //         if Cust.FINDFIRST then
    //             ProcessSEMCustomerOutbound(Cust, Cust, Cust, false);
    //     end else
    //         ProcessSEMCustomerOutbound(Cust, Cust, Cust, false);
    //     //HEI.03<<
    // end;



    // [EventSubscriber(ObjectType::Table, 2013763, 'OnAfterModifyEvent', '', false, false)]
    // local procedure OnAfterModifyEventDrinkPromotionRelation(var Rec: Record "Drink Promotion Relation"; var xRec: Record "Drink Promotion Relation"; RunTrigger: Boolean);
    // var
    //     Cust: Record Customer;
    // begin
    //     //HEI.03>>
    //     if Rec.ISTEMPORARY then
    //         exit;
    //     SEMInterfaceSetup.GET;
    //     //HEI.05>>
    //     if not SEMInterfaceSetup."Enable Promotion Interface" then
    //         exit;
    //     //HEI.05<<
    //     if not Cust.GET(Rec."Source No.") then
    //         exit;
    //     if not CustomerIsValid(Cust, Cust, Cust, false) then begin
    //         CLEAR(Cust);
    //         Cust.SETRANGE("Bill-to Customer No.", Rec."Source No.");
    //         if Cust.FINDFIRST then
    //             ProcessSEMCustomerOutbound(Cust, Cust, Cust, false);
    //     end else
    //         ProcessSEMCustomerOutbound(Cust, Cust, Cust, false);
    //     //HEI.03<<
    // end;

    // [EventSubscriber(ObjectType::Table, 2013763, 'OnAfterDeleteEvent', '', false, false)]
    // local procedure OnAfterDeleteEventDrinkPromotionRelation(var Rec: Record "Drink Promotion Relation"; RunTrigger: Boolean);
    // var
    //     Cust: Record Customer;
    // begin
    //     //HEI.03>>
    //     if Rec.ISTEMPORARY then
    //         exit;
    //     SEMInterfaceSetup.GET;
    //     //HEI.05>>
    //     if not SEMInterfaceSetup."Enable Promotion Interface" then
    //         exit;
    //     //HEI.05<<
    //     if not Cust.GET(Rec."Source No.") then
    //         exit;
    //     if not CustomerIsValid(Cust, Cust, Cust, false) then begin
    //         CLEAR(Cust);
    //         Cust.SETRANGE("Bill-to Customer No.", Rec."Source No.");
    //         if Cust.FINDFIRST then
    //             ProcessSEMCustomerOutbound(Cust, Cust, Cust, false);
    //     end else
    //         ProcessSEMCustomerOutbound(Cust, Cust, Cust, false);
    //     //HEI.03<<
    // end;

    //BC Upgrade VAMSIU01<< - Blocked Drinkit Dependency

    //BC Upgrade VAMSIU01>> - Blocked Temporarily 
    // procedure ProcessPostedDocuments();
    // begin
    //     //HEI.06>>
    //     GetSEMInterfaceSetup;
    //     if not SEMInterfaceSetup."Send Sales Information" then
    //         exit;

    //     SEMInterfaceSetup.TESTFIELD("Sales Information Interface");
    //     InterfaceSetup.GET(SEMInterfaceSetup."Sales Information Interface");
    //     if not InterfaceSetup.Enabled then
    //         exit;

    //     CreateAndSendSalesInvoices;
    //     CreateAndSendSalesCreditMemos;
    //     //HEI.06<<
    // end;

    //BC UPGRADE KUMARR78 >> Resolving
    procedure ProcessPostedDocuments();
    begin
        //HEI.06>>
        GetSEMInterfaceSetup();
        if not SEMInterfaceSetup."Send Sales Information" then
            exit;

        SEMInterfaceSetup.TestField("Sales Information Interface");
        InterfaceSetup.Get(SEMInterfaceSetup."Sales Information Interface");
        if not InterfaceSetup.Enabled then
            exit;

        CreateAndSendSalesInvoices();
        CreateAndSendSalesCreditMemos;
        //HEI.06<<
    end;
    //BC UPGRADE KUMARR78 << Resolving

    local procedure GetSEMInterfaceSetup();
    begin
        //HEI.06>>
        if not SEMInterfaceSetupRead then
            SEMInterfaceSetup.Get();
        SEMInterfaceSetupRead := true;
        //HEI.06<<
    end;

    //BC UPGRADE KUMARR78 >> Resolving
    local procedure CreateAndSendSalesInvoices();
    var
        Customer: Record Customer;
        IntegrationFrameworkLog: Record "Integration Framework Log INT";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        TempBigText: BigText;
        LastInvoiceProcessed: DateTime;
        NoOfCustomers: Integer;
        //BC Upgrade VAMSIU01 <<
        OutputStream: OutStream;
        //BC Upgrade VAMSIU01 >>
        // XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        XMLDoc: XmlDocument;
        XMLCurrNode: XmlNode;
        // XMLCurrNode2: XmlNode;//BC UPGRADE KUMARR78 --
        XMLCurrNode2: XmlElement;//BC UPGRADE KUMARR78 ++

    begin
        //HEI.06>>
        //skip sending credit memos when running manually and filters are on credit memos
        if DocumentTypeFilter = DocumentTypeFilter::"Credit Memo" then
            exit;
        GetSEMInterfaceSetup();
        GetGeneralLedgerSetup();
        FilterSalesInvoice(SalesInvoiceHeader);

        SalesInvoiceHeader.SetAutoCalcFields(Amount, "Amount Including VAT");
        if SalesInvoiceHeader.FindSet(false) then
            repeat
                if IsCustomerIncluded(SalesInvoiceHeader."Sell-to Customer No.") then begin
                    if SEMInterfaceSetup."Send Multiple Doc. per File" then begin
                        if NoOfCustomers = 0 then begin
                            CreateInterfaceLogHeader(IntegrationFrameworkLog);
                            CreateResponseXMLMsg(XMLDoc, XMLCurrNode2, 'SEMSalesInformation');
                        end;

                        // CreateResponseDocHeaderMsg(XMLDoc, XMLCurrNode2, SalesInvoiceHeader);//BC UPGRADE KUMARR78 --
                        CreateResponseDocHeaderMsgNew(XMLDoc, XMLCurrNode2, SalesInvoiceHeader);//BC UPGRADE KUMARR78 ++

                        NoOfCustomers := NoOfCustomers + 1;
                        if NoOfCustomers > SEMInterfaceSetup."No. of Documents per File" then begin
                            NoOfCustomers := 0;
                            IntegrationFrameworkLog.CalcFields("Response File");
                            IntegrationFrameworkLog."Response File".CreateOutStream(OutputStream, TextEncoding::UTF16);
                            IntegrationFrameworkLog."Response Date/Time" := CurrentDateTime;

                            // TempBigText.AddText(XMLDoc.AsXmlNode().AsXmlElement().InnerText);//BC UPGRADE KUMARR78 23-05-2026
                            //BC UPGRADE KUMARR78 >> 23-05-2026
                            // TempBigText.Write(OutputStream);
                            // Clear(TempBigText);
                            XMLDoc.WriteTo(OutputStream);
                            //BC UPGRADE KUMARR78 << 23-05-2026

                            IntegrationFrameworkLog.SendMessage();
                        end;
                    end else begin
                        CreateInterfaceLogHeader(IntegrationFrameworkLog);

                        CreateResponseXMLMsg(XMLDoc, XMLCurrNode2, 'SEMSalesInformation');
                        // CreateResponseDocHeaderMsg(XMLDoc, XMLCurrNode2, SalesInvoiceHeader); //BC UPGRADE KUMARR78 --
                        CreateResponseDocHeaderMsgNew(XMLDoc, XMLCurrNode2, SalesInvoiceHeader);//BC UPGRADE KUMARR78 ++


                        IntegrationFrameworkLog.CalcFields("Response File");
                        IntegrationFrameworkLog."Response File".CreateOutStream(OutputStream, TextEncoding::UTF16);
                        IntegrationFrameworkLog."Response Date/Time" := CurrentDateTime;

                        //TempBigText.ADDTEXT(XMLDoc.InnerXml);
                        // TempBigText.AddText(XMLDoc.AsXmlNode().AsXmlElement().InnerText); //BC UPGRADE KUMARR78 23-05-2026
                        //BC UPGRADE KUMARR78 >> 23-05-2026
                        // TempBigText.Write(OutputStream);
                        // Clear(TempBigText);
                        XMLDoc.WriteTo(OutputStream);
                        //BC UPGRADE KUMARR78 << 23-05-2026
                        IntegrationFrameworkLog.Modify();
                        IntegrationFrameworkLog.SendMessage();
                    end;
                    NoOfDocProcessed += 1;
                end;
            until SalesInvoiceHeader.Next() = 0;

        if NoOfCustomers > 0 then begin
            NoOfCustomers := 0;
            IntegrationFrameworkLog.CalcFields("Response File");
            IntegrationFrameworkLog."Response File".CreateOutStream(OutputStream, TextEncoding::UTF16);
            IntegrationFrameworkLog."Response Date/Time" := CurrentDateTime;

            //TempBigText.ADDTEXT(XMLDoc.InnerXml);
            // TempBigText.AddText(XMLDoc.AsXmlNode().AsXmlElement().InnerText);//BC UPGRADE KUMARR78 23-05-2026
            //BC UPGRADE KUMARR78 >> 23-05-2026
            // TempBigText.Write(OutputStream);
            // Clear(TempBigText);
            XMLDoc.WriteTo(OutputStream);
            //BC UPGRADE KUMARR78 << 23-05-2026
            IntegrationFrameworkLog.Modify();
            IntegrationFrameworkLog.SendMessage();
        end;

        //HEI.06<<
    end;


    local procedure CreateAndSendSalesCreditMemos();
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        Customer: Record Customer;
        IntegrationFrameworkLog: Record "Integration Framework Log INT";
        //BC UPGRADE KUMARR78 --
        // XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 --
        //BC UPGRADE KUMARR78 ++
        XMLDoc: XmlDocument;
        XMLCurrNode: XmlNode;
        // XMLCurrNode2: XmlNode; //BC UPGRADE KUMARR78 -- 
        XMLCurrNode2: XmlElement;

        //BC UPGRADE KUMARR78 ++

        OutputStream: OutStream;
        TempBigText: BigText;
        NoOfCustomers: Integer;
        LastInvoiceProcessed: DateTime;
    begin
        //HEI.06>>
        //skip sending credit memos when running manually and filters are on invoices
        if DocumentTypeFilter = DocumentTypeFilter::Invoice then
            exit;
        GetSEMInterfaceSetup;
        GetGeneralLedgerSetup;
        FilterSalesCreditMemo(SalesCrMemoHeader);
        SalesCrMemoHeader.SETAUTOCALCFIELDS(Amount, "Amount Including VAT");
        if SalesCrMemoHeader.FINDSET(false) then
            repeat
                if IsCustomerIncluded(SalesCrMemoHeader."Sell-to Customer No.") then begin
                    if SEMInterfaceSetup."Send Multiple Doc. per File" then begin
                        if NoOfCustomers = 0 then begin
                            CreateInterfaceLogHeader(IntegrationFrameworkLog);
                            CreateResponseXMLMsg(XMLDoc, XMLCurrNode2, 'SEMSalesInformation');
                        end;

                        CreateResponseCreditMemoMsgNew(XMLDoc, XMLCurrNode2, SalesCrMemoHeader);

                        NoOfCustomers := NoOfCustomers + 1;
                        if NoOfCustomers > SEMInterfaceSetup."No. of Documents per File" then begin
                            NoOfCustomers := 0;
                            IntegrationFrameworkLog.CALCFIELDS("Response File");
                            IntegrationFrameworkLog."Response File".CREATEOUTSTREAM(OutputStream, TEXTENCODING::UTF16);
                            IntegrationFrameworkLog."Response Date/Time" := CURRENTDATETIME;

                            //TempBigText.ADDTEXT(XMLDoc.InnerXml);//BC UPGRADE KUMARR78 --
                            // TempBigText.AddText(XMLDoc.AsXmlNode().AsXmlElement().InnerText);//BC UPGRADE KUMARR78 -- 23-05-2026
                            //BC UPGRADE KUMARR78 >> 23-05-2026
                            // TempBigText.Write(OutputStream);
                            // Clear(TempBigText);
                            XMLDoc.WriteTo(OutputStream);
                            //BC UPGRADE KUMARR78 << 23-05-2026
                            IntegrationFrameworkLog.MODIFY;

                            IntegrationFrameworkLog.SendMessage;
                        end;
                    end else begin
                        CreateInterfaceLogHeader(IntegrationFrameworkLog);

                        CreateResponseXMLMsg(XMLDoc, XMLCurrNode2, 'SEMSalesInformation');
                        // CreateResponseCreditMemoMsg(XMLDoc, XMLCurrNode2, SalesCrMemoHeader);//BC UPGRADE KUMARR78 --
                        CreateResponseCreditMemoMsgNew(XMLDoc, XMLCurrNode2, SalesCrMemoHeader);//BC UPGRADE KUMARR78 ++


                        IntegrationFrameworkLog.CALCFIELDS("Response File");
                        IntegrationFrameworkLog."Response File".CREATEOUTSTREAM(OutputStream, TEXTENCODING::UTF16);
                        IntegrationFrameworkLog."Response Date/Time" := CURRENTDATETIME;

                        //TempBigText.ADDTEXT(XMLDoc.InnerXml);//BC UPGRADE KUMARR78 --
                        // TempBigText.AddText(XMLDoc.AsXmlNode().AsXmlElement().InnerText);//BC UPGRADE KUMARR78 -- 23-05-2026
                        //BC UPGRADE KUMARR78 >> 23-05-2026
                        // TempBigText.Write(OutputStream);
                        // Clear(TempBigText);
                        XMLDoc.WriteTo(OutputStream);
                        //BC UPGRADE KUMARR78 << 23-05-2026
                        IntegrationFrameworkLog.MODIFY;
                        IntegrationFrameworkLog.SendMessage;
                    end;
                    NoOfDocProcessed += 1;
                end;
            until SalesCrMemoHeader.NEXT = 0;

        if NoOfCustomers > 0 then begin
            NoOfCustomers := 0;
            IntegrationFrameworkLog.CALCFIELDS("Response File");
            IntegrationFrameworkLog."Response File".CREATEOUTSTREAM(OutputStream, TEXTENCODING::UTF16);
            IntegrationFrameworkLog."Response Date/Time" := CURRENTDATETIME;

            //TempBigText.ADDTEXT(XMLDoc.InnerXml);//BC UPGRADE KUMARR78 --
            // TempBigText.AddText(XMLDoc.AsXmlNode().AsXmlElement().InnerText);//BC UPGRADE KUMARR78 -- 23-05-2026
            //BC UPGRADE KUMARR78 >> 23-05-2026
            // TempBigText.Write(OutputStream);
            // Clear(TempBigText);
            XMLDoc.WriteTo(OutputStream);
            //BC UPGRADE KUMARR78 << 23-05-2026
            IntegrationFrameworkLog.MODIFY;
            IntegrationFrameworkLog.SendMessage;
        end;
        //HEI.06<<
    end;

    local procedure CreateInterfaceLogHeader(var IntegrationFrameworkLog: Record "Integration Framework Log INT");
    begin
        //HEI.06>>
        IntegrationFrameworkLog.Init();
        IntegrationFrameworkLog."Entry No" := 0;
        IntegrationFrameworkLog."Interface Code" := SEMInterfaceSetup."Sales Information Interface";
        IntegrationFrameworkLog."Request Sync. Date/Time" := CurrentDateTime;
        IntegrationFrameworkLog."Call Type" := InterfaceSetup."Call Type";
        IntegrationFrameworkLog.Insert(true);
        //HEI.06<<
    end;

    local procedure GetTaxAmount(Type: Option Invoice,"Credit Memo"; DocumentNo: Code[20]; LineNo: Integer) TotalTax: Decimal;
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesInvoiceLine2: Record "Sales Invoice Line";
    begin
        //HEI.06>>
        if (Type = Type::Invoice) then begin
            SalesInvoiceLine2.SetRange("Document No.", DocumentNo);
            if LineNo <> 0 then
                SalesInvoiceLine2.SetRange("Attached to Line No.", LineNo);
            SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine2.Type::"Charge (Item)");
            // SalesInvoiceLine2.SETRANGE("Item Charge Type", SalesInvoiceLine2."Item Charge Type"::Tax);//BC UPGRADE KUMARR78 --
            SalesInvoiceLine2.SetRange("Attached Line Type 101FDW", SalesInvoiceLine2."Attached Line Type 101FDW"::"TAX 102FDW");//BC UPGRADE KUMARR78 ++

            SalesInvoiceLine2.SetAutoCalcFields();//HEI.08
            if SalesInvoiceLine2.IsEmpty then
                exit;
            if SalesInvoiceLine2.FindSet(false) then
                repeat
                    TotalTax += SalesInvoiceLine2.Amount;
                until SalesInvoiceLine2.Next() = 0;
        end else begin
            SalesCrMemoLine.SetRange("Document No.", DocumentNo);
            if LineNo <> 0 then
                SalesCrMemoLine.SetRange("Attached to Line No.", LineNo);
            SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::"Charge (Item)");
            // SalesCrMemoLine.SETRANGE("Item Charge Type", SalesCrMemoLine."Item Charge Type"::Tax);//BC UPGRADE KUMARR78 --
            SalesCrMemoLine.SetRange("Attached Line Type 101FDW", SalesCrMemoLine."Attached Line Type 101FDW"::"TAX 102FDW");//BC UPGRADE KUMARR78 ++

            SalesCrMemoLine.SetAutoCalcFields();//HEI.08
            if SalesCrMemoLine.IsEmpty then
                exit;
            if SalesCrMemoLine.FindSet(false) then
                repeat
                    TotalTax += SalesCrMemoLine.Amount;
                until SalesCrMemoLine.Next() = 0;
        end;
        //HEI.06<<
    end;

    local procedure GetDepositAmount(Type: Option Invoice,"Credit Memo"; DocumentNo: Code[20]; LineNo: Integer) TotalDeposit: Decimal;
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        //HEI.06>>
        if (Type = Type::Invoice) then begin
            SalesInvoiceLine.Reset();
            SalesInvoiceLine.SetRange("Document No.", DocumentNo);
            if LineNo <> 0 then
                SalesInvoiceLine.SetRange("Attached to Line No.", LineNo);
            // SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::"Charge (Item)");//BC UPGRADE KUMARR78 23-05-2026--
            SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::"G/L Account");//BC UPGRADE KUMARR78 23-05-2026++
            // SalesInvoiceLine.SETRANGE("Item Charge Type", SalesInvoiceLine."Item Charge Type"::Deposit);//BC UPGRADE KUMARR78 --
            SalesInvoiceLine.SetRange("Attached Line Type 101FDW", SalesInvoiceLine."Attached Line Type 101FDW"::"EGM 104FDW"); //BC UPGRADE KUMARR78 ++

            if SalesInvoiceLine.IsEmpty then
                exit;
            SalesInvoiceLine.SetAutoCalcFields();//HEI.08
            if SalesInvoiceLine.FindSet(false) then
                repeat
                    TotalDeposit += SalesInvoiceLine.Amount;
                until SalesInvoiceLine.Next() = 0;
        end else begin
            SalesCrMemoLine.Reset();
            SalesCrMemoLine.SetRange("Document No.", DocumentNo);
            if LineNo <> 0 then
                SalesCrMemoLine.SetRange("Attached to Line No.", LineNo);
            // SalesCrMemoLine.SetRange(Type, SalesInvoiceLine.Type::"Charge (Item)");//BC UPGRADE KUMARR78 23-05-2026--
            SalesCrMemoLine.SetRange(Type, SalesInvoiceLine.Type::"G/L Account");//BC UPGRADE KUMARR78 23-05-2026++
            // SalesCrMemoLine.SETRANGE("Item Charge Type", SalesCrMemoLine."Item Charge Type"::Deposit);//BC UPGRADE KUMARR78 --
            SalesCrMemoLine.SetRange("Attached Line Type 101FDW", SalesCrMemoLine."Attached Line Type 101FDW"::"EGM 104FDW"); //BC UPGRADE KUMARR78 ++

            SalesCrMemoLine.SetAutoCalcFields();//HEI.08
            if SalesCrMemoLine.IsEmpty then
                exit;
            if SalesCrMemoLine.FindSet(false) then
                repeat
                    TotalDeposit += SalesCrMemoLine.Amount;
                until SalesCrMemoLine.Next() = 0;
        end;
        //HEI.06<<
    end;

    local procedure GetDiscountAmount(Type: Option Invoice,"Credit Memo"; DocumentNo: Code[20]; LineNo: Integer) TotalDiscInclItemPrice: Decimal;
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesInvoiceLine2: Record "Sales Invoice Line";
    begin
        //HEI.06>>
        if (Type = Type::Invoice) then begin
            SalesInvoiceLine2.SetRange("Document No.", DocumentNo);
            if LineNo <> 0 then
                SalesInvoiceLine2.SetRange("Attached to Line No.", LineNo);
            // SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine2.Type::"Charge (Item)");//BC UPGRADE KUMARR78 23-05-2026--
            SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine2.Type::"G/L Account");//BC UPGRADE KUMARR78 23-05-2026++
            // SalesInvoiceLine2.SETRANGE("Item Charge Type", SalesInvoiceLine2."Item Charge Type"::Discount); //BC UPGRADE KUMARR78 --
            SalesInvoiceLine2.SetRange("Attached Line Type 101FDW", SalesInvoiceLine2."Attached Line Type 101FDW"::"SPC 105FDW");//BC UPGRADE KUMARR78 ++

            // SalesInvoiceLine2.SETRANGE("Show Item charge on Invoice", SalesInvoiceLine2."Show Item charge on Invoice"::"Under item line"); //BC UPGRADE KUMARR78 --
            if SalesInvoiceLine2.IsEmpty then
                exit;
            SalesInvoiceLine2.SetAutoCalcFields();//HEI.08
            if SalesInvoiceLine2.FindSet(false) then
                repeat
                    if SalesInvoiceLine2.Amount < 0 then
                        TotalDiscInclItemPrice -= SalesInvoiceLine2.Amount
                    else
                        TotalDiscInclItemPrice += SalesInvoiceLine2.Amount;
                until SalesInvoiceLine2.Next() = 0;
        end else begin
            SalesCrMemoLine.SetRange("Document No.", DocumentNo);
            if LineNo <> 0 then
                SalesCrMemoLine.SetRange("Attached to Line No.", LineNo);
            // SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::"Charge (Item)");//BC UPGRADE KUMARR78 23-05-2026--
            SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::"G/L Account");//BC UPGRADE KUMARR78 23-05-2026++
            // SalesCrMemoLine.SETRANGE("Item Charge Type", SalesCrMemoLine."Item Charge Type"::Discount);//BC UPGRADE KUMARR78 --
            SalesCrMemoLine.SetRange("Attached Line Type 101FDW", SalesCrMemoLine."Attached Line Type 101FDW"::"SPC 105FDW");//BC UPGRADE KUMARR78 ++
            // SalesCrMemoLine.SETRANGE("Show Item charge on Invoice", SalesCrMemoLine."Show Item charge on Invoice"::"Under item line");//BC UPGRADE KUMARR78 --
            SalesCrMemoLine.SetAutoCalcFields();//HEI.08
            if SalesCrMemoLine.IsEmpty then
                exit;
            if SalesCrMemoLine.FindSet(false) then
                repeat
                    if SalesCrMemoLine.Amount < 0 then
                        TotalDiscInclItemPrice -= SalesCrMemoLine.Amount
                    else
                        TotalDiscInclItemPrice += SalesCrMemoLine.Amount;
                until SalesCrMemoLine.Next() = 0;
        end;
        //HEI.06<<
    end;


    local procedure GetTotalAmounts(Type: Option Invoice,"Credit Memo"; DocumentNo: Code[20]; var TotalLineAmount: Decimal; var TotalLineDiscountAmount: Decimal; var TotalVolume: Decimal);
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesInvoiceLine2: Record "Sales Invoice Line";
    begin
        //HEI.06>>
        if (Type = Type::Invoice) then begin
            SalesInvoiceLine2.SetRange("Document No.", DocumentNo);
            SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine2.Type::Item);
            SalesInvoiceLine2.SetAutoCalcFields();//HEI.08
            if SalesInvoiceLine2.FindSet(false) then
                repeat
                    TotalLineAmount += SalesInvoiceLine2."Amount Including VAT";
                    TotalLineDiscountAmount += SalesInvoiceLine2."Line Discount Amount" + (SalesInvoiceLine2."VAT %" * SalesInvoiceLine2."Line Discount Amount" / 100);
                    //TotalVolume += SalesInvoiceLine2."Quantity (Base)" * SalesInvoiceLine2."Unit Volume HL";//BC Upgrade VAMSIU01 >>
                    TotalVolume += SalesInvoiceLine2."Quantity (Base)" * SalesInvoiceLine2."Volume 2 101FDW"; //BC Upgrade KUMARR78 ++
                until SalesInvoiceLine2.Next() = 0;
        end else begin
            SalesCrMemoLine.SetRange("Document No.", DocumentNo);
            SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::Item);
            SalesCrMemoLine.SetAutoCalcFields();//HEI.08
            if SalesCrMemoLine.FindSet(false) then
                repeat
                    TotalLineAmount += SalesCrMemoLine."Amount Including VAT";
                    TotalLineDiscountAmount += SalesCrMemoLine."Line Discount Amount" + (SalesCrMemoLine."VAT %" * SalesCrMemoLine."Line Discount Amount" / 100);
                    //TotalVolume += SalesCrMemoLine."Quantity (Base)" * SalesCrMemoLine."Unit Volume HL"; //BC Upgrade VAMSIU01 >>
                    TotalVolume += SalesCrMemoLine."Quantity (Base)" * SalesCrMemoLine."Volume 2 101FDW"; //BC Upgrade KUMARR78 ++

                until SalesCrMemoLine.Next() = 0;
        end;
        //HEI.06<<
    end;

    procedure SetSendSalesDocumentsFilter(CreationDate: Date; DocumentNo: Text; DocumentType: Option " ",Invoice,"Credit Memo"; var Customer: Record Customer);
    begin
        //HEI.06>>
        CreationDateFilter := CreationDate;
        DocumentNoFilter := DocumentNo;
        DocumentTypeFilter := DocumentType;
        CustomerFilter.COPYFILTERS(Customer);
        //HEI.06<<
    end;

    local procedure FilterSalesInvoice(var SalesInvoiceHeader: Record "Sales Invoice Header");
    begin
        //HEI.06>>
        if DocumentNoFilter <> '' then
            SalesInvoiceHeader.SetFilter("No.", DocumentNoFilter);

        if CustomerFilter.GetFilter("No.") <> '' then
            SalesInvoiceHeader.SetFilter("Sell-to Customer No.", CustomerFilter.GetFilter("No."));

        if (CreationDateFilter > 0D) and (DocumentNoFilter = '') then
            //BC Upgrade VAMSIU01 >>
            //SalesInvoiceHeader.SETRANGE("Creation Date/Time", CREATEDATETIME(CreationDateFilter, 000000T), CREATEDATETIME(CALCDATE('<1D>', CreationDateFilter), 000000T));
            SalesInvoiceHeader.SetRange(SystemCreatedAt, CreateDateTime(CreationDateFilter, 000000T), CreateDateTime(CalcDate('<1D>', CreationDateFilter), 000000T));
        //BC Upgrade VAMSIU01 <<
        //HEI.06<<
    end;


    local procedure FilterSalesCreditMemo(var SalesCrMemoHeader: Record "Sales Cr.Memo Header");
    begin
        //HEI.06>>
        if DocumentNoFilter <> '' then
            SalesCrMemoHeader.SetFilter("No.", DocumentNoFilter);

        if CustomerFilter.GetFilter("No.") <> '' then
            SalesCrMemoHeader.SetFilter("Sell-to Customer No.", CustomerFilter.GetFilter("No."));

        if (CreationDateFilter > 0D) and (DocumentNoFilter = '') then
            //BC Upgrade VAMSIU01 >>
            //SalesCrMemoHeader.SETRANGE("Creation Date/Time", CREATEDATETIME(CreationDateFilter, 000000T), CREATEDATETIME(CALCDATE('<1D>', CreationDateFilter), 000000T));
            SalesCrMemoHeader.SetRange(SystemCreatedAt, CreateDateTime(CreationDateFilter, 000000T), CreateDateTime(CalcDate('<1D>', CreationDateFilter), 000000T));
        //BC Upgrade VAMSIU01 <<
        //HEI.06<<
    end;


    local procedure IsCustomerIncluded(CustomerNo: Code[20]): Boolean;
    var
        Customer: Record Customer;
    begin
        //HEI.06>>
        Customer.SetRange("No.", CustomerNo);
        if CustomerFilter.GetFilters <> '' then
            Customer.CopyFilters(CustomerFilter);

        if SEMInterfaceSetup."Sales Info. Cust. Acc Group" <> '' then
            Customer.SetFilter("Account Group FND", SEMInterfaceSetup."Sales Info. Cust. Acc Group");

        exit(not Customer.IsEmpty);
        //HEI.06<<
    end;

    // local procedure GetSEMInterfaceSetup();
    // begin
    //     //HEI.06>>
    //     if not SEMInterfaceSetupRead then
    //         SEMInterfaceSetup.GET;
    //     SEMInterfaceSetupRead := true;
    //     //HEI.06<<
    // end;

    local procedure GetGeneralLedgerSetup();
    begin
        //HEI.06>>
        if not GeneralLedgerSetupRead then
            GeneralLedgerSetup.GET;
        GeneralLedgerSetupRead := true;
        //HEI.06<<
    end;

    // local procedure FormatSalesInvAmount(SalesInvoiceHeader: Record "Sales Invoice Header"; Amount: Decimal): Text;
    // var
    //     SEMAmount: Decimal;
    // begin
    //     //HE.06>>
    //     SEMAmount := ConvertAmountToSEMCurrency(SalesInvoiceHeader."Currency Code", SalesInvoiceHeader."Posting Date", Amount, SalesInvoiceHeader."Currency Factor");
    //     exit(FORMAT(SEMAmount, 0, '<Precision,2:2><Standard Format,2>'));
    //     //HEI.06<<
    // end;
    local procedure FormatSalesInvAmount(SalesInvoiceHeader: Record "Sales Invoice Header"; Amount: Decimal): Text;
    var
        SEMAmount: Decimal;
    begin
        //HE.06>>
        SEMAmount := ConvertAmountToSEMCurrency(SalesInvoiceHeader."Currency Code", SalesInvoiceHeader."Posting Date", Amount, SalesInvoiceHeader."Currency Factor");
        exit(Format(SEMAmount, 0, '<Precision,2:2><Standard Format,2>'));
        //HEI.06<<
    end;

    local procedure FormatSalesCreditMemoAmount(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; Amount: Decimal): Text;
    var
        SEMAmount: Decimal;
    begin
        //HE.06>>
        SEMAmount := ConvertAmountToSEMCurrency(SalesCrMemoHeader."Currency Code", SalesCrMemoHeader."Posting Date", Amount, SalesCrMemoHeader."Currency Factor");
        exit(FORMAT(SEMAmount, 0, '<Precision,2:2><Standard Format,2>'));
        //HEI.06<<
    end;

    local procedure ConvertAmountToSEMCurrency(FromCurrencyCode: Code[10]; Date: Date; Amount: Decimal; Factor: Decimal) SEMAmount: Decimal;
    var
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        CurrencyCode: Code[10];
        CurrencyFactor: Decimal;
    begin
        //HEI.06
        GetGeneralLedgerSetup();
        if SEMInterfaceSetup."Sales Info. Currency Code" <> '' then
            CurrencyCode := SEMInterfaceSetup."Sales Info. Currency Code";
        if CurrencyCode <> '' then begin
            CurrencyFactor := CurrencyExchangeRate.GetCurrentCurrencyFactor(CurrencyCode);
            if FromCurrencyCode <> '' then
                SEMAmount := CurrencyExchangeRate.ExchangeAmtFCYToFCY(Date, FromCurrencyCode, CurrencyCode, Amount)
            else
                SEMAmount := CurrencyExchangeRate.ExchangeAmtLCYToFCY(Date, CurrencyCode, Amount, CurrencyFactor);
        end else begin
            if FromCurrencyCode <> '' then
                SEMAmount := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Date, FromCurrencyCode, Amount, Factor)
            else
                SEMAmount := Amount;
        end;
        //HEI.06<<
    end;



    // local procedure _XML_FUNCTIONS();
    // begin
    // end;

    // local procedure CreateResponseXMLMsg(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; MainNodeName: Text);
    // var
    //     ProcessingInstruction: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlProcessingInstruction";
    //     XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLDOMMgt: Codeunit "XML DOM Management";
    // begin
    //     //HEI.06>>
    //     XMLDoc := XMLDoc.XmlDocument;
    //     XMLCurrNode := XMLDoc.CreateElement(MainNodeName);
    //     XMLDoc.AppendChild(XMLCurrNode);
    //     ProcessingInstruction := XMLDoc.CreateProcessingInstruction('?xml', 'version="1.0" encoding="UTF-8?');
    //     XMLDOMMgt.AddElement(XMLCurrNode, 'Tenant', UPPERCASE(TENANTID), '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode, 'Company', UPPERCASE(COMPANYNAME), '', NewChildNode);
    //     XMLCurrNode2 := XMLDoc.CreateElement('Documents');
    //     XMLCurrNode.AppendChild(XMLCurrNode2);
    //     //HEI.06<<
    // end;
    //BC UPGRADE KUMARR78 >>
    local procedure CreateResponseXMLMsg(var XMLDoc: XmlDocument; var XMLCurrNode2: XmlElement; MainNodeName: Text)
    var
        XMLDOMMgt: Codeunit "XML DOM Management";
        NewChildNode: XmlNode;

        RootNode: XmlElement;
        RootNodeVar: XmlNode;
    begin
        XMLDoc := XmlDocument.Create();
        RootNode := XmlElement.Create(MainNodeName);
        XMLDoc.Add(RootNode);
        RootNodeVar := RootNode.AsXmlNode();
        XMLDOMMgt.AddElement(RootNodeVar, 'Tenant', UpperCase(TenantId()), '', NewChildNode);
        XMLDOMMgt.AddElement(RootNodeVar, 'Company', UpperCase(CompanyName), '', NewChildNode);
        XMLCurrNode2 := XmlElement.Create('Documents');
        RootNode.Add(XMLCurrNode2);
    end;

    //BC UPGRADE KUMARR78 >>
    local procedure CreateResponseDocHeaderMsgNew(var XMLDoc: XmlDocument; var ParentNode: XmlElement; SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        Location: Record Location;

        XMLDOMMgt: Codeunit "XML DOM Management";

        TotalLineAmount: Decimal;
        TotalLineDiscount: Decimal;
        TotalVolume: Decimal;

        NewChildNode: XmlNode;

        //BC UPGRADE KUMARR78 >>
        DocumentNode: XmlElement;
        LinesNode: XmlElement;
        LineNode: XmlElement;

        DocumentNodeVar: XmlNode;
        LineNodeVar: XmlNode;
    //BC UPGRADE KUMARR78 <<
    begin
        // =========================
        // Create Document Node
        // =========================
        DocumentNode := XmlElement.Create('Document');
        ParentNode.Add(DocumentNode);
        DocumentNodeVar := DocumentNode.AsXmlNode();

        // =========================
        // Header Fields
        // =========================
        XMLDOMMgt.AddElement(DocumentNodeVar, 'Type', 'Invoice', '', NewChildNode);
        XMLDOMMgt.AddElement(DocumentNodeVar, 'Outlet', SalesInvoiceHeader."Sell-to Customer No.", '', NewChildNode);
        XMLDOMMgt.AddElement(DocumentNodeVar, 'OrderNumber', SalesInvoiceHeader."Order No.", '', NewChildNode);
        XMLDOMMgt.AddElement(DocumentNodeVar, 'BillingDate', Format(SalesInvoiceHeader."Posting Date", 0, 9), '', NewChildNode);
        XMLDOMMgt.AddElement(DocumentNodeVar, 'BillingDocumentNumber', SalesInvoiceHeader."No.", '', NewChildNode);

        case SEMInterfaceSetup."Sales Person Mapping Code" of
            SEMInterfaceSetup."Sales Person Mapping Code"::"Sales Person":
                XMLDOMMgt.AddElement(DocumentNodeVar, 'Employee', SalesInvoiceHeader."Salesperson Code", '', NewChildNode);
            SEMInterfaceSetup."Sales Person Mapping Code"::"User ID":
                XMLDOMMgt.AddElement(DocumentNodeVar, 'Employee', SalesInvoiceHeader."User ID", '', NewChildNode);
            else
                XMLDOMMgt.AddElement(DocumentNodeVar, 'Employee', '', '', NewChildNode);
        end;

        if Location.Get(SalesInvoiceHeader."Location Code") then
            XMLDOMMgt.AddElement(DocumentNodeVar, 'Distributor', Location.Name, '', NewChildNode)
        else
            XMLDOMMgt.AddElement(DocumentNodeVar, 'Distributor', '', '', NewChildNode);

        // =========================
        // Totals
        // =========================
        GetTotalAmounts(0, SalesInvoiceHeader."No.", TotalLineAmount, TotalLineDiscount, TotalVolume);

        XMLDOMMgt.AddElement(DocumentNodeVar, 'TotalAmount',
            FormatSalesInvAmount(SalesInvoiceHeader, SalesInvoiceHeader."Amount Including VAT"), '', NewChildNode);

        XMLDOMMgt.AddElement(DocumentNodeVar, 'TotalDeposit',
            FormatSalesInvAmount(SalesInvoiceHeader, GetDepositAmount(0, SalesInvoiceHeader."No.", 0)), '', NewChildNode);

        XMLDOMMgt.AddElement(DocumentNodeVar, 'TotalDiscountAmount',
            FormatSalesInvAmount(SalesInvoiceHeader,
                GetDiscountAmount(0, SalesInvoiceHeader."No.", 0) + TotalLineDiscount), '', NewChildNode);

        XMLDOMMgt.AddElement(DocumentNodeVar, 'TotalTax',
            FormatSalesInvAmount(SalesInvoiceHeader, GetTaxAmount(0, SalesInvoiceHeader."No.", 0)), '', NewChildNode);

        XMLDOMMgt.AddElement(DocumentNodeVar, 'TotalLineItemAmount',
            FormatSalesInvAmount(SalesInvoiceHeader, TotalLineAmount), '', NewChildNode);

        XMLDOMMgt.AddElement(DocumentNodeVar, 'OrderType', 'Invoice', '', NewChildNode);
        XMLDOMMgt.AddElement(DocumentNodeVar, 'SystemOrderNumber', SalesInvoiceHeader."Order No.", '', NewChildNode);
        XMLDOMMgt.AddElement(DocumentNodeVar, 'SourceSystem', SalesInvoiceHeader."Source System Identifier FND", '', NewChildNode);
        XMLDOMMgt.AddElement(DocumentNodeVar, 'Comments', SalesInvoiceHeader."External Document No.", '', NewChildNode);

        XMLDOMMgt.AddElement(DocumentNodeVar, 'TotalVolumeHL',
            Format(TotalVolume, 0, '<Precision,2:2><Standard Format,2>'), '', NewChildNode);

        // =========================
        // Lines Node
        // =========================
        LinesNode := XmlElement.Create('Lines');
        DocumentNode.Add(LinesNode);

        // =========================
        // Line Loop
        // =========================
        SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SetFilter(Type, '<>%1&<>%2',
            SalesInvoiceLine.Type::"Charge (Item)",
            SalesInvoiceLine.Type::" ");

        if SalesInvoiceLine.FindSet() then
            repeat
                LineNode := XmlElement.Create('Line');
                LinesNode.Add(LineNode);
                LineNodeVar := LineNode.AsXmlNode();

                XMLDOMMgt.AddElement(LineNodeVar, 'LineNo', Format(SalesInvoiceLine."Line No."), '', NewChildNode);

                if SalesInvoiceLine.Type <> SalesInvoiceLine.Type::Item then
                    XMLDOMMgt.AddElement(LineNodeVar, 'Product', SEMInterfaceSetup."Mapping Item Code", '', NewChildNode)
                else
                    XMLDOMMgt.AddElement(LineNodeVar, 'Product', SalesInvoiceLine."No.", '', NewChildNode);

                XMLDOMMgt.AddElement(LineNodeVar, 'Quantity',
                    Format(SalesInvoiceLine.Quantity, 0, '<Precision,2:2><Standard Format,2>'), '', NewChildNode);

                XMLDOMMgt.AddElement(LineNodeVar, 'Amount',
                    FormatSalesInvAmount(SalesInvoiceHeader, SalesInvoiceLine.Amount), '', NewChildNode);

                XMLDOMMgt.AddElement(LineNodeVar, 'Deposit',
                    FormatSalesInvAmount(SalesInvoiceHeader,
                        GetDepositAmount(0, SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.")), '', NewChildNode);

                XMLDOMMgt.AddElement(LineNodeVar, 'DiscountAmount',
                    FormatSalesInvAmount(SalesInvoiceHeader,
                        GetDiscountAmount(0, SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.")
                        + SalesInvoiceLine."Line Discount Amount"), '', NewChildNode);

                XMLDOMMgt.AddElement(LineNodeVar, 'PricePerUnit',
                    FormatSalesInvAmount(SalesInvoiceHeader, SalesInvoiceLine."Unit Price"), '', NewChildNode);

                if SEMInterfaceSetup."Sales Info. Currency Code" <> '' then
                    XMLDOMMgt.AddElement(LineNodeVar, 'Currency',
                        SEMInterfaceSetup."Sales Info. Currency Code", '', NewChildNode)
                else
                    XMLDOMMgt.AddElement(LineNodeVar, 'Currency',
                        GeneralLedgerSetup."LCY Code", '', NewChildNode);

                XMLDOMMgt.AddElement(LineNodeVar, 'Transaction',
                    SalesInvoiceLine."Document No.", '', NewChildNode);

                XMLDOMMgt.AddElement(LineNodeVar, 'Unit',
                    SalesInvoiceLine."Unit of Measure Code", '', NewChildNode);

            until SalesInvoiceLine.Next() = 0;

        Clear(NewChildNode);
    end;
    //BC UPGRADE KUMARR78 <<

    // local procedure CreateResponseDocHeaderMsg(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; SalesInvoiceHeader: Record "Sales Invoice Header");
    // var
    //     SalesInvoiceLine: Record "Sales Invoice Line";
    //     Location: Record Location;
    //     XMLCurrNode3: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLCurrNode4: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLCurrNode5: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLDOMMgt: Codeunit "XML DOM Management";
    //     NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     ListPriceString: Text;
    //     SalesPriceString: Text;
    //     TotalLineAmount: Decimal;
    //     TotalLineDiscount: Decimal;
    //     TotalVolume: Decimal;
    // begin
    //     //HEI.06>>
    //     XMLCurrNode3 := XMLDoc.CreateElement('Document');
    //     XMLCurrNode2.AppendChild(XMLCurrNode3);

    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'Type', 'Invoice', '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'Outlet', SalesInvoiceHeader."Sell-to Customer No.", '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'OrderNumber', SalesInvoiceHeader."Order No.", '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'BillingDate', FORMAT(SalesInvoiceHeader."Posting Date", 0, 9), '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'BillingDocumentNumber', SalesInvoiceHeader."No.", '', NewChildNode);

    //     if (SEMInterfaceSetup."Sales Person Mapping Code" = SEMInterfaceSetup."Sales Person Mapping Code"::"Sales Person") then
    //         case SEMInterfaceSetup."Sales Person Mapping Code" of
    //             SEMInterfaceSetup."Sales Person Mapping Code"::"Sales Person":
    //                 XMLDOMMgt.AddElement(XMLCurrNode3, 'Employee', SalesInvoiceHeader."Salesperson Code", '', NewChildNode);
    //             SEMInterfaceSetup."Sales Person Mapping Code"::"User ID":
    //                 XMLDOMMgt.AddElement(XMLCurrNode3, 'Employee', SalesInvoiceHeader."User ID", '', NewChildNode);
    //             else
    //                 XMLDOMMgt.AddElement(XMLCurrNode3, 'Employee', '', '', NewChildNode);
    //         end;
    //     if (SEMInterfaceSetup."Sales Information Distributor" = SEMInterfaceSetup."Sales Information Distributor"::" ") then
    //         XMLDOMMgt.AddElement(XMLCurrNode3, 'Distributor', '', '', NewChildNode)
    //     else begin
    //         if Location.GET(SalesInvoiceHeader."Location Code") then;

    //         XMLDOMMgt.AddElement(XMLCurrNode3, 'Distributor', Location.Name, '', NewChildNode);
    //     end;
    //     //To Be updated based on setup
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'Name', STRSUBSTNO('%1-%2-%3', SalesInvoiceHeader."Sell-to Customer Name", FORMAT(SalesInvoiceHeader."Document Date", 0, 9), SalesInvoiceHeader."Trailer Code"), '', NewChildNode);

    //     GetTotalAmounts(0, SalesInvoiceHeader."No.", TotalLineAmount, TotalLineDiscount, TotalVolume);

    //     //to be checked if amount is correc
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalAmount', FormatSalesInvAmount(SalesInvoiceHeader, SalesInvoiceHeader."Amount Including VAT"), '', NewChildNode);

    //     //Total Amount deposits including VAT (sum of deposit line amount+VAT)
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalDeposit', FormatSalesInvAmount(SalesInvoiceHeader, GetDepositAmount(0, SalesInvoiceHeader."No.", 0)), '', NewChildNode);

    //     //Total Amount discounts including VAT (sum of discount line amount+VAT)
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalDiscountAmount', FormatSalesInvAmount(SalesInvoiceHeader, GetDiscountAmount(0, SalesInvoiceHeader."No.", 0) + TotalLineDiscount), '', NewChildNode);

    //     //Total Amount taxes including VAT (sum of taxes line amount+VAT)
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalTax', FormatSalesInvAmount(SalesInvoiceHeader, GetTaxAmount(0, SalesInvoiceHeader."No.", 0)), '', NewChildNode);

    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalLineItemAmount', FormatSalesInvAmount(SalesInvoiceHeader, TotalLineAmount), '', NewChildNode);

    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'OrderType', 'Invoice', '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'SystemOrderNumber', SalesInvoiceHeader."Order No.", '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'SourceSystem', SalesInvoiceHeader."Source System Identifier", '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'Owner', '', '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'ManualDiscountAmount', '', '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'Comments', SalesInvoiceHeader."External Document No.", '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'OrderReason', '', '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalVolumeHL', FORMAT(TotalVolume, 0, '<Precision,2:2><Standard Format,2>'), '', NewChildNode);

    //     XMLCurrNode4 := XMLDoc.CreateElement('Lines');
    //     XMLCurrNode3.AppendChild(XMLCurrNode4);

    //     SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //     SalesInvoiceLine.SETFILTER(Type, '<>%1&<>%2', SalesInvoiceLine.Type::"Charge (Item)", SalesInvoiceLine.Type::" ");//exclude charge item and free text
    //     SalesInvoiceLine.SETAUTOCALCFIELDS();//HEI.08
    //     if SalesInvoiceLine.FINDSET(false, false) then
    //         repeat
    //             XMLCurrNode5 := XMLDoc.CreateElement('Line');
    //             XMLCurrNode4.AppendChild(XMLCurrNode5);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'LineNo', FORMAT(SalesInvoiceLine."Line No."), '', NewChildNode);
    //             //to be updated based on setup
    //             if SalesInvoiceLine.Type <> SalesInvoiceLine.Type::Item then
    //                 XMLDOMMgt.AddElement(XMLCurrNode5, 'Product', SEMInterfaceSetup."Mapping Item Code", '', NewChildNode)
    //             else
    //                 XMLDOMMgt.AddElement(XMLCurrNode5, 'Product', SalesInvoiceLine."No.", '', NewChildNode);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'Quantity', FORMAT(SalesInvoiceLine.Quantity, 0, '<Precision,2:2><Standard Format,2>'), '', NewChildNode);
    //             //to be updated as in mapping
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'Amount', FormatSalesInvAmount(SalesInvoiceHeader, SalesInvoiceLine.Amount), '', NewChildNode);
    //             //to be updated as in mapping
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'Deposit', FormatSalesInvAmount(SalesInvoiceHeader, GetDepositAmount(0, SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.")), '', NewChildNode);
    //             //to be updated as in mapping
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'DiscountAmount', FormatSalesInvAmount(SalesInvoiceHeader, GetDiscountAmount(0, SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.") + SalesInvoiceLine."Line Discount Amount"), '', NewChildNode);
    //             //to be updated as in mapping
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'ExtendedAmount', '', '', NewChildNode);

    //             if SalesInvoiceLine."Free Item" then
    //                 XMLDOMMgt.AddElement(XMLCurrNode5, 'FreeOfCharge', 'TRUE', '', NewChildNode)
    //             else
    //                 XMLDOMMgt.AddElement(XMLCurrNode5, 'IsGift', 'FALSE', '', NewChildNode);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'ItemNumber', FORMAT(SalesInvoiceLine."Line No."), '', NewChildNode);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'PricePerUnit', FormatSalesInvAmount(SalesInvoiceHeader, SalesInvoiceLine."Unit Price"), '', NewChildNode);
    //             if SEMInterfaceSetup."Sales Info. Currency Code" <> '' then
    //                 XMLDOMMgt.AddElement(XMLCurrNode5, 'Currency', SEMInterfaceSetup."Sales Info. Currency Code", '', NewChildNode)
    //             else
    //                 XMLDOMMgt.AddElement(XMLCurrNode5, 'Currency', GeneralLedgerSetup."LCY Code", '', NewChildNode);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'Transaction', SalesInvoiceLine."Document No.", '', NewChildNode);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'Unit', SalesInvoiceLine."Unit of Measure Code", '', NewChildNode);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'VolumeHL', FORMAT(SalesInvoiceLine."Quantity (Base)" * SalesInvoiceLine."Unit Volume HL", 0, '<Precision,2:2><Standard Format,2>'), '', NewChildNode);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'Owner', '', '', NewChildNode);
    //         until SalesInvoiceLine.NEXT = 0;

    //     CLEAR(NewChildNode);
    //     CLEAR(XMLCurrNode3);
    //     CLEAR(XMLCurrNode4);
    //     CLEAR(XMLCurrNode5);
    //     //HEI.06<<
    // end;

    //BC UPGRADE KUMARR78 >> Adding
    local procedure CreateResponseCreditMemoMsgNew(var XMLDoc: XmlDocument; var ParentNode: XmlElement; SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        Location: Record Location;
        XMLDOMMgt: Codeunit "XML DOM Management";
        TotalLineAmount: Decimal;
        TotalLineDiscount: Decimal;
        TotalVolume: Decimal;
        NewChildNode: XmlNode;
        XMLCurrNode3: XmlElement; // Document
        XMLCurrNode4: XmlElement; // Lines
        XMLCurrNode5: XmlElement; // Line

        XMLCurrNode3Var: XmlNode;
        XMLCurrNode5Var: XmlNode;
    begin
        XMLCurrNode3 := XmlElement.Create('Document');
        ParentNode.Add(XMLCurrNode3);
        XMLCurrNode3Var := XMLCurrNode3.AsXmlNode();

        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'Type', 'Credit Memo', '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'Outlet', SalesCrMemoHeader."Sell-to Customer No.", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'OrderNumber', SalesCrMemoHeader."Return Order No.", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'BillingDate', Format(SalesCrMemoHeader."Posting Date", 0, 9), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'BillingDocumentNumber', SalesCrMemoHeader."No.", '', NewChildNode);

        case SEMInterfaceSetup."Sales Person Mapping Code" of
            SEMInterfaceSetup."Sales Person Mapping Code"::"Sales Person":
                XMLDOMMgt.AddElement(XMLCurrNode3Var, 'Employee', SalesCrMemoHeader."Salesperson Code", '', NewChildNode);
            SEMInterfaceSetup."Sales Person Mapping Code"::"User ID":
                XMLDOMMgt.AddElement(XMLCurrNode3Var, 'Employee', SalesCrMemoHeader."User ID", '', NewChildNode);
            else
                XMLDOMMgt.AddElement(XMLCurrNode3Var, 'Employee', '', '', NewChildNode);
        end;

        if Location.Get(SalesCrMemoHeader."Location Code") then
            XMLDOMMgt.AddElement(XMLCurrNode3Var, 'Distributor', Location.Name, '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode3Var, 'Distributor', '', '', NewChildNode);


        //BC UPGRADE KUMARR78 >>
        // XMLDOMMgt.AddElement(
        //     XMLCurrNode3Var,
        //     'Name',
        //     StrSubstNo('%1-%2-%3',
        //         SalesCrMemoHeader."Sell-to Customer Name",
        //         Format(SalesCrMemoHeader."Document Date", 0, 9),
        //         SalesCrMemoHeader."Trailer Code"),
        //     '',
        //     NewChildNode);
        //BC UPGRADE KUMARR78 >>


        GetTotalAmounts(1, SalesCrMemoHeader."No.", TotalLineAmount, TotalLineDiscount, TotalVolume);

        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'TotalAmount',
            FormatSalesCreditMemoAmount(SalesCrMemoHeader, SalesCrMemoHeader."Amount Including VAT"), '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'TotalDeposit',
            FormatSalesCreditMemoAmount(SalesCrMemoHeader, GetDepositAmount(1, SalesCrMemoHeader."No.", 0)), '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'TotalDiscountAmount',
            FormatSalesCreditMemoAmount(SalesCrMemoHeader,
                GetDiscountAmount(1, SalesCrMemoHeader."No.", 0) + TotalLineDiscount), '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'TotalTax',
            FormatSalesCreditMemoAmount(SalesCrMemoHeader, GetTaxAmount(1, SalesCrMemoHeader."No.", 0)), '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'TotalLineItemAmount',
            FormatSalesCreditMemoAmount(SalesCrMemoHeader, TotalLineAmount), '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'OrderType', 'Credit Memo', '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'SystemOrderNumber', SalesCrMemoHeader."Return Order No.", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'SourceSystem', SalesCrMemoHeader."Source System Identifier FND", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'Owner', '', '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'ManualDiscountAmount', '', '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'Comments', SalesCrMemoHeader."External Document No.", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'OrderReason', '', '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode3Var, 'TotalVolumeHL',
            Format(TotalVolume, 0, '<Precision,2:2><Standard Format,2>'), '', NewChildNode);

        XMLCurrNode4 := XmlElement.Create('Lines');
        XMLCurrNode3.Add(XMLCurrNode4);

        SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
        SalesCrMemoLine.SetFilter(Type, '<>%1&<>%2',
            SalesCrMemoLine.Type::"Charge (Item)",
            SalesCrMemoLine.Type::" ");

        SalesCrMemoLine.SetAutoCalcFields();

        if SalesCrMemoLine.FindSet(false) then
            repeat
                XMLCurrNode5 := XmlElement.Create('Line');
                XMLCurrNode4.Add(XMLCurrNode5);
                XMLCurrNode5Var := XMLCurrNode5.AsXmlNode();

                XMLDOMMgt.AddElement(XMLCurrNode5Var, 'LineNo', Format(SalesCrMemoLine."Line No."), '', NewChildNode);

                if SalesCrMemoLine.Type <> SalesCrMemoLine.Type::Item then
                    XMLDOMMgt.AddElement(XMLCurrNode5Var, 'Product', SEMInterfaceSetup."Mapping Item Code", '', NewChildNode)
                else
                    XMLDOMMgt.AddElement(XMLCurrNode5Var, 'Product', SalesCrMemoLine."No.", '', NewChildNode);

                XMLDOMMgt.AddElement(XMLCurrNode5Var, 'Quantity',
                    Format(SalesCrMemoLine.Quantity, 0, '<Precision,2:2><Standard Format,2>'), '', NewChildNode);

                XMLDOMMgt.AddElement(XMLCurrNode5Var, 'Amount',
                    FormatSalesCreditMemoAmount(SalesCrMemoHeader, SalesCrMemoLine.Amount), '', NewChildNode);

                XMLDOMMgt.AddElement(XMLCurrNode5Var, 'Deposit',
                    FormatSalesCreditMemoAmount(SalesCrMemoHeader,
                        GetDepositAmount(1, SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.")), '', NewChildNode);

                XMLDOMMgt.AddElement(XMLCurrNode5Var, 'DiscountAmount',
                    FormatSalesCreditMemoAmount(SalesCrMemoHeader,
                        GetDiscountAmount(1, SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.")
                        + SalesCrMemoLine."Line Discount Amount"), '', NewChildNode);

                XMLDOMMgt.AddElement(XMLCurrNode5Var, 'ExtendedAmount', '', '', NewChildNode);

                //BC UPGRADE KUMARR78 >>

                // if SalesCrMemoLine."Free Item" then
                //     XMLDOMMgt.AddElement(XMLCurrNode5Var, 'FreeOfCharge', 'TRUE', '', NewChildNode)
                // else
                // XMLDOMMgt.AddElement(XMLCurrNode5Var, 'IsGift', 'FALSE', '', NewChildNode);
                //BC UPGRADE KUMARR78 >>

                //BC UPGRADE KUMARR78 << 23-05-2026
                if SalesCrMemoLine."Line Discount %" <> 0 then
                    XMLDOMMgt.AddElement(XMLCurrNode5Var, 'FreeOfCharge', 'TRUE', '', NewChildNode)
                else
                    XMLDOMMgt.AddElement(XMLCurrNode5Var, 'IsGift', 'FALSE', '', NewChildNode);
                //BC UPGRADE KUMARR78 >> 23-05-2026

                XMLDOMMgt.AddElement(XMLCurrNode5Var, 'ItemNumber', Format(SalesCrMemoLine."Line No."), '', NewChildNode);

                XMLDOMMgt.AddElement(XMLCurrNode5Var, 'PricePerUnit',
                    FormatSalesCreditMemoAmount(SalesCrMemoHeader, SalesCrMemoLine."Unit Price"), '', NewChildNode);

                if SEMInterfaceSetup."Sales Info. Currency Code" <> '' then
                    XMLDOMMgt.AddElement(XMLCurrNode5Var, 'Currency',
                        SEMInterfaceSetup."Sales Info. Currency Code", '', NewChildNode)
                else
                    XMLDOMMgt.AddElement(XMLCurrNode5Var, 'Currency',
                        GeneralLedgerSetup."LCY Code", '', NewChildNode);

                XMLDOMMgt.AddElement(XMLCurrNode5Var, 'Transaction',
                    SalesCrMemoLine."Document No.", '', NewChildNode);

                XMLDOMMgt.AddElement(XMLCurrNode5Var, 'Unit',
                    SalesCrMemoLine."Unit of Measure Code", '', NewChildNode);

                //BC UPGRADE KUMARR78 >>
                // XMLDOMMgt.AddElement(XMLCurrNode5Var, 'VolumeHL',
                //     Format(SalesCrMemoLine."Quantity (Base)" * SalesCrMemoLine."Unit Volume HL",
                //         0, '<Precision,2:2><Standard Format,2>'), '', NewChildNode);
                //BC UPGRADE KUMARR78 >>
                //BC UPGRADE KUMARR78 >> ++23-05-2026
                XMLDOMMgt.AddElement(XMLCurrNode5Var, 'VolumeHL',
                    Format(SalesCrMemoLine."Quantity (Base)" * SalesCrMemoLine."Volume 2 101FDW",
                        0, '<Precision,2:2><Standard Format,2>'), '', NewChildNode);
                //BC UPGRADE KUMARR78 << ++23-05-2026



                XMLDOMMgt.AddElement(XMLCurrNode5Var, 'Owner', '', '', NewChildNode);

            until SalesCrMemoLine.Next() = 0;

        Clear(NewChildNode);
    end;
    //BC UPGRADE KUMARR78 <<
    // local procedure CreateResponseCreditMemoMsg(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header");
    // var
    //     SalesCrMemoLine: Record "Sales Cr.Memo Line";
    //     Location: Record Location;
    //     XMLCurrNode3: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLCurrNode4: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLCurrNode5: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLDOMMgt: Codeunit "XML DOM Management";
    //     NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     ListPriceString: Text;
    //     SalesPriceString: Text;
    //     TotalLineAmount: Decimal;
    //     TotalLineDiscount: Decimal;
    //     TotalVolume: Decimal;
    // begin
    //     //HEI.06>>
    //     XMLCurrNode3 := XMLDoc.CreateElement('Document');
    //     XMLCurrNode2.AppendChild(XMLCurrNode3);

    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'Type', 'Credit Memo', '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'Outlet', SalesCrMemoHeader."Sell-to Customer No.", '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'OrderNumber', SalesCrMemoHeader."Return Order No.", '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'BillingDate', FORMAT(SalesCrMemoHeader."Posting Date", 0, 9), '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'BillingDocumentNumber', SalesCrMemoHeader."No.", '', NewChildNode);

    //     if (SEMInterfaceSetup."Sales Person Mapping Code" = SEMInterfaceSetup."Sales Person Mapping Code"::"Sales Person") then
    //         case SEMInterfaceSetup."Sales Person Mapping Code" of
    //             SEMInterfaceSetup."Sales Person Mapping Code"::"Sales Person":
    //                 XMLDOMMgt.AddElement(XMLCurrNode3, 'Employee', SalesCrMemoHeader."Salesperson Code", '', NewChildNode);
    //             SEMInterfaceSetup."Sales Person Mapping Code"::"User ID":
    //                 XMLDOMMgt.AddElement(XMLCurrNode3, 'Employee', SalesCrMemoHeader."User ID", '', NewChildNode);
    //             else
    //                 XMLDOMMgt.AddElement(XMLCurrNode3, 'Employee', '', '', NewChildNode);
    //         end;
    //     if (SEMInterfaceSetup."Sales Information Distributor" = SEMInterfaceSetup."Sales Information Distributor"::" ") then
    //         XMLDOMMgt.AddElement(XMLCurrNode3, 'Distributor', '', '', NewChildNode)
    //     else begin
    //         if Location.GET(SalesCrMemoHeader."Location Code") then;
    //         XMLDOMMgt.AddElement(XMLCurrNode3, 'Distributor', Location.Name, '', NewChildNode);
    //     end;
    //     //To Be updated based on setup
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'Name', STRSUBSTNO('%1-%2-%3', SalesCrMemoHeader."Sell-to Customer Name", FORMAT(SalesCrMemoHeader."Document Date", 0, 9), SalesCrMemoHeader."Trailer Code"), '', NewChildNode);

    //     GetTotalAmounts(1, SalesCrMemoHeader."No.", TotalLineAmount, TotalLineDiscount, TotalVolume);

    //     //to be checked if amount is correc
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalAmount', FormatSalesCreditMemoAmount(SalesCrMemoHeader, SalesCrMemoHeader."Amount Including VAT"), '', NewChildNode);

    //     //Total Amount deposits including VAT (sum of deposit line amount+VAT)
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalDeposit', FormatSalesCreditMemoAmount(SalesCrMemoHeader, GetDepositAmount(1, SalesCrMemoHeader."No.", 0)), '', NewChildNode);

    //     //Total Amount discounts including VAT (sum of discount line amount+VAT)
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalDiscountAmount', FormatSalesCreditMemoAmount(SalesCrMemoHeader, GetDiscountAmount(1, SalesCrMemoHeader."No.", 0) + TotalLineDiscount), '', NewChildNode);

    //     //Total Amount taxes including VAT (sum of taxes line amount+VAT)
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalTax', FormatSalesCreditMemoAmount(SalesCrMemoHeader, GetTaxAmount(1, SalesCrMemoHeader."No.", 0)), '', NewChildNode);

    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalLineItemAmount', FormatSalesCreditMemoAmount(SalesCrMemoHeader, TotalLineAmount), '', NewChildNode);

    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'OrderType', 'Credit Memo', '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'SystemOrderNumber', SalesCrMemoHeader."Return Order No.", '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'SourceSystem', SalesCrMemoHeader."Source System Identifier", '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'Owner', '', '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'ManualDiscountAmount', '', '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'Comments', SalesCrMemoHeader."External Document No.", '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'OrderReason', '', '', NewChildNode);
    //     XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalVolumeHL', FORMAT(TotalVolume, 0, '<Precision,2:2><Standard Format,2>'), '', NewChildNode);

    //     XMLCurrNode4 := XMLDoc.CreateElement('Lines');
    //     XMLCurrNode3.AppendChild(XMLCurrNode4);

    //     SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //     SalesCrMemoLine.SETFILTER(Type, '<>%1&<>%2', SalesCrMemoLine.Type::"Charge (Item)", SalesCrMemoLine.Type::" ");//exclude charge item and free text
    //     SalesCrMemoLine.SETAUTOCALCFIELDS();//HEI.08
    //     if SalesCrMemoLine.FINDSET(false, false) then
    //         repeat
    //             XMLCurrNode5 := XMLDoc.CreateElement('Line');
    //             XMLCurrNode4.AppendChild(XMLCurrNode5);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'LineNo', FORMAT(SalesCrMemoLine."Line No."), '', NewChildNode);
    //             //to be updated based on setup
    //             if SalesCrMemoLine.Type <> SalesCrMemoLine.Type::Item then
    //                 XMLDOMMgt.AddElement(XMLCurrNode5, 'Product', SEMInterfaceSetup."Mapping Item Code", '', NewChildNode)
    //             else
    //                 XMLDOMMgt.AddElement(XMLCurrNode5, 'Product', SalesCrMemoLine."No.", '', NewChildNode);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'Quantity', FORMAT(SalesCrMemoLine.Quantity, 0, '<Precision,2:2><Standard Format,2>'), '', NewChildNode);
    //             //to be updated as in mapping
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'Amount', FormatSalesCreditMemoAmount(SalesCrMemoHeader, SalesCrMemoLine.Amount), '', NewChildNode);
    //             //to be updated as in mapping
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'Deposit', FormatSalesCreditMemoAmount(SalesCrMemoHeader, GetDepositAmount(1, SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.")), '', NewChildNode);
    //             //to be updated as in mapping
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'DiscountAmount', FormatSalesCreditMemoAmount(SalesCrMemoHeader, GetDiscountAmount(1, SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.") + SalesCrMemoLine."Line Discount Amount"), '', NewChildNode);
    //             //to be updated as in mapping
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'ExtendedAmount', '', '', NewChildNode);

    //             if SalesCrMemoLine."Free Item" then
    //                 XMLDOMMgt.AddElement(XMLCurrNode5, 'FreeOfCharge', 'TRUE', '', NewChildNode)
    //             else
    //                 XMLDOMMgt.AddElement(XMLCurrNode5, 'IsGift', 'FALSE', '', NewChildNode);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'ItemNumber', FORMAT(SalesCrMemoLine."Line No."), '', NewChildNode);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'PricePerUnit', FormatSalesCreditMemoAmount(SalesCrMemoHeader, SalesCrMemoLine."Unit Price"), '', NewChildNode);
    //             if SEMInterfaceSetup."Sales Info. Currency Code" <> '' then
    //                 XMLDOMMgt.AddElement(XMLCurrNode5, 'Currency', SEMInterfaceSetup."Sales Info. Currency Code", '', NewChildNode)
    //             else
    //                 XMLDOMMgt.AddElement(XMLCurrNode5, 'Currency', GeneralLedgerSetup."LCY Code", '', NewChildNode);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'Transaction', SalesCrMemoLine."Document No.", '', NewChildNode);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'Unit', SalesCrMemoLine."Unit of Measure Code", '', NewChildNode);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'VolumeHL', FORMAT(SalesCrMemoLine."Quantity (Base)" * SalesCrMemoLine."Unit Volume HL", 0, '<Precision,2:2><Standard Format,2>'), '', NewChildNode);
    //             XMLDOMMgt.AddElement(XMLCurrNode5, 'Owner', '', '', NewChildNode);
    //         until SalesCrMemoLine.NEXT = 0;

    //     CLEAR(NewChildNode);
    //     CLEAR(XMLCurrNode3);
    //     CLEAR(XMLCurrNode4);
    //     CLEAR(XMLCurrNode5);
    //     //HEI.06<<
    // end;

    //BC Upgrade VAMSIU01<< - Blocked Temporarily
    local procedure CheckNumberFormat(ValueToConvert: Text) ValueConverted: Text;
    var
        ValueConverted2: Text;
        DefaultDecimalSeparator: Text;
    begin
        //HEI.06>>
        //Send Amounts without thousands separator
        DefaultDecimalSeparator := COPYSTR(FORMAT(1 / 2), 2, 1);

        if DefaultDecimalSeparator = '.' then
            ValueConverted := DELCHR(ValueToConvert, '=', DELCHR(ValueToConvert, '=', '1234567890.-'))
        else if DefaultDecimalSeparator = ',' then begin
            ValueConverted2 := CONVERTSTR(ValueToConvert, ',', '.');
            ValueConverted := DELCHR(ValueConverted2, '=', DELCHR(ValueConverted2, '=', '1234567890.-'));
        end;
        //HEI.06<<
    end;

    procedure GetNoOfDocProcessed(): Integer;
    begin
        exit(NoOfDocProcessed);
    end;
}

