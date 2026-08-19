codeunit 58050 "Cash Van Sales Interface Manag"
{
    //BC Upgrade GUNERE01 - Old ID 50051

    // HEI.01 Cash Van Solution IBM HORTOC01 - new Codeunit for CVS Interface
    // HEI.02  IBM HORTOC01 - new small adjustments based in A testings
    // HEI.03  IBM HORTOC01 - add Inv_Lev dimension for free item lines
    // HEI.04 IBM HORTOC01 - remove check on item cross reference

    Permissions = TableData "Item Ledger Entry" = rimd;

    trigger OnRun();
    var
    // ILE: Record "Item Ledger Entry";
    // Item: Record Item;
    begin
    end;

    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        GeneralInterfaceSetupRead: Boolean;
        CashVanSalesInterfaceSetupRead: Boolean;

    procedure ProcessCurrencyRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        Currency: Record Currency;
        InterfaceEntryLine: Record "Interface Entry Line INT";
        EntryNo: Integer;
    begin

        //Currency NAV -> CVS
        GetCashVanSalesInterfaceSetup;
        //ERROR('test' + CashVanSalesInterfaceSetup."CVS Currency Response Interf.");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Currency Response Interf.");
        if not InterfaceSetup.Enabled then
            exit;
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := CashVanSalesInterfaceSetup."CVS Currency Response Interf.";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                InterfaceEntryLine.TESTFIELD("Currency Code");
                if InterfaceEntryLine."Currency Code" <> '*' then begin
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut.TRANSFERFIELDS(InterfaceEntryLine, false);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                    Currency.RESET;
                    Currency.GET(InterfaceEntryLine."Currency Code");
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                    //InterfaceEntryLineOut."Type ID" := CashVanSalesInterfaceSetup."CVS Currency Response Interf.";
                    InterfaceEntryLineOut."Currency Code" := Currency.Code;
                    InterfaceEntryLineOut.Description := Currency.Description;
                    InterfaceEntryLineOut.INSERT;
                end else begin
                    CLEAR(EntryNo);
                    CLEAR(InterfaceEntryLineOut);
                    Currency.RESET;
                    if Currency.FINDSET then
                        repeat
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            //InterfaceEntryLineOut."Type ID" := CashVanSalesInterfaceSetup."CVS Currency Response Interf.";
                            InterfaceEntryLineOut."Currency Code" := Currency.Code;
                            InterfaceEntryLineOut.Description := Currency.Description;
                            InterfaceEntryLineOut.INSERT;
                        until Currency.NEXT = 0;
                end;
            until InterfaceEntryLine.NEXT = 0;

        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessCurrencyExchRateRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        InterfaceSetup: Record "Interface Setup INT";
        EntryNo: Integer;
        Currency: Record Currency;
    begin
        //Currency Exch. Rate NAV -> CVS
        GetGeneralInterfaceSetup;
        GetCashVanSalesInterfaceSetup;

        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Curr Exch. Rate Res Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := CashVanSalesInterfaceSetup."CVS Curr Exch. Rate Res Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                InterfaceEntryLine.TESTFIELD("Currency Code");
                if InterfaceEntryLine."Currency Code" <> '*' then begin
                    CurrencyExchangeRate.RESET;
                    CurrencyExchangeRate.SETFILTER("Starting Date", '<=%1', TODAY);
                    CurrencyExchangeRate.SETRANGE("Currency Code", InterfaceEntryLine."Currency Code");
                    if CurrencyExchangeRate.FINDFIRST then begin
                        CLEAR(InterfaceEntryLineOut);
                        EntryNo += 1;
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                        InterfaceEntryLineOut."Currency Code" := CurrencyExchangeRate."Currency Code";
                        InterfaceEntryLineOut."Relational Currency Code" := CurrencyExchangeRate."Relational Currency Code";
                        InterfaceEntryLineOut."Exchange Rate Amount" := CurrencyExchangeRate."Relational Exch. Rate Amount";
                        InterfaceEntryLineOut.INSERT;
                    end;
                end else begin
                    Currency.RESET;
                    if Currency.FINDSET then
                        repeat
                            CurrencyExchangeRate.RESET;
                            CurrencyExchangeRate.SETFILTER("Starting Date", '<=%1', TODAY);
                            CurrencyExchangeRate.SETRANGE("Currency Code", Currency.Code);
                            if CurrencyExchangeRate.FINDLAST then begin
                                //CurrencyExchangeRate.TESTFIELD("Relational Currency Code");
                                CurrencyExchangeRate.TESTFIELD("Relational Exch. Rate Amount");
                                CLEAR(InterfaceEntryLineOut);
                                EntryNo += 1;
                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                InterfaceEntryLineOut."Entry No." := EntryNo;
                                InterfaceEntryLineOut."Currency Code" := CurrencyExchangeRate."Currency Code";
                                InterfaceEntryLineOut."Relational Currency Code" := CurrencyExchangeRate."Relational Currency Code";
                                InterfaceEntryLineOut."Exchange Rate Amount" := CurrencyExchangeRate."Relational Exch. Rate Amount";
                                InterfaceEntryLineOut.INSERT;
                            end;
                        until Currency.NEXT = 0;


                end;
            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessSalesPersonRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Location: Record Location;
        // Route: Record Route; //BC Upgrade GUNREM01 - DIT Table
        SalesPError: Label 'SalesPerson %1 is not assign to any Route!';
        EntryNo: Integer;
    begin

        //Salesperson NAV -> CVS
        GetGeneralInterfaceSetup;
        GetCashVanSalesInterfaceSetup;
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS SalesP/Purch. Resp. Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := CashVanSalesInterfaceSetup."CVS SalesP/Purch. Resp. Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."SalesPers./Purch. Code" <> '*' then begin
                    SalespersonPurchaser.RESET;
                    SalespersonPurchaser.GET(InterfaceEntryLine."SalesPers./Purch. Code");
                    //BC Upgrade GUNREM01 deperecated DIT Table >>
                    // Route.RESET;
                    // Route.SETRANGE("Salesperson/Purchaser Code", InterfaceEntryLine."SalesPers./Purch. Code");
                    // Route.SETRANGE("Van Sales Route", true);
                    // if not Route.FINDFIRST then
                    //     ERROR(SalesPError, InterfaceEntryLine."SalesPers./Purch. Code")
                    // else 
                    //BC Upgrade GUNREM01 deperecated DIT Table <<
                    begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                        InterfaceEntryLineOut."SalesPers./Purch. Code" := SalespersonPurchaser.Code;
                        InterfaceEntryLineOut.Description := SalespersonPurchaser.Name;
                        //BC Upgrade GUNREM01 deperecated DIT Table >>
                        // InterfaceEntryLineOut."Location Code" := Route."Location Code";
                        // InterfaceEntryLineOut."Truck Code" := Route."Truck Code";
                        // InterfaceEntryLineOut."Driver Code" := Route."Driver Code";
                        // InterfaceEntryLineOut."No." := Route.Code;
                        //BC Upgrade GUNREM01 deperecated DIT Table <<
                        InterfaceEntryLineOut.INSERT;
                    end;
                end else begin
                    SalespersonPurchaser.RESET;
                    if SalespersonPurchaser.FINDSET then
                        repeat
                        // Route.RESET;
                        // Route.SETRANGE("Salesperson/Purchaser Code", SalespersonPurchaser.Code);
                        // Route.SETRANGE("Van Sales Route", true);
                        // if Route.FINDFIRST then
                        begin
                            SalespersonPurchaser.TESTFIELD(Name);
                            EntryNo += 1;
                            CLEAR(InterfaceEntryLineOut);
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut."SalesPers./Purch. Code" := SalespersonPurchaser.Code;
                            InterfaceEntryLineOut.Description := SalespersonPurchaser.Name;
                            // InterfaceEntryLineOut."Location Code" := Route."Location Code";
                            // InterfaceEntryLineOut."Truck Code" := Route."Truck Code";
                            // InterfaceEntryLineOut."Driver Code" := Route."Driver Code";
                            // InterfaceEntryLineOut."No." := Route.Code;
                            InterfaceEntryLineOut.INSERT;
                        end;
                        until SalespersonPurchaser.NEXT = 0;
                end;
            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessCustomerRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        Customer: Record Customer;
        Location: Record Location;
        //   Route: Record Route; //BC Upgrade GUNREM01 - DIT Table
        BlockErr: Label 'The customer %1 is blocked for %2';
        EntryNo: Integer;
        GeneralLedgerSetup: Record "General Ledger Setup";
        Customer2: Record Customer;
        CustomerAttributes: Record "Customer Attributes FND";
    begin
        //Customer NAV -> CVS
        GetGeneralInterfaceSetup;
        GetCashVanSalesInterfaceSetup;
        GeneralLedgerSetup.GET;
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Customer Respons Interface");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := CashVanSalesInterfaceSetup."CVS Customer Respons Interface";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Sell-to Customer No." <> '*' then begin
                    Customer.RESET;
                    Customer.GET(InterfaceEntryLine."Sell-to Customer No.");
                    //   Customer.TESTFIELD(Route); //BC Upgrade GUNREM01 - DIT Table
                    if (Customer.Blocked <> Customer.Blocked::" ") and (Customer.Blocked <> Customer.Blocked::Invoice) then
                        ERROR(BlockErr, Customer."No.", Customer.Blocked);
                    //BC Upgrade GUNREM01 - DIT Table >>
                    // Route.GET(Customer.Route);
                    // Route.TESTFIELD("Van Sales Route");
                    //BC Upgrade GUNREM01 - DIT Table <<
                    Customer2.GET(Customer."Bill-to Customer No.");
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                    InterfaceEntryLineOut."Sell-to Customer No." := Customer."No.";
                    //HEI.02>>
                    //InterfaceEntryLineOut."Ship-to Name" := Customer.Name;
                    if Customer."Name 2" <> '' then
                        InterfaceEntryLineOut."Log Message" := Customer.Name + ' ' + Customer."Name 2"
                    else
                        InterfaceEntryLineOut."Log Message" := Customer.Name;
                    //InterfaceEntryLineOut."Ship-to Address" := Customer.Address;
                    //InterfaceEntryLineOut."Ship-to Address 2" := Customer."Address 2";
                    InterfaceEntryLineOut."Ship-to Address" := COPYSTR(Customer.City + ' ' + Customer.Address, 1, 49) + ' ';
                    if CustomerAttributes.GET(Customer."No.") then;
                    InterfaceEntryLineOut."Ship-to Address 2" := COPYSTR(CustomerAttributes."Street 3" + ' ' + Customer."Address 2" + ' ' + CustomerAttributes."Street 5", 1, 50);
                    //HEI.02<<
                    InterfaceEntryLineOut."Phone No." := Customer."Phone No.";
                    if Customer2."Currency Code" <> '' then
                        InterfaceEntryLineOut."Currency Code" := Customer2."Currency Code"
                    else
                        InterfaceEntryLineOut."Currency Code" := GeneralLedgerSetup."LCY Code";
                    // InterfaceEntryLineOut.Description := Customer2."Tax Registration No."; //BC Upgrade GUNREM01 - DIT field
                    InterfaceEntryLineOut."Description 2" := Customer2."VAT Registration No.";
                    InterfaceEntryLineOut.INSERT;
                end else begin
                    Customer.RESET;
                    //  Customer.SETFILTER(Route, '<>%1', ''); //BC Upgrade GUNREM01 - DIT Field
                    Customer.SETFILTER(Blocked, '%1|%2', Customer.Blocked::" ", Customer.Blocked::Invoice);
                    if Customer.FINDSET then
                        repeat
                            //BC Upgrade GUNREM01 - DIT Table >>
                            // if Route.GET(Customer.Route) then
                            //     if Route."Van Sales Route" then begin
                            //BC Upgrade GUNREM01 - DIT Table <<
                            if Customer2.GET(Customer."Bill-to Customer No.") then begin
                                CLEAR(InterfaceEntryLineOut);
                                EntryNo += 1;
                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                InterfaceEntryLineOut."Entry No." := EntryNo;
                                InterfaceEntryLineOut."Sell-to Customer No." := Customer."No.";
                                //HEI.02>>
                                //InterfaceEntryLineOut."Ship-to Name" := Customer.Name;
                                if Customer."Name 2" <> '' then
                                    InterfaceEntryLineOut."Log Message" := Customer.Name + ' ' + Customer."Name 2"
                                else
                                    InterfaceEntryLineOut."Log Message" := Customer.Name;
                                //InterfaceEntryLineOut."Ship-to Address" := Customer.Address;
                                //InterfaceEntryLineOut."Ship-to Address 2" := Customer."Address 2";
                                InterfaceEntryLineOut."Ship-to Address" := COPYSTR(Customer.City + ' ' + Customer.Address, 1, 49) + ' ';
                                if CustomerAttributes.GET(Customer."No.") then;
                                InterfaceEntryLineOut."Ship-to Address 2" := COPYSTR(CustomerAttributes."Street 3" + ' ' + Customer."Address 2" + ' ' + CustomerAttributes."Street 5", 1, 50);
                                //HEI.02<<
                                InterfaceEntryLineOut."Phone No." := Customer."Phone No.";
                                if Customer2."Currency Code" <> '' then
                                    InterfaceEntryLineOut."Currency Code" := Customer2."Currency Code"
                                else
                                    InterfaceEntryLineOut."Currency Code" := GeneralLedgerSetup."LCY Code";
                                //  InterfaceEntryLineOut.Description := Customer2."Tax Registration No."; //BC Upgrade GUNREM01 - DIT field
                                InterfaceEntryLineOut."Description 2" := Customer2."VAT Registration No.";
                                InterfaceEntryLineOut.INSERT;
                            end;
                        //  end;
                        until Customer.NEXT = 0;
                end;
            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessCustomerPriceListRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        Customer: Record Customer;
        Location: Record Location;
        BlockErr: Label 'The customer %1 is blocked for %2';
        // Route: Record Route; //BC Upgrade GUNREM01 - DIT Table
        EntryNo: Integer;
        GeneralLedgerSetup: Record "General Ledger Setup";
        Customer2: Record Customer;
    begin
        //Customer Price List NAV -> CVS
        GetGeneralInterfaceSetup;
        GetCashVanSalesInterfaceSetup;
        GeneralLedgerSetup.GET;
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Cust Price List Res Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := CashVanSalesInterfaceSetup."CVS Cust Price List Res Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Sell-to Customer No." <> '*' then begin
                    Customer.RESET;
                    Customer.GET(InterfaceEntryLine."Sell-to Customer No.");
                    //   Customer.TESTFIELD(Route); //BC Upgrade GUNREM01 - DIT field
                    Customer.TESTFIELD("Salesperson Code");
                    if (Customer.Blocked <> Customer.Blocked::" ") and (Customer.Blocked <> Customer.Blocked::Invoice) then
                        ERROR(BlockErr, Customer."No.", Customer.Blocked);
                    //BC Upgrade GUNREM01 - DIT Table >>
                    // Route.GET(Customer.Route);
                    // Route.TESTFIELD("Van Sales Route");
                    //BC Upgrade GUNREM01 - DIT Table <<
                    Customer2.GET(Customer."Bill-to Customer No.");
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                    InterfaceEntryLineOut."Sales Code" := Customer2."Customer Price Group";
                    InterfaceEntryLineOut."Sell-to Customer No." := Customer."No.";
                    InterfaceEntryLineOut."SalesPers./Purch. Code" := Customer."Salesperson Code";
                    if Customer2."Currency Code" <> '' then
                        InterfaceEntryLineOut."Currency Code" := Customer2."Currency Code"
                    else
                        InterfaceEntryLineOut."Currency Code" := GeneralLedgerSetup."LCY Code";
                    //InterfaceEntryLineOut."Currency Code" := Customer."Currency Code";
                    InterfaceEntryLineOut.INSERT;
                end else begin
                    Customer.RESET;
                    //  Customer.SETFILTER(Route, '<>%1', ''); //BC Upgrade GUNREM01 - DIT field
                    Customer.SETFILTER(Blocked, '%1|%2', Customer.Blocked::" ", Customer.Blocked::Invoice);
                    if Customer.FINDSET then
                        repeat
                            //BC Upgrade GUNREM01 - DIT Table >>
                            // if Route.GET(Customer.Route) then
                            //     if Route."Van Sales Route" then begin
                            //BC Upgrade GUNREM01 - DIT Table <<
                            Customer2.GET(Customer."Bill-to Customer No.");
                            Customer.TESTFIELD("Salesperson Code");
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut."Sales Code" := Customer2."Customer Price Group";
                            InterfaceEntryLineOut."Sell-to Customer No." := Customer."No.";
                            InterfaceEntryLineOut."SalesPers./Purch. Code" := Customer2."Salesperson Code";
                            if Customer2."Currency Code" <> '' then
                                InterfaceEntryLineOut."Currency Code" := Customer2."Currency Code"
                            else
                                InterfaceEntryLineOut."Currency Code" := GeneralLedgerSetup."LCY Code";
                            //InterfaceEntryLineOut."Currency Code" := Customer."Currency Code";
                            InterfaceEntryLineOut.INSERT;
                        //   end;
                        until Customer.NEXT = 0;
                end;

            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessSalesmanCustomerRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        Customer: Record Customer;
        Location: Record Location;
        BlockErr: Label 'The customer %1 is blocked for %2';
        //  Route: Record Route; //BC Upgrade GUNREM01 - DIT Table
        EntryNo: Integer;
        Customer2: Record Customer;
    begin
        //Customer Price List NAV -> CVS
        GetGeneralInterfaceSetup;
        GetCashVanSalesInterfaceSetup;
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Salesman Cust Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := CashVanSalesInterfaceSetup."CVS Salesman Cust Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Sell-to Customer No." <> '*' then begin
                    Customer.RESET;
                    Customer.GET(InterfaceEntryLine."Sell-to Customer No.");
                    //  Customer.TESTFIELD(Route); //BC Upgrade GUNREM01 - DIT field
                    if (Customer.Blocked <> Customer.Blocked::" ") and (Customer.Blocked <> Customer.Blocked::Invoice) then
                        ERROR(BlockErr, Customer."No.", Customer.Blocked);
                    //BC Upgrade GUNREM01 - DIT Table >>
                    // Route.GET(Customer.Route);
                    // Route.TESTFIELD("Van Sales Route");
                    //BC Upgrade GUNREM01 - DIT Table <<
                    Customer.TESTFIELD("Salesperson Code");
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                    //  InterfaceEntryLineOut."VAT %" := GetDrinkItDiscPercentage(InterfaceEntryLine."Sell-to Customer No."); //BC Upgrade GUNREM01 -GetDrinkItDiscPercentage DIT Function 
                    InterfaceEntryLineOut."Sell-to Customer No." := Customer."No.";
                    InterfaceEntryLineOut."SalesPers./Purch. Code" := Customer."Salesperson Code";
                    InterfaceEntryLineOut.INSERT;
                    //ERROR(FORMAT(GetDrinkItDiscPercentage(InterfaceEntryLine."Sell-to Customer No.")));
                end else begin
                    Customer.RESET;
                    // Customer.SETFILTER(Route, '<>%1', ''); //BC Upgrade GUNREM01 - DIT field
                    Customer.SETFILTER(Blocked, '%1|%2', Customer.Blocked::" ", Customer.Blocked::Invoice);
                    if Customer.FINDSET then
                        repeat
                            //BC Upgrade GUNREM01 - DIT Table >>
                            // if Route.GET(Customer.Route) then
                            //     if Route."Van Sales Route" then begin
                            //BC Upgrade GUNREM01 - DIT Table <<
                            Customer.TESTFIELD("Salesperson Code");
                            Customer2.GET(Customer."Bill-to Customer No.");
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            // InterfaceEntryLineOut."VAT %" := GetDrinkItDiscPercentage(Customer2."No."); //BC Upgrade GUNREM01 -GetDrinkItDiscPercentage DIT Function 
                            InterfaceEntryLineOut."Sell-to Customer No." := Customer."No.";
                            InterfaceEntryLineOut."SalesPers./Purch. Code" := Customer2."Salesperson Code";
                            InterfaceEntryLineOut.INSERT;
                        //   end;
                        until Customer.NEXT = 0;
                end;
            until InterfaceEntryLine.NEXT = 0;

        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessItemRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        Item: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        VATPostingSetup: Record "VAT Posting Setup";
        //  ItemCrossReference: Record "Item Cross Reference";
        ItemCrossReference: Record "Item Reference"; //BC upgrade GUNREM01 replaced Item Cross Reference table
        ItemCrossRefError: Label 'Item No. %1 has no item cross reference with type bar code!';
        DefaultDimension: Record "Default Dimension";
        entryNo: Integer;
        MissingSKUError: Label 'Item No. %1 has no SKU for Van Sales';
    begin
        //Items NAV -> CVS
        GetGeneralInterfaceSetup;
        GetCashVanSalesInterfaceSetup;
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Item Response Interface");

        if not InterfaceSetup.Enabled then
            exit;
        GeneralInterfaceSetup.TESTFIELD("Brand Dim. Code");
        CashVanSalesInterfaceSetup.TESTFIELD("Item Category Filter");
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := CashVanSalesInterfaceSetup."CVS Item Response Interface";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Item No." <> '*' then begin
                    Item.RESET;
                    Item.GET(InterfaceEntryLine."Item No.");
                    Item.TESTFIELD(Blocked, false);
                    Item.TESTFIELD(Description);
                    /*HEI.04
                    ItemCrossReference.SETRANGE("Item No.",Item."No.");
                    ItemCrossReference.SETRANGE("Cross-Reference Type",ItemCrossReference."Cross-Reference Type"::"Bar Code");
                    IF NOT ItemCrossReference.FINDFIRST THEN
                       ERROR(ItemCrossRefError,Item."No.");
                    */
                    //HEI.04>>
                    if not CheckSKUExist(Item) then
                        ERROR(MissingSKUError, Item."No.");
                    //HEI.04<<
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                    InterfaceEntryLineOut."Item No." := Item."No.";
                    InterfaceEntryLineOut.Description := Item.Description;
                    InterfaceEntryLineOut."Cross Reference No." := GetItemCrossReference(Item);
                    if DefaultDimension.GET(27, Item."No.", GeneralInterfaceSetup."Brand Dim. Code") then
                        InterfaceEntryLineOut."Shortcut Dimension 1 Code" := DefaultDimension."Dimension Value Code";
                    VATPostingSetup.RESET;
                    VATPostingSetup.GET(Item."VAT Bus. Posting Gr. (Price)", Item."VAT Prod. Posting Group");
                    VATPostingSetup.TESTFIELD("VAT %");
                    InterfaceEntryLineOut."VAT %" := VATPostingSetup."VAT %";
                    InterfaceEntryLineOut."Sales Unit of Measure" := Item."Sales Unit of Measure";
                    if ItemUnitofMeasure.GET(Item."No.", Item."Sales Unit of Measure") then
                        InterfaceEntryLineOut."Qty. per Unit of Measure" := ItemUnitofMeasure."Qty. per Unit of Measure";
                    InterfaceEntryLineOut.INSERT;
                end else begin
                    Item.RESET;
                    Item.SETFILTER("Item Category Code", CashVanSalesInterfaceSetup."Item Category Filter");
                    Item.SETRANGE(Blocked, false);
                    if Item.FINDSET then
                        repeat
                            /*//HEI.04
                              ItemCrossReference.SETRANGE("Item No.",Item."No.");
                              ItemCrossReference.SETRANGE("Cross-Reference Type",ItemCrossReference."Cross-Reference Type"::"Bar Code");
                              IF ItemCrossReference.FINDFIRST THEN BEGIN
                            */
                            if CheckSKUExist(Item) then begin//HEI.04
                                Item.TESTFIELD(Description);
                                CLEAR(InterfaceEntryLineOut);
                                entryNo += 1;
                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                InterfaceEntryLineOut."Entry No." := entryNo;
                                InterfaceEntryLineOut."Item No." := Item."No.";
                                InterfaceEntryLineOut.Description := Item.Description;
                                InterfaceEntryLineOut."Cross Reference No." := GetItemCrossReference(Item);
                                if DefaultDimension.GET(27, Item."No.", GeneralInterfaceSetup."Brand Dim. Code") then
                                    InterfaceEntryLineOut."Shortcut Dimension 1 Code" := DefaultDimension."Dimension Value Code";
                                VATPostingSetup.RESET;
                                VATPostingSetup.GET(Item."VAT Bus. Posting Gr. (Price)", Item."VAT Prod. Posting Group");
                                VATPostingSetup.TESTFIELD("VAT %");
                                InterfaceEntryLineOut."VAT %" := VATPostingSetup."VAT %";
                                InterfaceEntryLineOut."Sales Unit of Measure" := Item."Sales Unit of Measure";
                                if ItemUnitofMeasure.GET(Item."No.", Item."Sales Unit of Measure") then
                                    InterfaceEntryLineOut."Qty. per Unit of Measure" := ItemUnitofMeasure."Qty. per Unit of Measure";
                                InterfaceEntryLineOut.INSERT;
                            end;
                        until Item.NEXT = 0;

                end;
            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);

    end;

    procedure ProcessProductPriceListRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        SalesPrice: Record "Sales Price";
        Item: Record Item;
        EntryNo: Integer;
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //Items Price Lists NAV -> CVS
        GetGeneralInterfaceSetup;
        GetCashVanSalesInterfaceSetup;
        GeneralLedgerSetup.GET;
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Sales Price Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        CashVanSalesInterfaceSetup.TESTFIELD("Customer Price Group Code");
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := CashVanSalesInterfaceSetup."CVS Sales Price Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Item No." <> '*' then begin
                    Item.GET(InterfaceEntryLine."Item No.");
                    SalesPrice.RESET;
                    SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"Customer Price Group");
                    SalesPrice.SETRANGE("Sales Code", CashVanSalesInterfaceSetup."Customer Price Group Code");
                    SalesPrice.SETRANGE("Item No.", InterfaceEntryLine."Item No.");
                    //SalesPrice.SETFILTER("Unit Price",'<>%1',0);//HEI.02
                    SalesPrice.SETFILTER("Starting Date", '<=%1', TODAY);
                    if SalesPrice.FINDFIRST then begin
                        SalesPrice.TESTFIELD("Sales Code");
                        //SalesPrice.TESTFIELD("Unit Price");//HEI.02
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                        InterfaceEntryLineOut."Sales Code" := SalesPrice."Sales Code";
                        InterfaceEntryLineOut."Item No." := SalesPrice."Item No.";
                        if SalesPrice."Currency Code" <> '' then
                            InterfaceEntryLineOut."Currency Code" := SalesPrice."Currency Code"
                        else
                            InterfaceEntryLineOut."Currency Code" := GeneralLedgerSetup."LCY Code";
                        InterfaceEntryLineOut."Unit Amount" := SalesPrice."Unit Price";
                        InterfaceEntryLineOut."Unit of Measure Code" := SalesPrice."Unit of Measure Code";
                        InterfaceEntryLineOut.INSERT;
                    end;
                end else begin
                    SalesPrice.RESET;
                    SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"Customer Price Group");
                    SalesPrice.SETRANGE("Sales Code", CashVanSalesInterfaceSetup."Customer Price Group Code");
                    //SalesPrice.SETFILTER("Unit Price",'<>%1',0);//HEI.02
                    SalesPrice.SETFILTER("Starting Date", '<=%1', TODAY);
                    if SalesPrice.FINDSET then
                        repeat
                            SalesPrice.TESTFIELD("Sales Code");
                            //SalesPrice.TESTFIELD("Unit Price");//HEI.02
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut."Sales Code" := SalesPrice."Sales Code";
                            InterfaceEntryLineOut."Item No." := SalesPrice."Item No.";
                            if SalesPrice."Currency Code" <> '' then
                                InterfaceEntryLineOut."Currency Code" := SalesPrice."Currency Code"
                            else
                                InterfaceEntryLineOut."Currency Code" := GeneralLedgerSetup."LCY Code";
                            InterfaceEntryLineOut."Unit Amount" := SalesPrice."Unit Price";
                            InterfaceEntryLineOut."Unit of Measure Code" := SalesPrice."Unit of Measure Code";
                            InterfaceEntryLineOut.INSERT;
                        until SalesPrice.NEXT = 0;
                end;

            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessBrandRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
    begin
        //Items Price Lists NAV -> CVS
        GetGeneralInterfaceSetup;
        GetCashVanSalesInterfaceSetup;
        GeneralInterfaceSetup.TESTFIELD("Brand Dim. Code");
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Brand Response Interface");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := CashVanSalesInterfaceSetup."CVS Brand Response Interface";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Shortcut Dimension 1 Code" <> '*' then begin
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
                    DimensionValue.SETRANGE(Code, InterfaceEntryLine."Shortcut Dimension 1 Code");
                    if DimensionValue.FINDFIRST then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                        InterfaceEntryLineOut."Shortcut Dimension 1 Code" := DimensionValue.Code;
                        InterfaceEntryLineOut.Description := DimensionValue.Name;
                        InterfaceEntryLineOut.INSERT;
                    end;
                end;
                DimensionValue.RESET;
                DimensionValue.SETRANGE("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
                if DimensionValue.FINDSET then
                    repeat
                        CLEAR(InterfaceEntryLineOut);
                        EntryNo += 1;
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        InterfaceEntryLineOut."Shortcut Dimension 1 Code" := DimensionValue.Code;
                        InterfaceEntryLineOut.Description := DimensionValue.Name;
                        InterfaceEntryLineOut.INSERT;
                    until DimensionValue.NEXT = 0;
            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessRouteRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        //  Route: Record Route; //BC Upgrade GUNREM01 - DIT Table
        EntryNo: Integer;
    begin
        //Routes NAV -> CVS
        GetGeneralInterfaceSetup;
        GetCashVanSalesInterfaceSetup;
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS Route Response Interface");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := CashVanSalesInterfaceSetup."CVS Route Response Interface";
        InterfaceEntryHeaderOut.INSERT(true);
        //BC Upgrade GUNREM01 - DIT table dependency >>
        // InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        // if InterfaceEntryLine.FINDSET then
        //     repeat
        //         if InterfaceEntryLine."No." <> '*' then begin
        //             Route.RESET;
        //             Route.GET(InterfaceEntryLine."No.");
        //             Route.TESTFIELD("Van Sales Route");
        //             Route.TESTFIELD("Driver Code");
        //             Route.TESTFIELD("Truck Code");
        //             Route.TESTFIELD("Salesperson/Purchaser Code");
        //             Route.TESTFIELD("Location Code");
        //             CLEAR(InterfaceEntryLineOut);
        //             InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
        //             InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
        //             InterfaceEntryLineOut."No." := Route.Code;
        //             InterfaceEntryLineOut."Driver Code" := Route."Driver Code";
        //             InterfaceEntryLineOut."Truck Code" := Route."Truck Code";
        //             InterfaceEntryLineOut."Account No." := Route."Driver Code 2";
        //             InterfaceEntryLineOut."Shortcut Dimension 2 Code" := Route."Journal Batch Name";
        //             InterfaceEntryLineOut."Shortcut Dimension 1 Code" := Route."Journal Template Name";
        //             InterfaceEntryLineOut."SalesPers./Purch. Code" := Route."Salesperson/Purchaser Code";
        //             InterfaceEntryLineOut."Location Code" := Route."Location Code";
        //             InterfaceEntryLineOut.INSERT;

        // end else begin
        //     Route.RESET;
        //     Route.SETRANGE("Van Sales Route", true);
        //     if Route.FINDSET then
        //         repeat
        //             Route.TESTFIELD("Driver Code");
        //             Route.TESTFIELD("Truck Code");
        //             Route.TESTFIELD("Salesperson/Purchaser Code");
        //             Route.TESTFIELD("Location Code");
        //             EntryNo += 1;
        //             CLEAR(InterfaceEntryLineOut);
        //             InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
        //             InterfaceEntryLineOut."Entry No." := EntryNo;
        //             InterfaceEntryLineOut."No." := Route.Code;
        //             InterfaceEntryLineOut."Driver Code" := Route."Driver Code";
        //             InterfaceEntryLineOut."Truck Code" := Route."Truck Code";
        //             InterfaceEntryLineOut."Account No." := Route."Driver Code 2";
        //             InterfaceEntryLineOut."Shortcut Dimension 2 Code" := Route."Journal Batch Name";
        //             InterfaceEntryLineOut."Shortcut Dimension 1 Code" := Route."Journal Template Name";
        //             InterfaceEntryLineOut."SalesPers./Purch. Code" := Route."Salesperson/Purchaser Code";
        //             InterfaceEntryLineOut."Location Code" := Route."Location Code";
        //             InterfaceEntryLineOut.INSERT;
        //         until Route.NEXT = 0;

        //     end;
        // until InterfaceEntryLine.NEXT = 0;
        //BC Upgrade GUNREM01 - DIT table dependency <<
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessWarehouseProductRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        StockkeepingUnit: Record "Stockkeeping Unit";
        Location: Record Location;
        EntryNo: Integer;
        Item: Record Item;
        //  ItemCrossReference: Record "Item Cross Reference";
        ItemCrossReference: Record "Item Reference"; //BC upgrade GUNREM01 replaced Item Cross Reference table
        AvailableQty: Decimal;
    begin
        //Inventory NAV -> CVS
        GetGeneralInterfaceSetup;
        GetCashVanSalesInterfaceSetup;
        InterfaceSetup.GET(CashVanSalesInterfaceSetup."CVS WarehouseProduct Res Inter");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := CashVanSalesInterfaceSetup."CVS WarehouseProduct Res Inter";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Location Code" <> '*' then begin
                    Location.GET(InterfaceEntryLine."Location Code");
                    StockkeepingUnit.RESET;
                    StockkeepingUnit.SETRANGE("Location Code", InterfaceEntryLine."Location Code");
                    if StockkeepingUnit.FINDSET then
                        repeat
                            StockkeepingUnit.CALCFIELDS(Inventory, "Qty. on Sales Order");
                            Item.GET(StockkeepingUnit."Item No.");
                            Item.TESTFIELD("Sales Unit of Measure");
                            EntryNo += 1;
                            CLEAR(InterfaceEntryLineOut);
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut."Item No." := StockkeepingUnit."Item No.";
                            InterfaceEntryLineOut."Location Code" := StockkeepingUnit."Location Code";
                            InterfaceEntryLineOut."Sales Unit of Measure" := Item."Sales Unit of Measure";
                            //InterfaceEntryLineOut.Quantity := GetQtyInSalesUnitOfMeasure(StockkeepingUnit.Inventory - StockkeepingUnit."Qty. on Sales Order",Item."No.");
                            InterfaceEntryLineOut.Quantity := GetQtyInSalesUnitOfMeasure(StockkeepingUnit.Inventory - GetQtyOnReleasedSalesOrders(StockkeepingUnit), Item."No.");
                            InterfaceEntryLineOut.INSERT;
                        until StockkeepingUnit.NEXT = 0;
                end else begin
                    Location.RESET;
                    Location.SETFILTER("Van Sales Route FND", '<>%1', '');
                    if Location.FINDSET then
                        repeat
                            StockkeepingUnit.RESET;
                            StockkeepingUnit.SETRANGE("Location Code", Location.Code);
                            if StockkeepingUnit.FINDSET then
                                repeat
                                    StockkeepingUnit.CALCFIELDS(Inventory, "Qty. on Sales Order");
                                    Item.GET(StockkeepingUnit."Item No.");
                                    //IF (Item.Blocked = FALSE) AND (STRPOS(Item."Item Category Code",CashVanSalesInterfaceSetup."Item Category Filter") <> 0) THEN BEGIN//HEI.02
                                    if (Item.Blocked = false) and (STRPOS(CashVanSalesInterfaceSetup."Item Category Filter", Item."Item Category Code") <> 0) then begin
                                        /*//HEI.04
                                        ItemCrossReference.RESET;
                                        ItemCrossReference.SETRANGE("Item No.",Item."No.");
                                        ItemCrossReference.SETRANGE("Cross-Reference Type",ItemCrossReference."Cross-Reference Type"::"Bar Code");
                                        IF ItemCrossReference.FINDFIRST THEN BEGIN
                                        */
                                        CLEAR(AvailableQty);
                                        AvailableQty := GetQtyInSalesUnitOfMeasure(StockkeepingUnit.Inventory - GetQtyOnReleasedSalesOrders(StockkeepingUnit), Item."No.");
                                        if AvailableQty <> 0 then begin
                                            Item.TESTFIELD("Sales Unit of Measure");
                                            EntryNo += 1;
                                            CLEAR(InterfaceEntryLineOut);
                                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                            InterfaceEntryLineOut."Entry No." := EntryNo;
                                            InterfaceEntryLineOut."Item No." := StockkeepingUnit."Item No.";
                                            InterfaceEntryLineOut."Location Code" := StockkeepingUnit."Location Code";
                                            InterfaceEntryLineOut."Sales Unit of Measure" := Item."Sales Unit of Measure";
                                            InterfaceEntryLineOut.Quantity := AvailableQty;
                                            InterfaceEntryLineOut.INSERT;
                                        end;
                                        //END;//HEI.04
                                    end;
                                until StockkeepingUnit.NEXT = 0;
                        until Location.NEXT = 0;
                end;
            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);

    end;

    procedure CreateSalesOrders(var InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        // Route: Record Route; //BC Upgrade GUNREM01 - DIT Table
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesOrderExist: Boolean;
        ReleaseSalesDocument: Codeunit "Release Sales Document";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        //Sales Order Creation
        GetCashVanSalesInterfaceSetup;
        GeneralLedgerSetup.GET;
        CLEAR(SalesOrderExist);

        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE("External Document No.", InterfaceEntryHeader."Source No.");
        if not SalesInvoiceHeader.FINDFIRST then begin
            SalesHeader.RESET;
            SalesHeader.SETRANGE("External Document No.", InterfaceEntryHeader."Source No.");
            if not SalesHeader.FINDFIRST then begin

                SalesHeader.INIT;
                SalesHeader.VALIDATE("Document Type", CashVanSalesInterfaceSetup."Document Type");
                //SalesHeader.VALIDATE("No.",InterfaceEntryHeader."Source No.");
                SalesHeader.VALIDATE("No.", '');
                SalesHeader.INSERT(true);
                SalesOrderExist := true;

                /*
                IF (SalesOrderExist = FALSE) AND (SalesHeader.Status = SalesHeader.Status::Released) THEN
                  ReleaseSalesDocument.Reopen(SalesHeader);
                */

                SalesHeader.SetHideValidationDialog(true);
                SalesHeader.VALIDATE("Posting No.", InterfaceEntryHeader."Source No.");
                if InterfaceEntryHeader."Currency Code" <> GeneralLedgerSetup."LCY Code" then
                    SalesHeader.VALIDATE("Currency Code", InterfaceEntryHeader."Currency Code");

                //SalesHeader.VALIDATE("Bill-to Customer No.",InterfaceEntryHeader."Bill-to Customer No.");
                SalesHeader.VALIDATE("Sell-to Customer No.", InterfaceEntryHeader."Sell-to Customer No.");
                SalesHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                if InterfaceEntryHeader."Currency Code" <> GeneralLedgerSetup."LCY Code" then
                    SalesHeader.VALIDATE("Currency Code", InterfaceEntryHeader."Currency Code");

                //SalesHeader.VALIDATE("Currency Factor",InterfaceEntryHeader."Currency Factor");
                SalesHeader.VALIDATE("Document Date", InterfaceEntryHeader."Document Date");
                SalesHeader.VALIDATE("Due Date", InterfaceEntryHeader."Expected Delivery Date");
                //BC Upgrade GUNREM01 - DIT table dependency >>
                // SalesHeader.VALIDATE(Route, InterfaceEntryHeader."External Contract No.");
                // Route.GET(InterfaceEntryHeader."External Contract No.");
                // Route.TESTFIELD("Van Sales Route");
                // Route.TESTFIELD("Salesperson/Purchaser Code");
                // Route.TESTFIELD("Driver Code");
                // Route.TESTFIELD("Truck Code");
                // Route.TESTFIELD("Location Code");
                // SalesHeader.VALIDATE("Location Code", Route."Location Code");
                // SalesHeader.VALIDATE("Salesperson Code", Route."Salesperson/Purchaser Code");
                // SalesHeader.VALIDATE("Driver Code", Route."Driver Code");
                // SalesHeader.VALIDATE("Truck Code", Route."Truck Code");
                // SalesHeader.VALIDATE("Shipment status", SalesHeader."Shipment status"::Invoice);
                //BC Upgrade GUNREM01 - DIT table dependency <<
                SalesHeader.VALIDATE("Doc. Amount Incl. VAT FND", InterfaceEntryHeader."Amount Including VAT");
                SalesHeader.VALIDATE("Doc. Amount VAT FND", InterfaceEntryHeader."VAT Amount");
                SalesHeader.VALIDATE("External Document No.", InterfaceEntryHeader."Source No.");
                SalesHeader.Ship := true;
                SalesHeader.Invoice := true;
                SalesHeader.MODIFY(true);

                InterfaceEntryLine.RESET;
                InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                if InterfaceEntryLine.FINDSET then
                    repeat
                        if not SalesLine.GET(SalesHeader."Document Type", SalesHeader."No.", InterfaceEntryLine."Source Line No.") then begin
                            SalesLine.INIT;
                            SalesLine.VALIDATE("Document Type", CashVanSalesInterfaceSetup."Document Type");
                            SalesLine.VALIDATE("Document No.", SalesHeader."No.");
                            SalesLine.VALIDATE("Line No.", InterfaceEntryLine."Source Line No.");
                            SalesLine.INSERT(true);
                        end;

                        SalesLine.VALIDATE("Sell-to Customer No.", InterfaceEntryLine."Sell-to Customer No.");
                        //SalesLine.VALIDATE("Bill-to Customer No.",InterfaceEntryLine."Bill-to Customer No.");
                        SalesLine.VALIDATE(Type, CashVanSalesInterfaceSetup.Type);
                        SalesLine.VALIDATE("No.", InterfaceEntryLine."No.");
                        SalesLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                        //  SalesLine.VALIDATE("Location Code", Route."Location Code"); //BC Upgrade GUNREM01 - DIT Table

                        SalesLine.VALIDATE("Line Discount %", InterfaceEntryLine."VAT %");
                        SalesLine.VALIDATE("Line Discount Amount", InterfaceEntryLine."Exchange Rate Amount");
                        /*
                        SalesLine.VALIDATE(Amount,InterfaceEntryLine."Unit Amount");
                        SalesLine.VALIDATE("Amount Including VAT",InterfaceEntryLine."Line Amount");
                        IF InterfaceEntryLine."Currency Code" <> GeneralLedgerSetup."LCY Code" THEN
                          SalesLine.VALIDATE("Currency Code",InterfaceEntryLine."Currency Code");
                        */

                        SalesLine.VALIDATE("Unit of Measure Code", InterfaceEntryLine."Unit of Measure Code");
                        //BC upgrade GUNREM01 - DIT fields >>
                        // SalesLine.VALIDATE("Free Item", InterfaceEntryLine."Rotating Item");
                        // //HEI.03>>
                        // if SalesLine."Free Item" then begin
                        //     SalesLine.VALIDATE("Dimension Set ID", GetDimSetId(SalesLine));
                        //     SalesLine.VALIDATE("Free Reason Code", 'A5');
                        // end;
                        //HEI.03<<
                        //BC Upgrade GUNREM01 - DIT fields <<
                        SalesLine.MODIFY(true);
                    until InterfaceEntryLine.NEXT = 0;
                CODEUNIT.RUN(CODEUNIT::"Release Sales Document", SalesHeader);
                InsertNewSOLine(SalesHeader);//GAP07
                if SalesHeader.Status = SalesHeader.Status::Released then
                    ReleaseSalesDocument.Reopen(SalesHeader);//HEI.02
                FefoTrackingOrderLines(SalesHeader);
                AssignQtyForitemCharge(SalesHeader);
            end;
            CODEUNIT.RUN(CODEUNIT::"Release Sales Document", SalesHeader);
            CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);
        end;//order already exist

    end;

    procedure CreateCashReceipt(var InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        GenJournalLine: Record "Gen. Journal Line";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        DimensionManagement: Codeunit DimensionManagement;
        //   Route: Record Route; //BC Upgrade GUNREM01 - DIT Table
        LineNo: Integer;
        GenJournalLine2: Record "Gen. Journal Line";
        //  RoutePlanningWorksheet: Record "Route Planning Worksheet"; //BC Upgrade GUNREM01 - DIT Table
        GeneralLedgerSetup: Record "General Ledger Setup";
        Customer: Record Customer;
    begin
        GetCashVanSalesInterfaceSetup;
        GeneralLedgerSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("CVS Cash Receipt Jnl. Template");
        CashVanSalesInterfaceSetup.TESTFIELD("CVS Cash Receipt Jnl. Batch");
        //CashVanSalesInterfaceSetup.TESTFIELD("Account Type");
        //CashVanSalesInterfaceSetup.TESTFIELD("Bal. Account Type");
        CashVanSalesInterfaceSetup.TESTFIELD("Bal. Account No.");
        CashVanSalesInterfaceSetup.TESTFIELD("Movement Type Dimension Code");
        CashVanSalesInterfaceSetup.TESTFIELD("Movement Type Dimension Value");

        InterfaceEntryLine.RESET;
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Document No.", InterfaceEntryLine."No.");//HEI.02
                if not GenJournalLine.FINDFIRST then begin
                    CLEAR(LineNo);
                    //BC Upgrade GUNREM01 - DIT table dependency >>
                    // Route.GET(InterfaceEntryLine."External Contract No.");
                    // Route.TESTFIELD("Driver Code");
                    // Route.TESTFIELD("Truck Code");
                    //BC Upgrade GUNREM01 - DIT table dependency <<
                    GenJournalLine.INIT;
                    // if Route."Journal Batch Name" <> '' then
                    //     GenJournalLine.VALIDATE("Journal Template Name", Route."Journal Template Name")
                    // else
                    GenJournalLine.VALIDATE("Journal Template Name", CashVanSalesInterfaceSetup."CVS Cash Receipt Jnl. Template");
                    // if Route."Journal Batch Name" <> '' then
                    //     GenJournalLine.VALIDATE("Journal Batch Name", Route."Journal Batch Name")
                    // else
                    GenJournalLine.VALIDATE("Journal Batch Name", CashVanSalesInterfaceSetup."CVS Cash Receipt Jnl. Batch");
                    GenJournalLine2.RESET;
                    GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                    GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                    if GenJournalLine2.FINDLAST then
                        LineNo := GenJournalLine2."Line No." + 10000
                    else
                        LineNo := 10000;
                    GenJournalLine.VALIDATE("Line No.", LineNo);
                    GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
                    GenJournalLine.VALIDATE("Account Type", CashVanSalesInterfaceSetup."Account Type");
                    Customer.GET(InterfaceEntryLine."Sell-to Customer No.");
                    GenJournalLine.VALIDATE("Account No.", Customer."Bill-to Customer No.");
                    GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Document Date");
                    GenJournalLine.VALIDATE("Document No.", InterfaceEntryLine."No.");
                    GenJournalLine.VALIDATE(Description, InterfaceEntryLine.Description);
                    if InterfaceEntryLine."Currency Code" <> GeneralLedgerSetup."LCY Code" then
                        GenJournalLine.VALIDATE("Currency Code", InterfaceEntryLine."Currency Code");
                    GenJournalLine.VALIDATE("Currency Factor", InterfaceEntryLine."Exchange Rate Amount");
                    GenJournalLine.VALIDATE(Amount, -InterfaceEntryLine."Unit Amount");
                    //GenJournalLine.VALIDATE("Amount (LCY)",-InterfaceEntryLine."Line Amount");
                    GenJournalLine.VALIDATE("Bal. Account Type", CashVanSalesInterfaceSetup."Bal. Account Type");

                    GenJournalLine.VALIDATE("Bal. Account No.", CashVanSalesInterfaceSetup."Bal. Account No.");
                    GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Order No.");
                    //BC Upgrade GUNREM01 - DIT table dependency >>
                    // GenJournalLine.VALIDATE("Truck Code", Route."Truck Code");
                    // GenJournalLine.VALIDATE("Driver Code", Route."Driver Code");
                    // GenJournalLine.VALIDATE("Salespers./Purch. Code", Route."Salesperson/Purchaser Code");
                    //BC Upgrade GUNREM01 - DIT table dependency <<
                    GenJournalLine.INSERT(true);
                    //BC Upgrade GUNREM01 - DIT table dependency >>
                    // RoutePlanningWorksheet.RESET;
                    // RoutePlanningWorksheet.SETRANGE(Route, Route.Code);
                    // RoutePlanningWorksheet.SETRANGE("Shipment/Expected Receipt Date", InterfaceEntryLine."Document Date");
                    // if RoutePlanningWorksheet.FINDFIRST then
                    //     GenJournalLine.VALIDATE("Route Planning No.", RoutePlanningWorksheet."No.");
                    // TempDimensionSetEntry."Dimension Code" := CashVanSalesInterfaceSetup."Movement Type Dimension Code";
                    // TempDimensionSetEntry."Dimension Value Code" := CashVanSalesInterfaceSetup."Movement Type Dimension Value";
                    //BC Upgrade GUNREM01 - DIT table dependency <<
                    if TempDimensionSetEntry.INSERT(true) then;
                    GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                    GenJournalLine.MODIFY;
                end;
            until InterfaceEntryLine.NEXT = 0;
    end;

    procedure CreateTransferOrder(var InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        InterfaceEntryLine: Record "Interface Entry Line INT";
    begin
        //Transfer Orders Creation
        CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("Transfer-from Code");
        CashVanSalesInterfaceSetup.TESTFIELD("In-Transit Code");
        //CashVanSalesInterfaceSetup.TESTFIELD(Status);

        TransferHeader.RESET;
        TransferHeader.SETRANGE("External Document No.", InterfaceEntryHeader."Source No.");//HEI.02
        if not TransferHeader.FINDFIRST then begin
            TransferHeader.INIT;
            //TransferHeader.VALIDATE("No.",InterfaceEntryHeader."Source No.");
            TransferHeader.VALIDATE("No.", '');
            TransferHeader.INSERT(true);
            TransferHeader.VALIDATE("Transfer-from Code", CashVanSalesInterfaceSetup."Transfer-from Code");

            TransferHeader.VALIDATE("Transfer-to Code", InterfaceEntryHeader."Transfer-to Code");
            TransferHeader.VALIDATE("In-Transit Code", CashVanSalesInterfaceSetup."In-Transit Code");
            TransferHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
            TransferHeader.VALIDATE(Status, CashVanSalesInterfaceSetup.Status);
            //BC Upgrade GUNREM01 - DIT fields >>
            // TransferHeader.VALIDATE("Truck Code", InterfaceEntryHeader."Truck Code");
            // TransferHeader.VALIDATE("Driver Code", InterfaceEntryHeader."Driver Code");
            //BC Upgrade GUNREM01 - DIT fields <<
            TransferHeader.VALIDATE("External Document No.", InterfaceEntryHeader."Source No.");
            TransferHeader.MODIFY(true);

            InterfaceEntryLine.RESET;
            InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
            if InterfaceEntryLine.FINDSET then
                repeat
                    TransferLine.INIT;
                    TransferLine.VALIDATE("Document No.", TransferHeader."No.");
                    TransferLine.VALIDATE("Line No.", InterfaceEntryLine."Source Line No.");
                    TransferLine.INSERT(true);

                    TransferLine.VALIDATE("Item No.", InterfaceEntryLine."Item No.");
                    TransferLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    TransferLine.VALIDATE("Unit of Measure Code", InterfaceEntryLine."Unit of Measure Code");
                    //BC Upgrade GUNREM01 - DIT fields >>
                    // TransferLine.VALIDATE("Truck Code", InterfaceEntryLine."Truck Code");
                    // TransferLine.VALIDATE("Driver Code", InterfaceEntryLine."Driver Code");
                    //BC Upgrade GUNREM01 - DIT fields <<
                    TransferLine.MODIFY(true)
                until InterfaceEntryLine.NEXT = 0;
        end;
    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        if not GeneralInterfaceSetupRead then
            GeneralInterfaceSetup.GET;
        GeneralInterfaceSetupRead := true;
    end;

    local procedure GetCashVanSalesInterfaceSetup();
    begin
        if not CashVanSalesInterfaceSetupRead then
            CashVanSalesInterfaceSetup.GET;
        CashVanSalesInterfaceSetupRead := true;
    end;

    local procedure GetItemCrossReference(Item: Record Item): Code[20];
    var
        //  ItemCrossReference: Record "Item Cross Reference";
        ItemCrossReference: Record "Item Reference"; //BC upgrade GUNREM01 replaced Item Cross Reference table
    begin
        ItemCrossReference.RESET;
        ItemCrossReference.SETRANGE("Item No.", Item."No.");
        //   ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::"Bar Code");
        ItemCrossReference.SETRANGE("Reference Type", ItemCrossReference."Reference Type"::"Bar Code"); //BC upgrade GUNREM01 replaced cross-reference type field

        ItemCrossReference.SETRANGE("Unit of Measure", Item."Base Unit of Measure");
        if ItemCrossReference.FINDFIRST then
            //  exit(ItemCrossReference."Cross-Reference No.");
            exit(ItemCrossReference."Reference No."); //BC upgrade GUNREM01 replaced cross-reference no. field
    end;
    //BC upgrade GUNREM01 - DIT function  >>
    // local procedure GetDrinkItDiscPercentage(CustNo: Code[20]): Decimal;
    // var
    //     // DrinkDiscountRelation: Record "Drink Discount Relation"; 
    //     // SalesDiscountItemCharge: Record "Sales Discount Item Charge";
    //     DiscPercentage: Decimal;
    //     Error001: Label 'There is no drink discount relation for customer %1';
    //     Error002: Label 'There is no sales discount item charge for customer %1';
    // begin
    //     DrinkDiscountRelation.RESET;
    //     DrinkDiscountRelation.SETRANGE("Source Type", DrinkDiscountRelation."Source Type"::Customer);
    //     DrinkDiscountRelation.SETRANGE("Source No.", CustNo);
    //     if DrinkDiscountRelation.FINDFIRST then begin
    //         SalesDiscountItemCharge.RESET;
    //         SalesDiscountItemCharge.SETRANGE("Sales Type", SalesDiscountItemCharge."Sales Type"::"Customer Discount Group");
    //         SalesDiscountItemCharge.SETRANGE("Sales Code", DrinkDiscountRelation.Code);
    //         if SalesDiscountItemCharge.FINDFIRST then
    //             exit(SalesDiscountItemCharge.Percentage)
    //     end;
    //     /*
    //       ELSE ERROR(Error002,CustNo);
    //     END ELSE
    //       ERROR(Error001,CustNo)
    //     */

    // end;
    //BC upgrade GUNREM01 - DIT function removed <<

    local procedure GetQtyInSalesUnitOfMeasure(QtyInBaseUOM: Decimal; ItemNo: Code[20]): Decimal;
    var
        ItemUnitofMeasure: Record "Item Unit of Measure";
        Item: Record Item;
    begin
        Item.GET(ItemNo);
        if Item."Sales Unit of Measure" = Item."Base Unit of Measure" then
            exit(QtyInBaseUOM)
        else begin
            ItemUnitofMeasure.GET(ItemNo, Item."Sales Unit of Measure");
            exit(QtyInBaseUOM / ItemUnitofMeasure."Qty. per Unit of Measure");
        end;
    end;

    local procedure InsertNewSOLine(SalesHeader: Record "Sales Header");
    var
        SalesLine: Record "Sales Line";
        Error001: Label 'The Difference between the Doc. Amount Incl VAT %1 and Total Amount incl VAT %2 is bigger than the allowed limit %3!';
        MaxOrderDiffAmtLCY: Decimal;
        GeneralLedgerSetup: Record "General Ledger Setup";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        ReleaseSalesDocument: Codeunit "Release Sales Document";
        DiffUnitPrice: Decimal;
    begin
        CLEAR(DiffUnitPrice);
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::"G/L Account");
        SalesLine.DELETEALL(true);

        GetCashVanSalesInterfaceSetup;
        GeneralLedgerSetup.GET;
        CashVanSalesInterfaceSetup.TESTFIELD("SO G/L Account Difference");
        CashVanSalesInterfaceSetup.TESTFIELD("Max Order Difference Amt.");
        if SalesHeader."Currency Code" <> '' then begin
            CurrencyExchangeRate.RESET;
            CurrencyExchangeRate.SETRANGE("Currency Code", SalesHeader."Currency Code");
            CurrencyExchangeRate.SETFILTER("Starting Date", '<=%1', TODAY);
            if CurrencyExchangeRate.FINDLAST then
                MaxOrderDiffAmtLCY := CashVanSalesInterfaceSetup."Max Order Difference Amt." / CurrencyExchangeRate."Relational Exch. Rate Amount";
        end else
            MaxOrderDiffAmtLCY := CashVanSalesInterfaceSetup."Max Order Difference Amt.";

        if (SalesHeader."Doc. Amount Incl. VAT FND" <> 0) and (SalesHeader."Doc. Amount VAT FND" <> 0) then begin
            SalesHeader.CALCFIELDS("Amount Including VAT", Amount);
            if ABS((SalesHeader."Doc. Amount Incl. VAT FND" - SalesHeader."Amount Including VAT")) > 0 then
                if ABS((SalesHeader."Doc. Amount Incl. VAT FND" - SalesHeader."Amount Including VAT")) <= MaxOrderDiffAmtLCY then begin
                    DiffUnitPrice := GetAditionalAmountExclAmt(SalesHeader."Doc. Amount Incl. VAT FND" - SalesHeader."Amount Including VAT", SalesHeader);
                    ReleaseSalesDocument.Reopen(SalesHeader);//HEI.02
                    SalesLine.INIT;
                    SalesLine.VALIDATE("Document Type", SalesHeader."Document Type");
                    SalesLine.VALIDATE("Document No.", SalesHeader."No.");
                    SalesLine.VALIDATE("Line No.", 1);
                    SalesLine.INSERT(true);
                    SalesLine.VALIDATE(Type, SalesLine.Type::"G/L Account");
                    SalesLine.VALIDATE("No.", CashVanSalesInterfaceSetup."SO G/L Account Difference");
                    SalesLine.VALIDATE(Quantity, 1);
                    SalesLine.VALIDATE("Unit Price", DiffUnitPrice);

                    SalesLine.MODIFY(true);
                end else
                    ERROR(Error001, SalesHeader."Doc. Amount Incl. VAT FND", SalesHeader."Amount Including VAT", MaxOrderDiffAmtLCY);
        end;
    end;

    local procedure FefoTrackingOrderLines(SalesHeader: Record "Sales Header");
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        SalesLineReserve: Codeunit "Sales Line-Reserve";
        HeinekenIntBCUpgrade: Codeunit "Heineken Interface BC Upgrade";
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETFILTER("No.", '<>%1', '');
        SalesLine.SETFILTER("Quantity (Base)", '>%1', 0);
        SalesLine.SETRANGE("Job Contract Entry No.", 0);
        SalesLine2.COPY(SalesLine);
        if SalesLine.FINDSET then
            repeat
                SalesLine2 := SalesLine;
                //   SalesLineReserve.ShowConfirmationMessage(true);
                HeinekenIntBCUpgrade.ShowConfirmationMessage(true); //BC upgrade GUNREM01
                                                                    //SalesLineReserve.FEFOTracking(SalesLine2, '', 0); //BC Upgrade GUNREM01 -FEFOTracking DIT fucntion 
            until SalesLine.NEXT = 0;
    end;

    procedure GetQtyOnReleasedSalesOrders(StockkeepingUnit: Record "Stockkeeping Unit"): Decimal;
    var
        SalesLine: Record "Sales Line";
        QtyOnReleasedSO: Decimal;
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        // SalesLine.SETRANGE(Status, SalesLine.Status::Released); //BC Upgrade GUNREM01 DIT Field
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETRANGE("No.", StockkeepingUnit."Item No.");
        SalesLine.SETRANGE("Location Code", StockkeepingUnit."Location Code");
        SalesLine.CALCSUMS("Outstanding Qty. (Base)");
        exit(SalesLine."Outstanding Qty. (Base)")
    end;

    local procedure AssignQtyForitemCharge(SalesHeader: Record "Sales Header");
    var
        ItemChargeAssignmentSales: Record "Item Charge Assignment (Sales)";
        SalesLine: Record "Sales Line";
    begin
        //COMMIT;
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::"Charge (Item)");
        if SalesLine.FINDSET then
            repeat
                /*
                ItemChargeAssignmentSales.RESET;
                ItemChargeAssignmentSales.SETRANGE("Document Type",SalesLine."Document Type");
                ItemChargeAssignmentSales.SETRANGE("Document No.",SalesLine."Document No.");
                ItemChargeAssignmentSales.SETRANGE("Document Line No.",SalesLine."Line No.");
                ItemChargeAssignmentSales.SETRANGE("Item Charge No.",SalesLine."No.");
                IF ItemChargeAssignmentSales.FINDFIRST THEN BEGIN
                  ItemChargeAssignmentSales.VALIDATE("Qty. to Assign",SalesLine.Quantity);
                  ItemChargeAssignmentSales.MODIFY(TRUE);
                END;
                */
                //SetCurrFieldNo(SalesLine,SalesLine,SalesLine.FIELDNO(Quantity));
                //HEI.02>>
                //SalesLine.SetCurrFieldNo(SalesLine.FIELDNO(Quantity));
                //SalesLine.VALIDATE(Quantity,SalesLine.Quantity);
                SalesLine.SetCurrFieldNo(SalesLine.FIELDNO("Location Code"));
                SalesLine.VALIDATE("Location Code", SalesLine."Location Code");
                //HEI.02<<
                SalesLine.MODIFY;
            until SalesLine.NEXT = 0;

    end;

    local procedure GetAditionalAmountExclAmt(AmountInclVAT: Decimal; SalesHeader: Record "Sales Header"): Decimal;
    var
        GLAccount: Record "G/L Account";
        VATPostingSetup: Record "VAT Posting Setup";
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
    begin
        CashVanSalesInterfaceSetup.GET;
        GLAccount.GET(CashVanSalesInterfaceSetup."SO G/L Account Difference");
        VATPostingSetup.GET(SalesHeader."VAT Bus. Posting Group", GLAccount."VAT Prod. Posting Group");
        exit(AmountInclVAT / (1 + (VATPostingSetup."VAT %" / 100)));
    end;

    local procedure GetDimSetId(SalesLine: Record "Sales Line"): Integer;
    var
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        DimensionManagement: Codeunit DimensionManagement;
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //HEI.03>>
        GeneralLedgerSetup.GET;
        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, SalesLine."Dimension Set ID");

        TempDimensionSetEntry.RESET;
        TempDimensionSetEntry."Dimension Code" := 'INV_LEV';
        TempDimensionSetEntry."Dimension Value Code" := 'A5';
        TempDimensionSetEntry.INSERT;

        exit(DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
        //HEI.03<<
    end;

    local procedure CheckSKUExist(Item: Record Item): Boolean;
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        Location: Record Location;
        SkuExist: Boolean;
    begin
        //HEI.04>>
        CLEAR(SkuExist);
        StockkeepingUnit.RESET;
        StockkeepingUnit.SETRANGE("Item No.", Item."No.");
        if StockkeepingUnit.FINDSET then
            repeat
                if Location.GET(StockkeepingUnit."Location Code") and (Location."Van Sales Route FND" <> '') then
                    SkuExist := true;
            until (StockkeepingUnit.NEXT = 0) or SkuExist;

        exit(SkuExist);
        //HEI.04<<
    end;
}

