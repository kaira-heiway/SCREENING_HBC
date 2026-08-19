codeunit 58011 "PowerApps Interface Mgmt."
{
    // Heilite Navision Old Id - 50122

    // version HEI.09

    // HEI.01 CHG2069321 GAVANM01 IBM 13.10.2020 #PowerApps Integration
    // HEI.02 CHG2100336 GAVANM01 IBM 01.03.2021 #bug fixes for INC3345805
    // HEI.03 RITM2646474 CHG2098904 IBM GAVANM01 15.04.2021 #Set up Credit Limit workflow approval for MZ SellCo
    //   # code changes
    // HEI.04 RITM2646474 CHG2098904 IBM GAVANM01 22.04.2021 #Set up Credit Limit workflow approval for MZ SellCo
    //   # code changes
    // HEI.05 INC3464639 IBM GAVANM01 08.02.2021 #Issue with approval apps Panama: can't convert value to decimal
    //   # code changes
    // HEI.06 CHG2094470 HB1870 IBM.GUNERE01 28.06.2021 # ProcessPOApprovalResponse func. created
    // HEI.07 CHG2140231 IBM BHATTA09 21.12.2021 #Arithmetic operation resulted in a overflow
    //   # code changes
    // HEI.08 CHG2155541 IBM NANDIS01 21.04.2022 # Configuration of STP Approval App SierraLeone
    //   # Used "Sell-to Customer No." field to store TENANTID value in stead of "Company Code ID" a SIERRALEONE opco has more than 10 chars
    //   # Data exchange for - PW-PO-APPROVAL-REQ needs to be modified
    // HEI.09 CHG2199462 CC IBM NANDIS01 04.04.2023 # Current Approver ID is fixed to 8 characters but ADID accounts can have more or less than 8 characters
    //   # Instead of 9 char hardcode system will now check the whole id till '@'
    //   # Modified function ProcessApprovalResponse and ProcessPOApprovalResponse

    //BC UPGRADE KAPOOV01 23.04.2026 # Removed domain prefix-'heiway\' from ApproverIDfromWS, as now User ID are stored without domain prefix in Approval Entry Table.
    //BC UPGRADE SHUKLP03 >> Removed domain prefix-'heiway\' from ApproverIDfromWS, as now User ID are stored without domain prefix in Approval Entry Table.


    Permissions = TableData "Approval Entry" = imd,
                  TableData "Approval Comment Line" = imd,
                  TableData "Posted Approval Entry" = imd,
                  TableData "Posted Approval Comment Line" = imd,
                  TableData "Overdue Approval Entry" = imd;

    trigger OnRun();
    begin
    end;

    var
        PowerAppsInterfaceSetup: Record "PowerApps Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        CompanyInformation: Record "Company Information";
        SalesPerson: Record "Salesperson/Purchaser";

    procedure ProcessApprovalResponse(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        ApprovalEntry: Record "Approval Entry";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntryL: Record "Approval Entry";
        ApproverIDfromWS: Code[50];
        Text001: Label 'Approval Entry %1 does not exist in NAV.';
        Text002: Label 'Approval Entry %1 was not sent to PowerApps.';
        ApprovalEntry1: Record "Approval Entry";
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";  // BC Upgrade NANDIS03
    begin
        PowerAppsInterfaceSetup.GET();
        PowerAppsInterfaceSetup.TESTFIELD("Enable PowerApps Integration");
        PowerAppsInterfaceSetup.TESTFIELD("Approval Interface Response");
        if not InterfaceSetup.GET(PowerAppsInterfaceSetup."Approval Interface Response") then exit;
        if not InterfaceSetup.Enabled then exit;

        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.findset() then
            repeat
                ApprovalEntry.SETRANGE("Entry No.", InterfaceEntryLineVIP."Source Line No.");
                if ApprovalEntry.COUNT = 0 then
                    ERROR(Text001, InterfaceEntryLineVIP."Source Line No.");
                ApprovalEntry.SETRANGE("Request Sent FND", true);
                if ApprovalEntry.COUNT = 0 then
                    ERROR(Text002, InterfaceEntryLineVIP."Source Line No.");
                if ApprovalEntry.FINDFIRST() then begin
                    //ApproverIDfromWS := 'heiway\' + DELSTR(InterfaceEntryLineVIP.Description,9);  //HEI.09
                    //ApproverIDfromWS := 'heiway\' + DELSTR(InterfaceEntryLineVIP.Description, STRPOS(InterfaceEntryLineVIP.Description, '@'));  //HEI.09 //BC Upgrade SHUKLP03 <<
                    ApproverIDfromWS := DELSTR(InterfaceEntryLineVIP.Description, STRPOS(InterfaceEntryLineVIP.Description, '@'));  //BC Upgrade SHUKLP03 <<
                    ApprovalEntry.TESTFIELD("Approver ID", ApproverIDfromWS);
                    //ApprovalsMgmt.SetApproverIDfromWS(ApproverIDfromWS);  //  BC Upgrade NANDIS03 - Blocked
                    HeinekenBCUpgrade.SetApproverIDfromWS(ApproverIDfromWS);  // BC Upgrade NANDIS03 - Added
                    //HEI.04<<
                    ApprovalEntry."Response Received FND" := true;
                    ApprovalEntry.MODIFY();
                    //HEI.04>>
                    case InterfaceEntryLineVIP."No." of
                        'APPROVED':
                            begin
                                ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                                /*IF (ApprovalEntry."Table ID" = 36) AND
                                  (ApprovalEntry."Document Type" IN [ApprovalEntry."Document Type"::Order]) THEN BEGIN
                                  ApprovalEntryL.RESET;
                                  ApprovalEntryL.SETRANGE("Table ID",36);
                                  ApprovalEntryL.SETRANGE("Document Type",ApprovalEntryL."Document Type"::Order);
                                  ApprovalEntryL.SETRANGE("Document No.",ApprovalEntry."Document No.");
                                  ApprovalEntryL.SETRANGE(Status,ApprovalEntryL.Status::Approved);
                                  ApprovalEntryL.SETRANGE("Approver ID",USERID);
                                  IF ApprovalEntryL.FINDLAST THEN BEGIN
                                    SalesHeaderL.SETRANGE("Document Type",SalesHeaderL."Document Type"::Order);
                                    SalesHeaderL.SETRANGE("No.",ApprovalEntryL."Document No.");
                                    IF SalesHeaderL.FINDFIRST THEN
                                      SalesHeaderL.ValidateCustomerMinValue(SalesHeaderL);
                                  END;
                                END;*/
                            end;
                        'REJECTED':
                            ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                    end;
                    //commented by HEI.04<<
                    //ApprovalEntry."Response Received" := TRUE;
                    //ApprovalEntry.MODIFY;
                    //commneted by HEI.04>>
                end;
            until InterfaceEntryLineVIP.NEXT() = 0;

    end;

    [EventSubscriber(ObjectType::Table, 454, 'OnAfterValidateEvent', 'Status', false, false)]
    local procedure ApprovalEntry_OnAfterValidateStatus(var Rec: Record "Approval Entry"; var xRec: Record "Approval Entry"; CurrFieldNo: Integer);
    var
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        ApprovalEntry: Record "Approval Entry";
        SalesOrder: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Customer: Record Customer;
        UserSetup: Record "User Setup";
        DimSetEntry: Record "Dimension Set Entry";
        CustLedEntry: Record "Cust. Ledger Entry";
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        if Rec.ISTEMPORARY then exit;
        if (Rec."Table ID" = 36) and (Rec."Document Type" = Rec."Document Type"::Order) and (Rec.Status = Rec.Status::Open) and (xRec.Status = xRec.Status::Created) then
            if UserSetup.GET(Rec."Approver ID") and UserSetup."Approve in PowerApps FND" then begin
                CompanyInformation.GET();
                SalesSetup.GET();  //HEI.02
                PowerAppsInterfaceSetup.GET();
                if not PowerAppsInterfaceSetup."Enable PowerApps Integration" then exit;
                PowerAppsInterfaceSetup.TESTFIELD("Approval Interface Request");
                InterfaceSetup.GET(PowerAppsInterfaceSetup."Approval Interface Request");
                InterfaceSetup.TESTFIELD(Enabled, true);

                ApprovalEntry := Rec;
                CLEAR(InterfaceEntryHeaderVIP);
                //HEI.02<<
                InterfaceEntryHeaderVIP."Sell-to Customer No." := 'N/A';
                InterfaceEntryHeaderVIP.Name := 'N/A';
                InterfaceEntryHeaderVIP."Source No." := 'N/A';
                InterfaceEntryHeaderVIP.Address := 'N/A';
                InterfaceEntryHeaderVIP."Invoice Discount Amount" := 0;
                InterfaceEntryHeaderVIP."VAT Amount" := 0;
                InterfaceEntryHeaderVIP."Amount Including VAT" := 0;
                InterfaceEntryHeaderVIP."Currency Factor" := 0;
                //InterfaceEntryHeaderVIP."Location Code" := '0';  //commented by HEI.03
                InterfaceEntryHeaderVIP.Overdue := 0;   //HEI.05
                InterfaceEntryHeaderVIP."Currency Code" := '0';
                InterfaceEntryHeaderVIP.Amount := 0;
                InterfaceEntryHeaderVIP."Posting Date" := TODAY;
                InterfaceEntryHeaderVIP."Your Reference" := 'N/A';
                //HEI.02>>
                InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
                InterfaceEntryHeaderVIP."Interface Code" := PowerAppsInterfaceSetup."Approval Interface Request";
                InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
                InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Pending;
                InterfaceEntryHeaderVIP."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                InterfaceEntryHeaderVIP."Source Type" := DATABASE::"Approval Entry";
                InterfaceEntryHeaderVIP."Source No." := Rec."Document No.";
                InterfaceEntryHeaderVIP."External Document No." := Rec."Document No.";

                InterfaceEntryHeaderVIP."Global No." := FORMAT(Rec."Entry No.");
                if Rec."Limit Type" = Rec."Limit Type"::"No Limits" then
                    InterfaceEntryHeaderVIP."Pay-to Vendor No." := 'ORDER RELEASE'
                else
                    InterfaceEntryHeaderVIP."Pay-to Vendor No." := FORMAT(Rec."Limit Type");

                if SalesOrder.GET(Rec."Document Type", Rec."Document No.") then begin
                    SalesOrder.CALCFIELDS("Amount Including VAT");
                    if SalesOrder."Bill-to Customer No." <> '' then
                        InterfaceEntryHeaderVIP."Sell-to Customer No." := SalesOrder."Bill-to Customer No."
                    else if SalesOrder."Sell-to Customer No." <> '' then
                        InterfaceEntryHeaderVIP."Sell-to Customer No." := SalesOrder."Sell-to Customer No.";

                    if Customer.GET(InterfaceEntryHeaderVIP."Sell-to Customer No.") then begin
                        InterfaceEntryHeaderVIP.Name := Customer.Name;
                        InterfaceEntryHeaderVIP."Invoice Discount Amount" := Customer."Credit Limit (LCY)";
                        //InterfaceEntryHeaderVIP."Amount Including VAT" := Customer."Deposit Limit (LCY)";  // BC Upgrade NANDIS03 - Blocked as DIT field
                    end;

                    if SalesPerson.GET(SalesOrder."Salesperson Code") then
                        InterfaceEntryHeaderVIP.Address := SalesPerson.Name;

                    InterfaceEntryHeaderVIP.Amount := SalesOrder."Amount Including VAT";
                    InterfaceEntryHeaderVIP."Posting Date" := SalesOrder."Requested Delivery Date";

                    CustLedEntry.RESET();
                    CustLedEntry.SETCURRENTKEY(Open, "Due Date");
                    CustLedEntry.SETRANGE("Customer No.", SalesOrder."Bill-to Customer No.");
                    CustLedEntry.SETFILTER("Remaining Amount", '<>%1', 0);
                    CustLedEntry.SETFILTER("Due Date", '<%1', WORKDATE());
                    //HEI.02<<
                    // BC Upgrade NANDIS03 - Blocked as DIT fields >> "Item Charge Type" >> Obsolete
                    // if SalesSetup."Excl. Deposit Credit Warnings" then
                    //   CustLedEntry.SETFILTER("Item Charge Type",'<>%1',CustLedEntry."Item Charge Type"::Deposit);
                    // BC Upgrade NANDIS03 - Blocked as DIT fields << "Item Charge Type" >> Obsolete
                    //HEI.02>>
                    CustLedEntry.SETAUTOCALCFIELDS("Remaining Amount");
                    if CustLedEntry.FINDFIRST() then
                        InterfaceEntryHeaderVIP."Currency Code" := FORMAT(WORKDATE() - CustLedEntry."Due Date" - 1);
                end;

                InterfaceEntryHeaderVIP."VAT Amount" := Rec."Available Credit Limit (LCY)";
                InterfaceEntryHeaderVIP."Currency Factor" := Rec."Av.Overdue Limit (LCY) 101FDW";  // BC Upgrade SHUKLP03 <<
                //InterfaceEntryHeaderVIP."Location Code" := FORMAT(Rec."Overdue Balance"); //commented by HEI.05
                // InterfaceEntryHeaderVIP.Overdue := Rec."Overdue Balance";  //HEI.05  // BC Upgrade NANDIS03 - Blocked as DIT field
                InterfaceEntryHeaderVIP."Your Reference" := Rec."Approver ID" + '@heiway.net'; // BC Upgrade SHUKLP03 << 
                InterfaceEntryHeaderVIP.County := COMPANYNAME;
                InterfaceEntryHeaderVIP."Bill-to Customer No." := TENANTID();
                InterfaceEntryHeaderVIP.INSERT(true);

                SalesLine.SETRANGE("Document Type", SalesOrder."Document Type");
                SalesLine.SETRANGE("Document No.", SalesOrder."No.");
                //SalesLine.SETRANGE(Type,SalesLine.Type::Item);   //commented by HEI.02
                //HEI.02<<
                SalesLine.SETFILTER(Type, '%1|%2|%3|%4', SalesLine.Type::Item, SalesLine.Type::Resource, SalesLine.Type::"G/L Account", SalesLine.Type::"Charge (Item)");
                SalesLine.SetRange("Attached to Line No.", 0); // BC Upgrade SHUKLP03 
                //HEI.02>>
                if SalesLine.FINDFIRST() then
                    repeat
                        CLEAR(InterfaceEntryLineVIP);
                        //HEI.02<<
                        InterfaceEntryLineVIP."No." := 'N/A';
                        InterfaceEntryLineVIP.Description := 'N/A';
                        InterfaceEntryLineVIP.Quantity := 0;
                        InterfaceEntryLineVIP."Item Dim. Value Code1" := 'N/A';
                        //HEI.02>>
                        InterfaceEntryLineVIP."Header Entry No." := InterfaceEntryHeaderVIP."Entry No.";
                        InterfaceEntryLineVIP."Entry No." := SalesLine."Line No.";
                        InterfaceEntryLineVIP."No." := SalesLine."No.";
                        InterfaceEntryLineVIP.Description := SalesLine.Description;
                        InterfaceEntryLineVIP.Quantity := SalesLine.Quantity;

                        CLEAR(DimSetEntry);
                        DimSetEntry.SETRANGE("Dimension Set ID", SalesLine."Dimension Set ID");
                        DimSetEntry.SETFILTER("Dimension Code", '=%1', 'INV_LEV');
                        //DimSetEntry.SETAUTOCALCFIELDS("Dimension Value Name");
                        if DimSetEntry.FINDFIRST() then
                            InterfaceEntryLineVIP."Item Dim. Value Code1" := DimSetEntry."Dimension Value Code";

                        InterfaceEntryLineVIP.INSERT(true);
                    until SalesLine.NEXT() = 0;

                Rec."Request Sent FND" := true;
                Rec.MODIFY();
            end;
    end;

    procedure ProcessPOApprovalResponse(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        ApprovalEntry: Record "Approval Entry";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntryL: Record "Approval Entry";
        ApproverIDfromWS: Code[50];
        Text001: Label 'Approval Entry %1 does not exist in NAV.';
        Text002: Label 'Approval Entry %1 was not sent to PowerApps.';
        ApprovalEntry1: Record "Approval Entry";
        ApprovalCommentLine: Record "Approval Comment Line";
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";  // BC Upgrade NANDIS03
    begin
        //>> HEI.06
        PowerAppsInterfaceSetup.GET();
        PowerAppsInterfaceSetup.TESTFIELD("Enable PowerApps PO Intg.");
        PowerAppsInterfaceSetup.TESTFIELD("PO Approval Interface Response");
        if not InterfaceSetup.GET(PowerAppsInterfaceSetup."PO Approval Interface Response") then exit;
        if not InterfaceSetup.Enabled then exit;

        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.findset() then
            repeat
                ApprovalEntry.SETRANGE("Entry No.", InterfaceEntryLineVIP."Source Line No.");
                if ApprovalEntry.COUNT = 0 then
                    ERROR(Text001, InterfaceEntryLineVIP."Source Line No.");
                ApprovalEntry.SETRANGE("Request Sent FND", true);
                if ApprovalEntry.COUNT = 0 then
                    ERROR(Text002, InterfaceEntryLineVIP."Source Line No.");
                if ApprovalEntry.FINDFIRST() then begin
                    //ApproverIDfromWS := 'heiway\' + DELSTR(InterfaceEntryLineVIP.Description,9);  //HEI.09
                    //ApproverIDfromWS := 'heiway\' + DELSTR(InterfaceEntryLineVIP.Description, STRPOS(InterfaceEntryLineVIP.Description, '@'));  //HEI.09 //BC UPGRADE KAPOOV01 Commented
                    ApproverIDfromWS := DELSTR(InterfaceEntryLineVIP.Description, STRPOS(InterfaceEntryLineVIP.Description, '@'));  //HEI.09 //BC UPGRADE KAPOOV01 Added
                    ApprovalEntry.TESTFIELD("Approver ID", ApproverIDfromWS);
                    //ApprovalsMgmt.SetApproverIDfromWS(ApproverIDfromWS);  // BC Upgrade NANDIS03 - Blocked
                    HeinekenBCUpgrade.SetApproverIDfromWS(ApproverIDfromWS);  // BC Upgrade NANDIS03 - Added
                    ApprovalEntry."Response Received FND" := true;
                    if InterfaceEntryLineVIP."Description 2" <> '' then begin
                        ApprovalCommentLine.SETRANGE("Table ID", ApprovalEntry."Table ID");
                        ApprovalCommentLine.SETRANGE("Record ID to Approve", ApprovalEntry."Record ID to Approve");
                        ApprovalCommentLine.SETRANGE("Workflow Step Instance ID", ApprovalEntry."Workflow Step Instance ID");
                        if not ApprovalCommentLine.FINDFIRST() then begin
                            ApprovalCommentLine.INIT();
                            ApprovalCommentLine.Comment := InterfaceEntryLineVIP."Description 2";
                            ApprovalCommentLine.INSERT(true);
                        end;
                    end;
                    ApprovalEntry.MODIFY();
                    case InterfaceEntryLineVIP."No." of
                        'APPROVED':
                            begin
                                ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                            end;
                        'REJECTED':
                            ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                    end;
                end;
            until InterfaceEntryLineVIP.NEXT() = 0;
        //<< HEI.06
    end;

    [EventSubscriber(ObjectType::Table, 454, 'OnAfterValidateEvent', 'Status', false, false)]
    local procedure ApprovalEntryPO_OnAfterValidateStatus(var Rec: Record "Approval Entry"; var xRec: Record "Approval Entry"; CurrFieldNo: Integer);
    var
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        ApprovalEntry: Record "Approval Entry";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        UserSetup: Record "User Setup";
        DimSetEntry: Record "Dimension Set Entry";
        CustLedEntry: Record "Cust. Ledger Entry";
        SalesSetup: Record "Sales & Receivables Setup";
        Vendor: Record Vendor;
        LineEntryNo: Integer;
        DocType: Text;
    begin
        //HEI.06>>
        if Rec.ISTEMPORARY then exit;
        if (Rec."Table ID" = 38) and (Rec."Document Type" in [Rec."Document Type"::Order, Rec."Document Type"::Quote]) and (Rec.Status in [Rec.Status::Open, Rec.Status::Canceled]) then
            if UserSetup.GET(Rec."Approver ID") then
                if UserSetup."Approve in PowerApps FND" then begin
                    CompanyInformation.GET();
                    PowerAppsInterfaceSetup.GET();
                    if not PowerAppsInterfaceSetup."Enable PowerApps PO Intg." then exit;
                    PowerAppsInterfaceSetup.TESTFIELD("PO Approval Interface Request");
                    InterfaceSetup.GET(PowerAppsInterfaceSetup."PO Approval Interface Request");
                    InterfaceSetup.TESTFIELD(Enabled, true);

                    ApprovalEntry := Rec;
                    CLEAR(InterfaceEntryHeaderVIP);
                    //HEI.02<<
                    //HEI.08>>
                    //InterfaceEntryHeaderVIP."Company Code ID" := TENANTID;
                    InterfaceEntryHeaderVIP."Sell-to Customer No." := TENANTID();
                    //HEI.08<<
                    InterfaceEntryHeaderVIP.Comment := COMPANYNAME;
                    InterfaceEntryHeaderVIP."Your Reference" := FORMAT(Rec."Entry No.");
                    InterfaceEntryHeaderVIP."Vendor Shipment No." := FORMAT(Rec.Status);
                    InterfaceEntryHeaderVIP.Address := Rec."Approver ID" + '@heiway.net'; // BC Upgrade SHUKLP03 <<
                    InterfaceEntryHeaderVIP.County := Rec."Sender ID" + '@heiway.net'; // BC Upgrade SHUKLP03 <<
                    ;
                    InterfaceEntryHeaderVIP."Delivery Method" := ReturnTableName(Rec."Table ID");
                    InterfaceEntryHeaderVIP."Global No." := FORMAT(ApprovalEntry."Document Type");
                    PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
                    InterfaceEntryHeaderVIP."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                    InterfaceEntryHeaderVIP."Source No." := PurchaseHeader."No.";
                    Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
                    InterfaceEntryHeaderVIP.Name := Vendor.Name;
                    PurchaseHeader.CALCFIELDS("Amount Including VAT");
                    InterfaceEntryHeaderVIP."Amount Including VAT" := PurchaseHeader."Amount Including VAT";
                    InterfaceEntryHeaderVIP."Currency Code" := PurchaseHeader."Currency Code";
                    InterfaceEntryHeaderVIP."Requested Receipt Date" := PurchaseHeader."Requested Receipt Date";
                    InterfaceEntryHeaderVIP."Message Code" := ReturnPurchaserName(PurchaseHeader."Purchaser Code");
                    InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
                    InterfaceEntryHeaderVIP."Interface Code" := PowerAppsInterfaceSetup."PO Approval Interface Request";
                    InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
                    InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Pending;
                    InterfaceEntryHeaderVIP.INSERT(true);
                    PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                    PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                    LineEntryNo := 0;
                    if PurchaseLine.findset() then
                        repeat
                            //LineEntryNo += LineEntryNo + 1;//commented old code//HEI.07
                            LineEntryNo := LineEntryNo + 1;//HEI.07
                            InterfaceEntryLineVIP."Header Entry No." := InterfaceEntryHeaderVIP."Entry No.";
                            InterfaceEntryLineVIP."Entry No." := LineEntryNo;
                            InterfaceEntryLineVIP."No." := PurchaseLine."No.";
                            InterfaceEntryLineVIP.Description := PurchaseLine.Description;
                            InterfaceEntryLineVIP.Quantity := PurchaseLine.Quantity;
                            InterfaceEntryLineVIP."Location Code" := PurchaseLine."Location Code";
                            InterfaceEntryLineVIP."VAT Amount" := PurchaseLine."Direct Unit Cost";
                            InterfaceEntryLineVIP."Line Amount" := PurchaseLine.Amount;
                            CLEAR(DimSetEntry);
                            DimSetEntry.SETRANGE("Dimension Set ID", PurchaseLine."Dimension Set ID");
                            DimSetEntry.SETFILTER("Dimension Code", '=%1', 'CCC');
                            if DimSetEntry.FINDFIRST() then begin
                                DimSetEntry.CALCFIELDS("Dimension Value Name");
                                InterfaceEntryLineVIP."Item Dim. Value Code2" := DimSetEntry."Dimension Value Code";
                                InterfaceEntryLineVIP."Description 2" := DimSetEntry."Dimension Value Name";
                            end else begin
                                InterfaceEntryLineVIP."Item Dim. Value Code2" := '';
                                InterfaceEntryLineVIP."Description 2" := '';
                            end;
                            InterfaceEntryLineVIP.INSERT(true);

                        until PurchaseLine.NEXT() = 0;

                    Rec."Request Sent FND" := true;
                    Rec.MODIFY();
                end;
        //HEI.06<<
    end;

    local procedure ReturnPurchaserName(PurchaserCode: Code[10]): Text;
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        //HEI.06>>
        if SalespersonPurchaser.GET(PurchaserCode) then
            exit(SalespersonPurchaser.Name);
        //HEI.06<<
    end;

    local procedure ReturnTableName(TableID: Integer): Text;
    var
        RecRef: RecordRef;
    begin
        //HEI.06>>
        RecRef.OPEN(TableID);
        exit(RecRef.NAME);
        //HEI.06<<
    end;
}

