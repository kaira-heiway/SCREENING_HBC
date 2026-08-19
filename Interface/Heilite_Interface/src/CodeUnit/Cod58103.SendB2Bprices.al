codeunit 58103 "Send B2B Prices"
{
    //BC Upgrade GUNREM01 Old ID-50158
    // version HEI.13

    // HEI.01 FDD-HB1281 - CHG2056937 IBM NASTAA02 12.04.2021 # B2B Pricing Interface
    //   # New Codeunit created for B2B Pricing Interface
    // HEI.02 INC3510045 - CHG2112803 IBM NASTAA02 02.06.2021 # HeiLite to B2B pricing the file generated is very big and can't be sent via Boomi or Solace
    //   # Code added to split the XML sent
    //   # Removed function 'CustomerIsValid'
    // HEI.03 INC3625520 - CHG2120043 IBM NASTAA02 27.07.2021 # Date format in B2B pricing interface is not correct
    //   # Code added to enforce Date Format as MM/DD/YY
    // HEI.04 FDD-HB1281 - CHG2056937 IBM NASTAA02 04.10.2021 # B2B Pricing Interface
    //   # Code added to Skip Multi Currency Prices
    // HEI.05 HB2427 - CHG2121928 IBM NASTAA02 20.11.2021 # B2B Invoice API
    //   # New Functions created for Invoice / Credit Memo Interfaces
    // HEI.06 HB2024 - CHG2137488 IBM NASTAA02 06.01.2022 # B2B Credit Limit
    //   # New Functions created for Credit Limit Interface
    // HEI.07 INC4000501 - CHG2150250 IBM NASTAA02 10.03.2022 # There is an error when trying to bill orders registered on Heishop
    //   # XMLDoc saved to a BigText variable before passing it to the OutStream
    // HEI.08 INC4083000 - CHG2156647 IBM NASTAA02 03.05.2022 # NAS Service consuming high memory
    //   # Clear variables after Webservice call
    // HEI.09 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables
    // HEI.10 CHG2174122 HB3137 BHANDS01 13.02.2023 # Control for which UOM prices sent to B2B
    //   # Condition added to restrict UOM not included in B2B
    // HEI.11 CHG2199256 IBM COSTES04 03.04.2023 B2B-Pricing Interface sending zero pricing
    //   # Skip initializing autoincrement field
    // HEI.12 CHG2199256 IBM COSTES04 19.04.2023 B2B-Pricing Interface sending zero pricing
    //   # Enable posibility to send prices for a specific date when running manually
    // HEI.13 CHG2210605 IBM MARTIR52 28.06.2023 B2B-Prices formula change
    //   # Send NetPrice(Order) instead of NetPrice(Item) to cover the scenarios required by StLucia and Bahamas Opcos on the interface

    //BC Upgrade GUNREM01
    //# Commented Drink it code
    //# Replaced Dotnet variables with xml variables.
    //# Code modified using xml variables

    // BC Upgrade SHUKLP03 >> Replaced Old DIT fields and tables. Converted code for Saas.


    trigger OnRun();
    begin
        if B2BInterfaceSetup.GET() and B2BInterfaceSetup."Enable B2B Interfaces" then
            if B2BInterfaceSetup."Run Sales Gross Net Price Rep" then
                RunSalesGrossNetPriceReport();

        CreateAndSendResponseXML();
    end;

    var
        B2BInterfaceSetup: Record "B2B Interface Setup INT";
        RunDate: Date;
        CurrencyCode: Code[10];
        LCYCode: Code[10];
        B2BItemUnitsofMeasure: Record "B2B Item Units of Measure FND";

    //BC Upgrade GUNREM01 -Dependency with DIT Report >>

    local procedure RunSalesGrossNetPriceReport();
    var
        SalesGrossnetPrice: Report InsertPriceInfo101FDW; //BC Upgrade GUNREM01 -DIT Report
        Customer: Record Customer;
        CustomersIncludeExclude: Record "B2B Cust Inc/Exc FND";
        CustomerNoFilter: Text;
        Item: Record Item;
    begin
        //     Run the report for every Bill -to Customer Included >>
        // BC Upgrade GUNREM01 - Commented >>
        CustomersIncludeExclude.SETRANGE(Included, true);
        if CustomersIncludeExclude.FINDSET() then
            repeat
                Customer.RESET();
                Customer.SETRANGE("No.", CustomersIncludeExclude.Code);

                if Customer.FINDFIRST() then begin
                    SalesGrossnetPrice.InitVariables(); // SHUKLP03 <<
                    RunDate := SalesGrossnetPrice.GetAsPerDate(); // SHUKLP03 << 
                    SalesGrossnetPrice.SETTABLEVIEW(Customer);
                    SalesGrossnetPrice.RUN();
                end;
            until CustomersIncludeExclude.NEXT() = 0

        /* HEI.02>>
        // Run the Report for all Customers
        // ELSE BEGIN
        //     SalesGrossnetPrice.InitVariables;
        //     RunDate := SalesGrossnetPrice.GetAsPerDate;

        //     IF B2BInterfaceSetup.GET THEN
        //         IF B2BInterfaceSetup."Enable B2B Interfaces" AND (B2BInterfaceSetup."Customer Acc. Group Included" <> '') THEN
        //             Customer.SETFILTER("Account Group ", B2BInterfaceSetup."Customer Acc. Group Included");

        //     IF Customer.FINDFIRST THEN BEGIN
        //         SalesGrossnetPrice.SETTABLEVIEW(Customer);
        //         SalesGrossnetPrice.RUN;
        //     END;
        // END;

        // HEI.02<< */
    end;
    // BC Upgrade GUNREM01 -Dependency with DIT Report <<
    procedure CreateAndSendResponseXML();
    var
        InterfaceSetup: Record "Interface Setup INT";
        IntegrationFrameworkLog: Record "Integration Framework Log INT";
        IntegrationFrameworkLog2: Record "Integration Framework Log INT";
        B2BPrices: Query "B2B Prices";
        SalesNetPriceBuffer: Record PriceInfo101FDW temporary; //BC Upgrade GUNREM01 -DIT table
                                                               // XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
                                                               // XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
                                                               // XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
                                                               // ;
        XMLDoc: XmlDocument;
        XMLCurrNode: XmlNode;
        XMLCurrNode2: XmlNode;
        OutputStream: OutStream;
        SalesNetPrice: Record PriceInfo101FDW; //BC Upgrade SHUKLP03 -DIT table
        NoOfCustomers: Integer;
        NoOfCustomersInserted: Integer;
        CustomersIncludeExclude: Record "B2B Cust Inc/Exc FND";
        B2BPrices2: Query "B2B Prices";
        Customer: Record Customer;
        GeneralLedgerSetup: Record "General Ledger Setup";
        PricesHaveSameCurrency: Boolean;
        TempBigText: BigText;
    begin
        if not B2BInterfaceSetup.GET() then
            exit;

        if not B2BInterfaceSetup."Enable B2B Interfaces" then
            exit;

        if not InterfaceSetup.GET(B2BInterfaceSetup."B2B Pricing Interface Code") then
            exit;

        if not InterfaceSetup.Enabled then
            exit;

        NoOfCustomers := 0;
        NoOfCustomersInserted := 0; //HEI.02

        //BC Upgrade SHUKLP03 -Dependecny with DIT fields >>
        if RunDate <> 0D then
            B2BPrices.SETFILTER(As_Per_date, '%1', RunDate)
        else
            B2BPrices.SETFILTER(As_Per_date, '%1', WORKDATE());
        B2BPrices.SETFILTER(Customer_No, '<>%1', '');
        B2BPrices.SETFILTER(Unit_Price, '<>%1', 0);
        B2BPrices.OPEN();
        //BC Upgrade SHUKLP03 -Dependecny with DIT fields <<

        while B2BPrices.READ() do
            //HEI.02>>
            if CustomersIncludeExclude.GET(B2BPrices.Customer_No) and CustomersIncludeExclude.Included then begin
                //HEI.02<<
                if CheckB2BUOM(B2BPrices.Item_No, B2BPrices.Unit_of_Measure_Code) then begin //HEI.10
                    NoOfCustomers += 1;
                    if NoOfCustomers = 1 then begin
                        IntegrationFrameworkLog.INIT();
                        IntegrationFrameworkLog."Interface Code" := B2BInterfaceSetup."B2B Pricing Interface Code";
                        IntegrationFrameworkLog."Request Sync. Date/Time" := CURRENTDATETIME;
                        IntegrationFrameworkLog."Call Type" := InterfaceSetup."Call Type";
                        IntegrationFrameworkLog.INSERT(true);

                        //HEI.05>>
                        //CreateResponseXMLMsg(XMLDoc,XMLCurrNode);
                        CreateResponseXMLMsg(XMLDoc, XMLCurrNode, 'PriceList');
                        //HEI.05<<
                    end;

                    SalesNetPriceBuffer.SETRANGE("Source Type", SalesNetPriceBuffer."Source Type"::Customer); // SHUKLP03
                    SalesNetPriceBuffer.SETRANGE("Source No.", B2BPrices.No);
                    if SalesNetPriceBuffer.FINDFIRST() then
                        //Insert lines
                        CreateResponseLineMsg(XMLDoc, XMLCurrNode2, B2BPrices)
                    else begin
                        //HEI.02>>
                        if B2BInterfaceSetup."Split Pricing File" and (B2BInterfaceSetup."No of Customers per File" > 0) then
                            if NoOfCustomersInserted = B2BInterfaceSetup."No of Customers per File" then begin
                                //Update Integration Framework Log
                                IntegrationFrameworkLog.CALCFIELDS("Response File");
                                IntegrationFrameworkLog."Response File".CREATEOUTSTREAM(OutputStream, TextEncoding::UTF8); // SHUKLP03 <<
                                IntegrationFrameworkLog."Response Date/Time" := CURRENTDATETIME;

                                //HEI.07>>
                                //XMLDoc.Save(OutputStream);

                                // SHUKLP03 >>
                                // TempBigText.ADDTEXT(XMLDoc.InnerXml); 
                                // TempBigText.WRITE(OutputStream);
                                // CLEAR(TempBigText);
                                XMLDoc.WriteTo(OutputStream);
                                // SHUKLP03 <<
                                //HEI.07<<

                                IntegrationFrameworkLog.MODIFY(true);

                                //Send XML message
                                IntegrationFrameworkLog.SendMessage();

                                NoOfCustomersInserted := 0;

                                //Insert new Entry Log
                                IntegrationFrameworkLog.INIT();
                                //HEI.11>>
                                //IF IntegrationFrameworkLog2.FINDLAST THEN
                                //  IntegrationFrameworkLog."Entry No" := IntegrationFrameworkLog2."Entry No" + 1;
                                IntegrationFrameworkLog."Entry No" := 0;
                                //HEI.11<<
                                IntegrationFrameworkLog."Interface Code" := B2BInterfaceSetup."B2B Pricing Interface Code";
                                IntegrationFrameworkLog."Request Sync. Date/Time" := CURRENTDATETIME;
                                IntegrationFrameworkLog."Call Type" := InterfaceSetup."Call Type";
                                IntegrationFrameworkLog.INSERT(true);

                                //HEI.05>>
                                //CreateResponseXMLMsg(XMLDoc,XMLCurrNode);
                                CreateResponseXMLMsg(XMLDoc, XMLCurrNode, 'PriceList');
                                //HEI.05<<
                            end;
                        //HEI.02<<

                        //HEI.04>>
                        //Skip Customer if there is no Price with the same Currency
                        if B2BInterfaceSetup."Skip Multi Currency Prices" then begin
                            GeneralLedgerSetup.GET();
                            Customer.GET(B2BPrices.No);
                            PricesHaveSameCurrency := false;

                            if RunDate <> 0D then
                                B2BPrices2.SETFILTER(As_Per_date, '%1', RunDate)
                            else
                                B2BPrices2.SETFILTER(As_Per_date, '%1', WORKDATE());
                            B2BPrices2.SETFILTER(Customer_No, '<>%1', '');
                            B2BPrices2.SETFILTER(Unit_Price, '<>%1', 0);
                            if Customer."Currency Code" <> '' then begin
                                if Customer."Currency Code" <> GeneralLedgerSetup."LCY Code" then
                                    B2BPrices2.SETFILTER(Currency_Code, '%1', Customer."Currency Code")
                                else
                                    B2BPrices2.SETFILTER(Currency_Code, '%1|%2', '', GeneralLedgerSetup."LCY Code");
                            end else
                                B2BPrices2.SETFILTER(Currency_Code, '%1|%2', '', GeneralLedgerSetup."LCY Code");
                            B2BPrices2.OPEN();

                            PricesHaveSameCurrency := B2BPrices2.READ();
                        end;

                        if not B2BInterfaceSetup."Skip Multi Currency Prices" or
                           (B2BInterfaceSetup."Skip Multi Currency Prices" and PricesHaveSameCurrency)
                        then begin
                            //HEI.04<<

                            SalesNetPriceBuffer.INIT();
                            // SHUKLP03 >>
                            IF (SalesNetPriceBuffer."Entry No." = 0) THEN
                                SalesNetPriceBuffer."Entry No." := 1
                            ELSE
                                SalesNetPriceBuffer."Entry No." := SalesNetPriceBuffer."Entry No." + 1;
                            // SHUKLP03 <<
                            SalesNetPriceBuffer."Source Type" := SalesNetPriceBuffer."Source Type"::Customer; // SHUKLP03
                            SalesNetPriceBuffer."Source No." := B2BPrices.No;
                            SalesNetPriceBuffer.INSERT();

                            NoOfCustomersInserted += 1; //HEI.02

                            //Insert Header
                            CreateResponseHeaderMsg(XMLDoc, XMLCurrNode, XMLCurrNode2, B2BPrices);

                            //Insert first line
                            CreateResponseLineMsg(XMLDoc, XMLCurrNode2, B2BPrices);
                        end; //HEI.04
                    end;
                end; //HEI.10
            end;

        if NoOfCustomers > 0 then begin
            //Update Integration Framework Log
            IntegrationFrameworkLog.CALCFIELDS("Response File");
            IntegrationFrameworkLog."Response File".CREATEOUTSTREAM(OutputStream, TextEncoding::UTF8); // SHUKLP03 <<
            IntegrationFrameworkLog."Response Date/Time" := CURRENTDATETIME;

            //HEI.07>>
            //XMLDoc.Save(OutputStream);

            // SHUKLP03 >>
            // TempBigText.ADDTEXT(XMLDoc.InnerXml); 

            // TempBigText.WRITE(OutputStream);
            // CLEAR(TempBigText);
            XMLDoc.WriteTo(OutputStream);
            // SHUKLP03 << 

            //HEI.07<<

            IntegrationFrameworkLog.MODIFY(true);

            //Send XML message
            IntegrationFrameworkLog.SendMessage();
        end;

        //HEI.08>>
        CLEAR(XMLDoc);
        CLEAR(XMLCurrNode);
        CLEAR(XMLCurrNode2);
        //HEI.08<<
        CLEAR(OutputStream); //HEI.09

    end;
    // //BC Upgrade GUNREM01 -Dependency with DIT fields <<

    // // local procedure CreateResponseXMLMsg(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; MainNodeName: Text);
    local procedure CreateResponseXMLMsg(var XMLDoc: XmlDocument; var XMLCurrNode: XmlNode; MainNodeName: Text);

    var
        //  ProcessingInstruction: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlProcessingInstruction";
        ProcessingInstruction: XmlProcessingInstruction;
        XmlDecl: XmlDeclaration;
        XMLElem: XmlElement;
    begin
        // XMLDoc := XMLDoc.XmlDocument;
        // //HEI.05>>
        // //XMLCurrNode := XMLDoc.CreateElement('PriceList');
        // XMLCurrNode := XMLDoc.CreateElement(MainNodeName);
        // //HEI.05<<
        // XMLDoc.AppendChild(XMLCurrNode);
        // ProcessingInstruction := XMLDoc.CreateProcessingInstruction('?xml', 'version="1.0" encoding="UTF-8"?');
        //BC Upgrade GUNREM01 replaced code using XML var >>
        //MainNodeName := 'Root'; // SHUKLP03 <<
        XmlDoc := XmlDocument.Create();
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', 'yes');
        XmlDoc.SetDeclaration(XmlDecl);
        XMLElem := XmlElement.Create(MainNodeName);
        XmlDoc.Add(XMLElem);
        XMLCurrNode := XMLElem.AsXmlNode(); // SHUKLP03 <<

        //BC Upgrade GUNREM01 replaced code using XML var <<
    end;

    local procedure CreateResponseHeaderMsg(var XMLDoc: XmlDocument; var XMLCurrNode: XmlNode; var XMLCurrNode2: XmlNode; B2BPrices: Query "B2B Prices");
    var
        XMLDOMMgt: Codeunit "XML DOM Management";
        // NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        NewChildNode: XmlNode;
        GeneralLedgerSetup: Record "General Ledger Setup";
        Customer: Record Customer;
        CompanyInformation: Record "Company Information";
        XMLElem: XmlElement;
    begin
        GeneralLedgerSetup.GET();
        CompanyInformation.GET();
        Customer.GET(B2BPrices.No);
        //HEI.04>>
        CurrencyCode := '';
        LCYCode := GeneralLedgerSetup."LCY Code";
        //HEI.04<<
        //BC Upgrade GUNREM01 Replaced code using XML variables >>
        // XMLCurrNode2 := XMLDoc.CreateElement('Customer');
        // XMLCurrNode.AppendChild(XMLCurrNode2);

        // SHUKLP03 >>
        // XMLDoc := XmlDocument.Create();
        // XMLElem := XmlElement.Create('Customer');
        // XMLDoc.Add(XMLElem);
        XMLElem := XmlElement.Create('Customer');
        XMLCurrNode2 := XMLElem.AsXmlNode();
        XMLCurrNode.AsXmlElement().Add(XMLCurrNode2);
        // << SHUKLP03


        //BC Upgrade SHUKLP03 Replaced code using XML variables <<

        XMLDOMMgt.AddElement(XMLCurrNode2, 'ID', B2BPrices.No, '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'Name', B2BPrices.No + '_PL', '', NewChildNode);
        //BC U[grade SHUKLP03 -DIT dependency >>
        if Customer."Currency Code" <> '' then
            //HEI.04>>
            //XMLDOMMgt.AddElement(XMLCurrNode2,'Currency',B2BPrices.Currency_Code,'',NewChildNode)
            //ELSE
            //XMLDOMMgt.AddElement(XMLCurrNode2,'Currency',GeneralLedgerSetup."LCY Code",'',NewChildNode);
            //CurrencyCode := B2BPrices.Currency_Code SHUKLP03 <<
            CurrencyCode := B2BPrices.Currency_Code //SHUKLP03 <<
        else
            CurrencyCode := GeneralLedgerSetup."LCY Code";
        XMLDOMMgt.AddElement(XMLCurrNode2, 'Currency', CurrencyCode, '', NewChildNode);
        //BC Upgrade SHUKLP03 <<  -DIT dependency <<
        //HEI.04<<

        XMLDOMMgt.AddElement(XMLCurrNode2, 'DistributorID', CompanyInformation."Legal Entity Code FND", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'OutletID', B2BPrices.No, '', NewChildNode);

        CLEAR(NewChildNode); //HEI.08
    end;

    // local procedure CreateResponseLineMsg(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; B2BPrices: Query "B2B Prices");
    local procedure CreateResponseLineMsg(var XMLDoc: XmlDocument; var XMLCurrNode2: XmlNode; B2BPrices: Query "B2B Prices");
    var
        XMLDOMMgt: Codeunit "XML DOM Management";
        //BC Upgrade GUNREM01 Replaced Dotnet var >>
        // XMLCurrNode3: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        XMLCurrNode3: XmlNode;
        NewChildNode: XmlNode;
        XMLElem: XmlElement; // SHUKLP03
        ListPriceString: Text;
        SalesPriceString: Text;
    begin
        //HEI.04>>
        // SHUKLP03 >>
        if B2BInterfaceSetup."Skip Multi Currency Prices" then
            if ((CurrencyCode <> B2BPrices.Currency_Code) and (B2BPrices.Currency_Code <> '')) or
               ((CurrencyCode <> LCYCode) and (B2BPrices.Currency_Code = ''))
            then
                exit;
        // SHUKLP03 <<
        //HEI.04<<

        // SHUKLP03 >>
        // XMLCurrNode3 := XMLDoc.CreateElement('Price');
        // XMLCurrNode2.AppendChild(XMLCurrNode3);
        // XMLDoc := XmlDocument.Create();
        // XMLElem := XmlElement.Create('Price');
        // XMLDoc.Add(XMLElem);
        XMLElem := XmlElement.Create('Price');
        XMLCurrNode3 := XMLElem.AsXmlNode();
        XMLCurrNode2.AsXmlElement().Add(XMLCurrNode3);
        // SHUKLP03 <<

        XMLDOMMgt.AddElement(XMLCurrNode3, 'SKU', B2BPrices.Item_No, '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3, 'UoM', B2BPrices.Unit_of_Measure_Code, '', NewChildNode);
        //BC Upgrade SHUKLP03 -DIT Dependency <<

        //ListPriceString := FORMAT(B2BPrices.Unit_Price + B2BPrices.Disc_Charges_incl_Item_Price); // BC Upgrade SHUKLP03 << field Disc.-Charges incl. Item Price is obsolete as per Aptean.
        ListPriceString := FORMAT(B2BPrices.Unit_Price);   // BC Upgrade SHUKLP03 << 
        ListPriceString := DELCHR(ListPriceString, '=', ',');
        XMLDOMMgt.AddElement(XMLCurrNode3, 'ListPrice', ListPriceString, '', NewChildNode);

        //HEI.13>>
        //SalesPriceString := FORMAT(B2BPrices.Net_Price_Item);
        SalesPriceString := FORMAT(B2BPrices.Net_Price_Order); //BC Upgrade GUNREM01 DIT field
        //HEI.13<<
        SalesPriceString := DELCHR(SalesPriceString, '=', ',');
        XMLDOMMgt.AddElement(XMLCurrNode3, 'SalesPrice', SalesPriceString, '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode3, 'MinQuantity', FORMAT(B2BPrices.Minimum_Quantity), '', NewChildNode); //BC Upgrade GUNREM01 DIT field
        //HEI.03>>
        //XMLDOMMgt.AddElement(XMLCurrNode3,'StartDate',FORMAT(B2BPrices.Starting_Date),'',NewChildNode);
        //XMLDOMMgt.AddElement(XMLCurrNode3,'EndDate',FORMAT(B2BPrices.Ending_Date),'',NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3, 'StartDate', FORMAT(B2BPrices.Starting_Date, 0, '<Month,2>/<Day,2>/<Year,2>'), '', NewChildNode); //BC Upgrade SHUKLP03 DIT field
        XMLDOMMgt.AddElement(XMLCurrNode3, 'EndDate', FORMAT(B2BPrices.Ending_Date, 0, '<Month,2>/<Day,2>/<Year,2>'), '', NewChildNode);//BC Upgrade SHUKLP03 << Deprecated as per aptean.
        //HEI.03<<

        //HEI.08>>
        CLEAR(NewChildNode);
        CLEAR(XMLCurrNode3);
        //HEI.08<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDocument(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]);
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //HEI.05>>
        if SalesHeader.ISTEMPORARY then
            exit;

        if not B2BInterfaceSetup.GET() then
            exit;

        if not B2BInterfaceSetup."Enable B2B Interfaces" then
            exit;

        if not B2BInterfaceSetup."Send all Invoices and Cr Memos" and
           (SalesHeader."Source System Identifier FND" = '')
        then
            exit
        else begin
            SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier FND");
            if not SourceSystemIdentifierAPI."Enable Invoicing" then
                exit;
        end;

        if not InterfaceSetup.GET(B2BInterfaceSetup."B2B Invoice /Cr Memo Interface") then
            exit;

        if not InterfaceSetup.Enabled then
            exit;

        if (SalesInvHdrNo = '') and (SalesCrMemoHdrNo = '') then
            exit;

        CreateAndSendPostedDocumentXML(SalesInvHdrNo, SalesCrMemoHdrNo);
        //HEI.05<<
    end;

    [EventSubscriber(ObjectType::Table, 379, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterApplyCustLedgEntry(var Rec: Record "Detailed Cust. Ledg. Entry"; RunTrigger: Boolean);
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        InterfaceSetup: Record "Interface Setup INT";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        SourceCodeSetup: Record "Source Code Setup";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
    begin
        //HEI.05>>
        SourceCodeSetup.GET();
        // CustLedgerEntry.GET(Rec."Cust. Ledger Entry No.");  // BC Upgrade SHUKLP03 <<

        if Rec.ISTEMPORARY then
            exit;

        if Rec."Entry Type" <> Rec."Entry Type"::Application then
            exit;

        //Apply Sales Invoice
        if (Rec."Document Type" = Rec."Document Type"::Invoice) and
             (Rec."Source Code" = SourceCodeSetup."Sales Entry Application") and
             (Rec.Amount > 0)
          then
            exit;

        //Unapply Sales Invoice
        if (Rec."Document Type" = Rec."Document Type"::Invoice) and
             (Rec."Source Code" = SourceCodeSetup."Unapplied Sales Entry Appln.") and
             (Rec.Amount < 0)
          then
            exit;

        //Apply Credit Memo
        if (Rec."Document Type" = Rec."Document Type"::"Credit Memo") and
             (Rec."Source Code" = SourceCodeSetup."Sales Entry Application") and
             (Rec.Amount < 0)
          then
            exit;

        //Unapply Credit Memo
        if (Rec."Document Type" = Rec."Document Type"::"Credit Memo") and
             (Rec."Source Code" = SourceCodeSetup."Unapplied Sales Entry Appln.") and
             (Rec.Amount > 0)
          then
            exit;

        //Sales Credit Memo applied to Sales Invoice on posting
        if (Rec."Document Type" = Rec."Document Type"::"Credit Memo") and
             (Rec."Source Code" = SourceCodeSetup.Sales) and
             (Rec.Amount > 0)
          then
            exit;

        //Invoice applied to Payment on posting
        if (Rec."Document Type" = Rec."Document Type"::Invoice) and
             (Rec."Source Code" = SourceCodeSetup.Sales) and
             (Rec.Amount < 0)
          then
            exit;

        if not B2BInterfaceSetup.GET() then
            exit;

        if not B2BInterfaceSetup."Enable B2B Interfaces" then
            exit;

        CustLedgerEntry.GET(Rec."Cust. Ledger Entry No.");  // BC Upgrade SHUKLP03 <<
        if not B2BInterfaceSetup."Send all Invoices and Cr Memos" and
           (CustLedgerEntry."Source System Identifier FND" = '')
        then
            exit
        else begin
            SourceSystemIdentifierAPI.GET(CustLedgerEntry."Source System Identifier FND");
            if not SourceSystemIdentifierAPI."Enable Invoicing" then
                exit;
        end;

        if not InterfaceSetup.GET(B2BInterfaceSetup."B2B Invoice /Cr Memo Interface") then
            exit;

        if not InterfaceSetup.Enabled then
            exit;

        if Rec."Document Type" = Rec."Document Type"::Invoice then begin
            if (Rec."Source Code" = SourceCodeSetup.Sales) and
               (Rec."Applied Cust. Ledger Entry No." <> Rec."Cust. Ledger Entry No.")
            then begin
                CustLedgerEntry2.GET(Rec."Cust. Ledger Entry No.");
                if CustLedgerEntry2."Document Type" = CustLedgerEntry2."Document Type"::Payment then
                    CreateAndSendPostedDocumentXML(Rec."Document No.", '');
            end else
                CreateAndSendPostedDocumentXML(Rec."Document No.", '')
        end else if Rec."Document Type" = Rec."Document Type"::"Credit Memo" then begin
            if (Rec."Source Code" = SourceCodeSetup.Sales) and
               (Rec."Applied Cust. Ledger Entry No." <> Rec."Cust. Ledger Entry No.")
            then begin
                CustLedgerEntry2.GET(Rec."Cust. Ledger Entry No.");
                if CustLedgerEntry2."Document Type" = CustLedgerEntry2."Document Type"::Invoice then
                    CreateAndSendPostedDocumentXML(CustLedgerEntry2."Document No.", '')
            end else
                CreateAndSendPostedDocumentXML('', Rec."Document No.");
        end;

        if (Rec."Document Type" = Rec."Document Type"::Payment) and
           (Rec."Applied Cust. Ledger Entry No." <> 0) and
           (Rec."Applied Cust. Ledger Entry No." <> Rec."Cust. Ledger Entry No.")
        then begin
            CustLedgerEntry2.GET(Rec."Cust. Ledger Entry No.");
            if CustLedgerEntry2."Document Type" = CustLedgerEntry2."Document Type"::Invoice then
                CreateAndSendPostedDocumentXML(CustLedgerEntry2."Document No.", '')
            else if CustLedgerEntry2."Document Type" = CustLedgerEntry2."Document Type"::"Credit Memo" then
                CreateAndSendPostedDocumentXML('', CustLedgerEntry2."Document No.");
        end;
        //HEI.05<<
    end;

    local procedure CreateAndSendPostedDocumentXML(SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]);
    var
        InterfaceSetup: Record "Interface Setup INT";
        IntegrationFrameworkLog: Record "Integration Framework Log INT";
        IntegrationFrameworkLog2: Record "Integration Framework Log INT";
        //BC Upgrade GUNREM01 >>
        // XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        XMLDoc: XmlDocument;
        XMLCurrNode: XmlNode;
        XMLCurrNode2: XmlNode;
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
        Request: BigText;
        //BC Upgrade GUNREM01 <<
        OutputStream: OutStream;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        TempBigText: BigText;
    begin
        //HEI.05>>
        InterfaceSetup.GET(B2BInterfaceSetup."B2B Invoice /Cr Memo Interface");

        //Insert in Integration Framework Log
        IntegrationFrameworkLog.INIT();
        if IntegrationFrameworkLog2.FINDLAST() then
            IntegrationFrameworkLog."Entry No" := IntegrationFrameworkLog2."Entry No" + 1;
        IntegrationFrameworkLog."Interface Code" := B2BInterfaceSetup."B2B Invoice /Cr Memo Interface";
        IntegrationFrameworkLog."Request Sync. Date/Time" := CURRENTDATETIME;
        IntegrationFrameworkLog."Call Type" := InterfaceSetup."Call Type";
        IntegrationFrameworkLog.INSERT(true);

        //Create XML Signature
        CreateResponseXMLMsg(XMLDoc, XMLCurrNode, 'InvoicePayload');

        //Insert Invoice Header
        if SalesInvHdrNo <> '' then begin
            SalesInvoiceHeader.GET(SalesInvHdrNo);
            CreateInvoiceHeaderMsg(XMLDoc, XMLCurrNode, XMLCurrNode2, SalesInvoiceHeader);

            //Insert Invoice Lines
            SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
            SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
            if SalesInvoiceLine.FINDSET() then
                repeat
                    CreateInvoiceLineMsg(XMLDoc, XMLCurrNode2, SalesInvoiceLine);
                until SalesInvoiceLine.NEXT() = 0;
            //Insert Cr Memo Header
        end else if SalesCrMemoHdrNo <> '' then begin
            SalesCrMemoHeader.GET(SalesCrMemoHdrNo);
            CreateCrMemoHeaderMsg(XMLDoc, XMLCurrNode, XMLCurrNode2, SalesCrMemoHeader);

            //Insert Cr Memo Lines
            SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
            SalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type::Item);
            if SalesCrMemoLine.FINDSET() then
                repeat
                    CreateCrMemoLineMsg(XMLDoc, XMLCurrNode2, SalesCrMemoLine);
                until SalesCrMemoLine.NEXT() = 0;
        end;

        //Update Integration Framework Log
        IntegrationFrameworkLog.CALCFIELDS("Response File");
        IntegrationFrameworkLog."Response File".CREATEOUTSTREAM(OutputStream, TextEncoding::UTF8); // SHUKLP03 <<
        IntegrationFrameworkLog."Response Date/Time" := CURRENTDATETIME;

        //HEI.07>>
        //XMLDoc.Save(OutputStream);
        // TempBigText.ADDTEXT(XMLDoc.InnerXml);
        // TempBigText.WRITE(OutputStream);
        // CLEAR(TempBigText);
        // SHUKLP03 >>
        // RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
        // XMLDoc.WriteTo(RespOut);
        // RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
        // RespIn.ReadText(RespText);
        // Request.AddText(RespText);
        XMLDoc.WriteTo(OutputStream);
        // SHUKLP03 <<
        //HEI.07<<

        //Update Source No
        if SalesInvHdrNo <> '' then
            IntegrationFrameworkLog."Source No." := SalesInvHdrNo
        else
            if SalesCrMemoHdrNo <> '' then
                IntegrationFrameworkLog."Source No." := SalesCrMemoHdrNo;
        IntegrationFrameworkLog.MODIFY(true);

        //Send XML message
        IntegrationFrameworkLog.SendMessage();
        //HEI.05<<

        //HEI.08>>
        CLEAR(XMLDoc);
        CLEAR(XMLCurrNode);
        CLEAR(XMLCurrNode2);
        //HEI.08<<
        CLEAR(OutputStream); //HEI.09
    end;

    //  local procedure CreateInvoiceHeaderMsg(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; var XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; SalesInvoiceHeader: Record "Sales Invoice Header");
    local procedure CreateInvoiceHeaderMsg(var XMLDoc: XmlDocument; var XMLCurrNode: XmlNode; var XMLCurrNode2: XmlNode; SalesInvoiceHeader: Record "Sales Invoice Header"); //BC Upgrade GUNREM01

    var
        XMLDOMMgt: Codeunit "XML DOM Management";
        //BC upgrade GUNREM01 >>
        //NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        NewChildNode: XmlNode;
        XMLElem: XmlElement;
        //BC upgrade GUNREM01 <<
        GeneralLedgerSetup: Record "General Ledger Setup";
        Customer: Record Customer;
        CompanyInformation: Record "Company Information";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        SalesInvoiceLine: Record "Sales Invoice Line";
        ItemCharge: Record "Item Charge";
        SalesCommentLine: Record "Sales Comment Line";
        DepositAmount: Decimal;
        Comments: Text;
        PaidAmount: Decimal;
        ClosingDate: Date;
        PaymentTerms: Record "Payment Terms";
        TotalNegDiscUnderItemLine: Decimal;
        TotalPosDiscUnderItemLine: Decimal;
    begin
        //HEI.05>>
        SalesInvoiceHeader.CALCFIELDS(Amount, "Amount Including VAT", Closed, Comment);
        //BC Upgrade GUNREM01 replaced code using XML var >>
        // XMLCurrNode2 := XMLDoc.CreateElement('Invoice');
        // XMLCurrNode.AppendChild(XMLCurrNode2);

        // >> SHUKLP03
        // XMLDoc := XmlDocument.Create();
        // XMLElem := XmlElement.Create('Invoice');
        // XMLDoc.Add(XMLElem);
        // Create child element
        XMLElem := XmlElement.Create('Invoice');

        // Convert to node
        XMLCurrNode2 := XMLElem.AsXmlNode();

        // Add child node to parent/root node
        XMLCurrNode.AsXmlElement().Add(XMLCurrNode2);
        // << SHUKLP03

        //BC Upgrade GUNREM01 replaced code using XML var <<
        XMLDOMMgt.AddElement(XMLCurrNode2, 'Tenant', UPPERCASE(TENANTID()), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'Company', UPPERCASE(COMPANYNAME), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'OrderID', SalesInvoiceHeader."Order No.", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'ID', SalesInvoiceHeader."No.", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'Number', SalesInvoiceHeader."No.", '', NewChildNode);

        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        if CustLedgerEntry.FINDSET() then
            repeat
                CustLedgerEntry.CALCFIELDS("Remaining Amount", "Original Amount");
                PaidAmount += CustLedgerEntry."Original Amount" - CustLedgerEntry."Remaining Amount";
                if CustLedgerEntry."Closed at Date" <> 0D then
                    ClosingDate := CustLedgerEntry."Closed at Date";
            until CustLedgerEntry.NEXT() = 0;

        if PaidAmount = 0 then
            CLEAR(ClosingDate);

        if SalesInvoiceHeader.Closed then begin
            if PaidAmount = SalesInvoiceHeader."Amount Including VAT" then
                XMLDOMMgt.AddElement(XMLCurrNode2, 'Status', 'Paid', '', NewChildNode)
            else
                XMLDOMMgt.AddElement(XMLCurrNode2, 'Status', 'Open', '', NewChildNode);
        end else begin
            if WORKDATE() > SalesInvoiceHeader."Due Date" then
                XMLDOMMgt.AddElement(XMLCurrNode2, 'Status', 'Overdue', '', NewChildNode)
            else
                XMLDOMMgt.AddElement(XMLCurrNode2, 'Status', 'Open', '', NewChildNode);
        end;

        XMLDOMMgt.AddElement(XMLCurrNode2, 'InvoiceDate', FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Month,2>/<Day,2>/<Year,2>'), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'InvoiceDueDate', FORMAT(SalesInvoiceHeader."Due Date", 0, '<Month,2>/<Day,2>/<Year,2>'), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'DeliveredBy', SalesInvoiceHeader."Shipping Agent Code", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'ShipmentDate', FORMAT(SalesInvoiceHeader."Shipment Date", 0, '<Month,2>/<Day,2>/<Year,2>'), '', NewChildNode);

        if SalesInvoiceHeader.Closed and
           (PaidAmount = SalesInvoiceHeader."Amount Including VAT")
        then
            XMLDOMMgt.AddElement(XMLCurrNode2, 'InvoiceIsPaid', 'TRUE', '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode2, 'InvoiceIsPaid', 'FALSE', '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode2, 'PaymentDate', FORMAT(ClosingDate, 0, '<Month,2>/<Day,2>/<Year,2>'), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'PaidAmount', CheckNumberFormat(FORMAT(PaidAmount, 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);

        if SalesInvoiceHeader."Payment Terms Code" <> '' then
            PaymentTerms.GET(SalesInvoiceHeader."Payment Terms Code");
        XMLDOMMgt.AddElement(XMLCurrNode2, 'PaymentTerms', PaymentTerms.Description, '', NewChildNode);

        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
        SalesInvoiceLine.SETRANGE("Attached Line Type 101FDW", SalesInvoiceLine."Attached Line Type 101FDW"::"EGM 104FDW"); //BC upgrade SHUKLP03 -DIT Field
        if SalesInvoiceLine.FINDSET() then
            repeat
                DepositAmount += SalesInvoiceLine.Amount;
            until SalesInvoiceLine.NEXT() = 0;

        CLEAR(SalesInvoiceLine);
        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
        //BC upgrade GUNREM01 -DIT Fields
        SalesInvoiceLine.SETRANGE("Attached Line Type 101FDW", SalesInvoiceLine."Attached Line Type 101FDW"::"SPC 105FDW"); // SHUKLP03
        SalesInvoiceLine.SETRANGE("Show Item charge on Inv. FND", SalesInvoiceLine."Show Item charge on Inv. FND"::"Under item line");

        //BC upgrade GUNREM01 -DIT Field
        if SalesInvoiceLine.FINDSET() then
            repeat
                if SalesInvoiceLine.Quantity < 0 then
                    TotalNegDiscUnderItemLine += SalesInvoiceLine.Amount
                else
                    if SalesInvoiceLine.Quantity > 0 then
                        TotalPosDiscUnderItemLine += SalesInvoiceLine.Amount;
            until SalesInvoiceLine.NEXT() = 0;

        //Subtotal = Subtotal Excl. VAT - Deposit Amount + TotalDiscount - Total Surcharge
        XMLDOMMgt.AddElement(XMLCurrNode2, 'Subtotal', CheckNumberFormat(FORMAT(SalesInvoiceHeader.Amount - DepositAmount + TotalNegDiscUnderItemLine - TotalPosDiscUnderItemLine, 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode2, 'EmptiesDeposit', CheckNumberFormat(FORMAT(DepositAmount, 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'EmptiesReturned', '0.00', '', NewChildNode);

        //TotalPrice = Subtotal Excl. VAT  + TotalDiscount - Total Surcharge
        XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalPrice', CheckNumberFormat(FORMAT(SalesInvoiceHeader.Amount + TotalNegDiscUnderItemLine - TotalPosDiscUnderItemLine, 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalDiscount', CheckNumberFormat(FORMAT(TotalNegDiscUnderItemLine, 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalSurcharge', CheckNumberFormat(FORMAT(TotalPosDiscUnderItemLine, 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);

        //TotalNetAmount = Subtotal Excl. VAT
        XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalNetAmount', CheckNumberFormat(FORMAT(SalesInvoiceHeader.Amount, 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalTax', CheckNumberFormat(FORMAT(SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount, 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalInvoiceAmount', CheckNumberFormat(FORMAT(SalesInvoiceHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);

        if SalesInvoiceHeader.Comment then begin
            SalesCommentLine.SETRANGE("Document Type", SalesCommentLine."Document Type"::"Posted Invoice");
            SalesCommentLine.SETRANGE("No.", SalesInvoiceHeader."No.");
            SalesCommentLine.SETRANGE("Document Line No.", 0);
            if SalesCommentLine.FINDSET() then
                repeat
                    Comments += SalesCommentLine.Comment + ' ';
                until SalesCommentLine.NEXT() = 0;
            XMLDOMMgt.AddElement(XMLCurrNode2, 'Comments', Comments, '', NewChildNode);
        end else
            XMLDOMMgt.AddElement(XMLCurrNode2, 'Comments', '', '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode2, 'OrganizationID', SalesInvoiceHeader."Bill-to Customer No.", '', NewChildNode);
        //HEI.05>>

        CLEAR(NewChildNode); //HEI.08
    end;

    //  local procedure CreateInvoiceLineMsg(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; SalesInvoiceLine: Record "Sales Invoice Line");
    local procedure CreateInvoiceLineMsg(var XMLDoc: XmlDocument; var XMLCurrNode2: XmlNode; SalesInvoiceLine: Record "Sales Invoice Line"); //BC Upgrade GUNREM01 

    var
        XMLDOMMgt: Codeunit "XML DOM Management";
        //BC Upgrade GUNREM01 >>
        // XMLCurrNode3: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        XMLCurrNode3: xmlnode;
        NewChildNode: XmlNode;
        XMLElem: XmlElement;
        //BC Upgrade GUNREM01 <<
        SalesInvoiceLine2: Record "Sales Invoice Line";
        ItemCharge: Record "Item Charge";
        TotalDiscInclItemPrice: Decimal;
        TotalNegDiscUnderItemLine: Decimal;
        TotalPosDiscUnderItemLine: Decimal;
    begin
        //HEI.05>>
        //BC Upgrade GUNREM01 >>
        // XMLCurrNode3 := XMLDoc.CreateElement('InvoiceLineItem');
        // XMLCurrNode2.AppendChild(XMLCurrNode3);

        // SHUKLP03 >>
        // XMLDoc := XmlDocument.Create();
        // XMLElem := XmlElement.Create('InvoiceLineItem');
        // XMLDoc.Add(XMLElem);
        // Create child element
        XMLElem := XmlElement.Create('InvoiceLineItem');

        // Convert to node
        XMLCurrNode3 := XMLElem.AsXmlNode();

        // Add child node to parent/root node
        XMLCurrNode2.AsXmlElement().Add(XMLCurrNode3);
        // SHUKLP03 <<

        //BC Upgrade GUNREM01 <<
        XMLDOMMgt.AddElement(XMLCurrNode3, 'SKU', SalesInvoiceLine."No.", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3, 'Gtin', '', '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3, 'UnitOfMeasure', SalesInvoiceLine."Unit of Measure Code", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3, 'Quantity', CheckNumberFormat(FORMAT(SalesInvoiceLine.Quantity)), '', NewChildNode);

        CLEAR(SalesInvoiceLine2);
        SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        SalesInvoiceLine2.SETRANGE("Attached to Line No.", SalesInvoiceLine."Line No.");
        SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine2.Type::"Charge (Item)");
        //BC Upgrade GUNREM01 -DIT Fields >>
        SalesInvoiceLine2.SETRANGE("Attached Line Type 101FDW", SalesInvoiceLine2."Attached Line Type 101FDW"::"SPC 105FDW"); // SHUKLP03
        SalesInvoiceLine2.SETRANGE("Show Item charge on Inv. FND", SalesInvoiceLine2."Show Item charge on Inv. FND"::"Include in item price");

        //BC Upgrade GUNREM01 -DIT Fields <<
        if SalesInvoiceLine2.FINDSET() then
            repeat
                TotalDiscInclItemPrice += SalesInvoiceLine2.Amount;
            until SalesInvoiceLine2.NEXT() = 0;

        XMLDOMMgt.AddElement(XMLCurrNode3, 'Price', CheckNumberFormat(FORMAT(SalesInvoiceLine."Unit Price" + TotalDiscInclItemPrice, 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3, 'ExtendedPrice', CheckNumberFormat(FORMAT(SalesInvoiceLine.Quantity * (SalesInvoiceLine."Unit Price" + TotalDiscInclItemPrice), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);
        //BC Upgrade GUNREM01 -DIT Fields >>
        if SalesInvoiceLine."Line Discount %" = 100 then         // SHUKLP03 <<
            XMLDOMMgt.AddElement(XMLCurrNode3, 'IsGift', 'TRUE', '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode3, 'IsGift', 'FALSE', '', NewChildNode);
        //BC Upgrade GUNREM01 -DIT Fields <<
        CLEAR(SalesInvoiceLine2);
        SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        SalesInvoiceLine2.SETRANGE("Attached to Line No.", SalesInvoiceLine."Line No.");
        SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine2.Type::"Charge (Item)");
        //BC Upgrade GUNREM01 -DIT Fields >>
        SalesInvoiceLine2.SETRANGE("Attached Line Type 101FDW", SalesInvoiceLine2."Attached Line Type 101FDW"::"SPC 105FDW"); // SHUKLP03
        SalesInvoiceLine2.SETRANGE("Show Item charge on Inv. FND", SalesInvoiceLine2."Show Item charge on Inv. FND"::"Under item line");

        //BC Upgrade GUNREM01 -DIT Fields <<
        if SalesInvoiceLine2.FINDSET() then
            repeat
                if SalesInvoiceLine2.Amount < 0 then
                    TotalNegDiscUnderItemLine += SalesInvoiceLine2.Amount
                else
                    if SalesInvoiceLine2.Amount > 0 then
                        TotalPosDiscUnderItemLine += SalesInvoiceLine2.Amount;
            until SalesInvoiceLine2.NEXT() = 0;

        if TotalNegDiscUnderItemLine <> 0 then begin
            XMLDOMMgt.AddElement(XMLCurrNode3, 'HasDiscount', 'TRUE', '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalDiscount', CheckNumberFormat(FORMAT(TotalNegDiscUnderItemLine, 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);
        end else begin
            XMLDOMMgt.AddElement(XMLCurrNode3, 'HasDiscount', 'FALSE', '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalDiscount', '0.00', '', NewChildNode);
        end;

        XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalSurcharge', CheckNumberFormat(FORMAT(TotalPosDiscUnderItemLine, 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalTax', CheckNumberFormat(FORMAT(SalesInvoiceLine."Amount Including VAT" - SalesInvoiceLine.Amount, 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3, 'IsReturnableEmpty', 'FALSE', '', NewChildNode);
        //HEI.05<<

        //HEI.08>>
        CLEAR(NewChildNode);
        CLEAR(XMLCurrNode3);
        //HEI.08<<
    end;

    //  local procedure CreateCrMemoHeaderMsg(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; var XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; SalesCrMemoHeader: Record "Sales Cr.Memo Header");
    local procedure CreateCrMemoHeaderMsg(var XMLDoc: XmlDocument; var XMLCurrNode: XmlNode; var XMLCurrNode2: XmlNode; SalesCrMemoHeader: Record "Sales Cr.Memo Header");

    var
        XMLDOMMgt: Codeunit "XML DOM Management";
        //BC Upgrade GUNREM01 >>
        //  NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        NewChildNode: XmlNode;
        XMLElem: XmlElement;
        //BC Upgrade GUNREM01 <<
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ItemCharge: Record "Item Charge";
        SalesCommentLine: Record "Sales Comment Line";
        Comments: Text;
        DepositAmount: Decimal;
        PaymentTerms: Record "Payment Terms";
        TotalNegDiscUnderItemLine: Decimal;
        TotalPosDiscUnderItemLine: Decimal;
    begin
        //HEI.05>>
        SalesCrMemoHeader.CALCFIELDS(Amount, "Amount Including VAT", "Remaining Amount", Comment);
        //BC Upgrade GUNREM01 >>       
        // XMLCurrNode2 := XMLDoc.CreateElement('Invoice');
        // XMLCurrNode.AppendChild(XMLCurrNode2);

        // SHUKLP03 >>
        // XMLDoc := XmlDocument.Create();
        // XMLElem := XmlElement.Create('Invoice');
        // XMLDoc.Add(XMLElem);
        XMLElem := XmlElement.Create('Invoice');

        // Convert to node
        XMLCurrNode2 := XMLElem.AsXmlNode();

        // Add child node to parent/root node
        XMLCurrNode.AsXmlElement().Add(XMLCurrNode2);
        // SHUKLP03 <<

        //BC Upgrade GUNREM01 <<
        XMLDOMMgt.AddElement(XMLCurrNode2, 'Tenant', UPPERCASE(TENANTID()), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'Company', UPPERCASE(COMPANYNAME), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'OrderID', SalesCrMemoHeader."Return Order No.", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'ID', SalesCrMemoHeader."No.", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'Number', SalesCrMemoHeader."No.", '', NewChildNode);

        if SalesCrMemoHeader."Remaining Amount" = 0 then
            XMLDOMMgt.AddElement(XMLCurrNode2, 'Status', 'Credited', '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode2, 'Status', 'Open', '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode2, 'InvoiceDate', FORMAT(SalesCrMemoHeader."Posting Date", 0, '<Month,2>/<Day,2>/<Year,2>'), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'InvoiceDueDate', FORMAT(SalesCrMemoHeader."Due Date", 0, '<Month,2>/<Day,2>/<Year,2>'), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'DeliveredBy', '', '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'ShipmentDate', FORMAT(SalesCrMemoHeader."Shipment Date", 0, '<Month,2>/<Day,2>/<Year,2>'), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'InvoiceIsPaid', 'FALSE', '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'PaymentDate', '', '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'PaidAmount', '0.00', '', NewChildNode);
        if SalesCrMemoHeader."Payment Terms Code" <> '' then
            PaymentTerms.GET(SalesCrMemoHeader."Payment Terms Code");
        XMLDOMMgt.AddElement(XMLCurrNode2, 'PaymentTerms', PaymentTerms.Description, '', NewChildNode);

        SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
        SalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type::"Charge (Item)");
        SalesCrMemoLine.SETRANGE("Attached Line Type 101FDW", SalesCrMemoLine."Attached Line Type 101FDW"::"EGM 104FDW"); //BC Upgrade SHUKLP03 -DIT Field
        if SalesCrMemoLine.FINDSET() then
            repeat
                DepositAmount += SalesCrMemoLine.Amount;
            until SalesCrMemoLine.NEXT() = 0;

        CLEAR(SalesCrMemoLine);
        SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
        SalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type::"Charge (Item)");
        //BC Upgrade GUNREM01 -DIT Fields >>
        SalesCrMemoLine.SETRANGE("Attached Line Type 101FDW", SalesCrMemoLine."Attached Line Type 101FDW"::"SPC 105FDW");  // SHUKLP03
        SalesCrMemoLine.SETRANGE("Show Item charge on Inv. FND", SalesCrMemoLine."Show Item charge on Inv. FND"::"Under item line");

        //BC Upgrade GUNREM01 -DIT Fields <<
        if SalesCrMemoLine.FINDSET() then
            repeat
                if SalesCrMemoLine.Quantity < 0 then
                    TotalNegDiscUnderItemLine += SalesCrMemoLine.Amount
                else
                    if SalesCrMemoLine.Quantity > 0 then
                        TotalPosDiscUnderItemLine += SalesCrMemoLine.Amount;
            until SalesCrMemoLine.NEXT() = 0;

        //Subtotal = Subtotal Excl. VAT - Deposit Amount + TotalDiscount - Total Surcharge
        if SalesCrMemoHeader.Amount - DepositAmount + TotalNegDiscUnderItemLine - TotalPosDiscUnderItemLine <> 0 then
            XMLDOMMgt.AddElement(XMLCurrNode2, 'Subtotal', CheckNumberFormat(FORMAT(-ABS(SalesCrMemoHeader.Amount - DepositAmount + TotalNegDiscUnderItemLine - TotalPosDiscUnderItemLine), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode2, 'Subtotal', '0.00', '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode2, 'EmptiesDeposit', '0.00', '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'EmptiesReturned', CheckNumberFormat(FORMAT(-ABS(DepositAmount), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);

        //TotalPrice = Subtotal Excl. VAT  + TotalDiscount - Total Surcharge
        if SalesCrMemoHeader.Amount + TotalNegDiscUnderItemLine - TotalPosDiscUnderItemLine <> 0 then
            XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalPrice', CheckNumberFormat(FORMAT(-ABS(SalesCrMemoHeader.Amount + TotalNegDiscUnderItemLine - TotalPosDiscUnderItemLine), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalPrice', '0.00', '', NewChildNode);

        if TotalNegDiscUnderItemLine <> 0 then
            XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalDiscount', CheckNumberFormat(FORMAT(ABS(TotalNegDiscUnderItemLine), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalDiscount', '0.00', '', NewChildNode);

        if TotalPosDiscUnderItemLine <> 0 then
            XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalSurcharge', CheckNumberFormat(FORMAT(-ABS(TotalPosDiscUnderItemLine), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalSurcharge', '0.00', '', NewChildNode);

        //TotalNetAmount = Subtotal Excl. VAT
        if SalesCrMemoHeader.Amount <> 0 then
            XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalNetAmount', CheckNumberFormat(FORMAT(-ABS(SalesCrMemoHeader.Amount), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalNetAmount', '0.00', '', NewChildNode);

        if SalesCrMemoHeader."Amount Including VAT" - SalesCrMemoHeader.Amount <> 0 then
            XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalTax', CheckNumberFormat(FORMAT(-ABS(SalesCrMemoHeader."Amount Including VAT" - SalesCrMemoHeader.Amount), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalTax', '0.00', '', NewChildNode);

        if SalesCrMemoHeader."Amount Including VAT" <> 0 then
            XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalInvoiceAmount', CheckNumberFormat(FORMAT(-ABS(SalesCrMemoHeader."Amount Including VAT"), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode2, 'TotalInvoiceAmount', '0.00', '', NewChildNode);

        if SalesCrMemoHeader.Comment then begin
            SalesCommentLine.SETRANGE("Document Type", SalesCommentLine."Document Type"::"Posted Credit Memo");
            SalesCommentLine.SETRANGE("No.", SalesCrMemoHeader."No.");
            SalesCommentLine.SETRANGE("Document Line No.", 0);
            if SalesCommentLine.FINDSET() then
                repeat
                    Comments += SalesCommentLine.Comment + ' ';
                until SalesCommentLine.NEXT() = 0;
            XMLDOMMgt.AddElement(XMLCurrNode2, 'Comments', Comments, '', NewChildNode);
        end else
            XMLDOMMgt.AddElement(XMLCurrNode2, 'Comments', '', '', NewChildNode);

        XMLDOMMgt.AddElement(XMLCurrNode2, 'OrganizationID', SalesCrMemoHeader."Bill-to Customer No.", '', NewChildNode);
        //HEI.05<<

        CLEAR(NewChildNode); //HEI.08
    end;

    //  local procedure CreateCrMemoLineMsg(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; SalesCrMemoLine: Record "Sales Cr.Memo Line");
    local procedure CreateCrMemoLineMsg(var XMLDoc: XmlDocument; var XMLCurrNode2: XmlNode; SalesCrMemoLine: Record "Sales Cr.Memo Line"); //BC Upgrade GUNREM01 

    var
        XMLDOMMgt: Codeunit "XML DOM Management";
        //BC Upgrade GUNREM01 >>
        // XMLCurrNode3: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        XMLCurrNode3: XmlNode;
        NewChildNode: XmlNode;
        XMLElem: XmlElement;
        //BC Upgrade GUNREM01 >>
        SalesCrMemoLine2: Record "Sales Cr.Memo Line";
        Item: Record Item;
        ItemCharge: Record "Item Charge";
        TotalDiscInclItemPrice: Decimal;
        TotalNegDiscUnderItemLine: Decimal;
        TotalPosDiscUnderItemLine: Decimal;
        TotalDeposit: Decimal;
    begin
        //HEI.05>>
        //BC Upgrade GUNREM01 >>
        // XMLCurrNode3 := XMLDoc.CreateElement('InvoiceLineItem');
        // XMLCurrNode2.AppendChild(XMLCurrNode3);

        // SHUKLP03 >>
        // XMLDoc := XmlDocument.Create();
        // XMLElem := XmlElement.Create('InvoiceLineItem');
        // XMLDoc.Add(XMLElem);
        XMLElem := XmlElement.Create('InvoiceLineItem');

        // Convert to node
        XMLCurrNode3 := XMLElem.AsXmlNode();

        // Add child node to parent/root node
        XMLCurrNode2.AsXmlElement().Add(XMLCurrNode3);
        // SHUKLP03 <<

        //BC Upgrade GUNREM01 <<
        XMLDOMMgt.AddElement(XMLCurrNode3, 'SKU', SalesCrMemoLine."No.", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3, 'Gtin', '', '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3, 'UnitOfMeasure', SalesCrMemoLine."Unit of Measure Code", '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode3, 'Quantity', CheckNumberFormat(FORMAT(-ABS(SalesCrMemoLine.Quantity))), '', NewChildNode);

        CLEAR(SalesCrMemoLine2);
        SalesCrMemoLine2.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
        SalesCrMemoLine2.SETRANGE("Attached to Line No.", SalesCrMemoLine."Line No.");
        SalesCrMemoLine2.SETRANGE(Type, SalesCrMemoLine2.Type::"Charge (Item)");
        //BC Upgrade GUNREM01 -DIT Fields >>
        SalesCrMemoLine2.SETRANGE("Attached Line Type 101FDW", SalesCrMemoLine2."Attached Line Type 101FDW"::"SPC 105FDW"); // SHUKLP03
        SalesCrMemoLine2.SETRANGE("Show Item charge on Inv. FND", SalesCrMemoLine2."Show Item charge on Inv. FND"::"Include in item price");

        //BC Upgrade GUNREM01 -DIT Fields <<
        if SalesCrMemoLine2.FINDSET() then
            repeat
                TotalDiscInclItemPrice += SalesCrMemoLine2.Amount;
            until SalesCrMemoLine2.NEXT() = 0;

        if SalesCrMemoLine."Unit Price" <> 0 then begin
            XMLDOMMgt.AddElement(XMLCurrNode3, 'Price', CheckNumberFormat(FORMAT(ABS(SalesCrMemoLine."Unit Price" + TotalDiscInclItemPrice), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode3, 'ExtendedPrice', CheckNumberFormat(FORMAT(-ABS(SalesCrMemoLine.Quantity * (SalesCrMemoLine."Unit Price" + TotalDiscInclItemPrice)), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);
        end else begin
            CLEAR(SalesCrMemoLine2);
            SalesCrMemoLine2.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
            SalesCrMemoLine2.SETRANGE("Attached to Line No.", SalesCrMemoLine."Line No.");
            SalesCrMemoLine2.SETRANGE(Type, SalesCrMemoLine2.Type::"Charge (Item)");
            SalesCrMemoLine2.SETRANGE("Attached Line Type 101FDW", SalesCrMemoLine2."Attached Line Type 101FDW"::"EGM 104FDW"); //BC Upgrade SHUKLP03 -DIT Field
            if SalesCrMemoLine2.FINDSET() then
                repeat
                    TotalDeposit += SalesCrMemoLine2.Amount;
                until SalesCrMemoLine2.NEXT() = 0;

            XMLDOMMgt.AddElement(XMLCurrNode3, 'Price', CheckNumberFormat(FORMAT(ABS(TotalDeposit / SalesCrMemoLine.Quantity), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode3, 'ExtendedPrice', CheckNumberFormat(FORMAT(-ABS(TotalDeposit), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);
        end;
        //BC Upgrade GUNREM01 -DIT Fields >>
        if SalesCrMemoLine."Line Discount %" = 100 then // SHUKLP03 <<
            XMLDOMMgt.AddElement(XMLCurrNode3, 'IsGift', 'TRUE', '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode3, 'IsGift', 'FALSE', '', NewChildNode);
        //BC Upgrade GUNREM01 -DIT Fields <<
        CLEAR(SalesCrMemoLine2);
        SalesCrMemoLine2.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
        SalesCrMemoLine2.SETRANGE("Attached to Line No.", SalesCrMemoLine."Line No.");
        SalesCrMemoLine2.SETRANGE(Type, SalesCrMemoLine2.Type::"Charge (Item)");
        //BC Upgrade GUNREM01 -DIT Fields >>
        SalesCrMemoLine2.SETRANGE("Attached Line Type 101FDW", SalesCrMemoLine2."Attached Line Type 101FDW"::"SPC 105FDW"); // SHUKLP03
        SalesCrMemoLine2.SETRANGE("Show Item charge on Inv. FND", SalesCrMemoLine2."Show Item charge on Inv. FND"::"Under item line");

        //BC Upgrade GUNREM01 -DIT Fields <<
        if SalesCrMemoLine2.FINDSET() then
            repeat
                if SalesCrMemoLine2.Amount < 0 then
                    TotalNegDiscUnderItemLine += SalesCrMemoLine2.Amount
                else
                    if SalesCrMemoLine2.Amount > 0 then
                        TotalPosDiscUnderItemLine += SalesCrMemoLine2.Amount;
            until SalesCrMemoLine2.NEXT() = 0;

        if TotalNegDiscUnderItemLine <> 0 then begin
            XMLDOMMgt.AddElement(XMLCurrNode3, 'HasDiscount', 'TRUE', '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalDiscount', CheckNumberFormat(FORMAT(ABS(TotalNegDiscUnderItemLine), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode);
        end else begin
            XMLDOMMgt.AddElement(XMLCurrNode3, 'HasDiscount', 'FALSE', '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalDiscount', '0.00', '', NewChildNode);
        end;

        if TotalPosDiscUnderItemLine <> 0 then
            XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalSurcharge', CheckNumberFormat(FORMAT(-ABS(TotalPosDiscUnderItemLine), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalSurcharge', '0.00', '', NewChildNode);

        if SalesCrMemoLine."Amount Including VAT" - SalesCrMemoLine.Amount <> 0 then
            XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalTax', CheckNumberFormat(FORMAT(-ABS(SalesCrMemoLine."Amount Including VAT" - SalesCrMemoLine.Amount), 0, '<Precision,2:2><Standard Format,2>')), '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode3, 'TotalTax', '0.00', '', NewChildNode);

        if Item.GET(SalesCrMemoLine."No.") and
           (Item."RPM Solution FND" <> Item."RPM Solution FND"::" ")
        then
            XMLDOMMgt.AddElement(XMLCurrNode3, 'IsReturnableEmpty', 'TRUE', '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode3, 'IsReturnableEmpty', 'FALSE', '', NewChildNode);
        //HEI.05<<

        //HEI.08>>
        CLEAR(NewChildNode);
        CLEAR(XMLCurrNode3);
        //HEI.08<<
    end;

    local procedure CheckNumberFormat(ValueToConvert: Text) ValueConverted: Text;
    var
        ValueConverted2: Text;
        DefaultDecimalSeparator: Text;
    begin
        //HEI.05>>
        //Send Amounts without thousands separator
        DefaultDecimalSeparator := COPYSTR(FORMAT(1 / 2), 2, 1);

        if DefaultDecimalSeparator = '.' then
            ValueConverted := DELCHR(ValueToConvert, '=', DELCHR(ValueToConvert, '=', '1234567890.-'))
        else if DefaultDecimalSeparator = ',' then begin
            ValueConverted2 := CONVERTSTR(ValueToConvert, ',', '.');
            ValueConverted := DELCHR(ValueConverted2, '=', DELCHR(ValueConverted2, '=', '1234567890.-'));
        end;
        //HEI.05<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDocument_CrLimit(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]);
    var
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //HEI.06>>
        if SalesHeader.ISTEMPORARY then
            exit;

        if not B2BInterfaceSetup.GET() then
            exit;

        if not B2BInterfaceSetup."Enable B2B Interfaces" then
            exit;

        if B2BInterfaceSetup."B2B Credit Limit Interface" = '' then
            exit;

        if not InterfaceSetup.GET(B2BInterfaceSetup."B2B Credit Limit Interface") then
            exit;

        if not InterfaceSetup.Enabled then
            exit;

        //Check B2B Customer Included Limit
        if (SalesInvHdrNo <> '') or (SalesCrMemoHdrNo <> '') then
            CheckB2BCustomerLimit(SalesHeader."Sell-to Customer No.");
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Table, 379, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertCustLedgerEntry_CrLimit(var Rec: Record "Detailed Cust. Ledg. Entry"; RunTrigger: Boolean);
    var
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //HEI.06>>
        if Rec.ISTEMPORARY then
            exit;

        if Rec."Document Type" <> Rec."Document Type"::Payment then
            exit;

        if Rec."Entry Type" <> Rec."Entry Type"::"Initial Entry" then
            exit;

        if not B2BInterfaceSetup.GET() then
            exit;

        if not B2BInterfaceSetup."Enable B2B Interfaces" then
            exit;

        if B2BInterfaceSetup."B2B Credit Limit Interface" = '' then
            exit;

        if not InterfaceSetup.GET(B2BInterfaceSetup."B2B Credit Limit Interface") then
            exit;

        if not InterfaceSetup.Enabled then
            exit;

        //Check B2B Customer Included Limit
        CheckB2BCustomerLimit(Rec."Customer No.");
        //HEI.06<<
    end;

    local procedure CheckB2BCustomerLimit(CustomerNo: Code[20]);
    var
        Customer: Record Customer;
        SellToCustomer: Record Customer;
        B2BCustomerIncludedExcluded: Record "B2B Cust Inc/Exc FND";
    begin
        //HEI.06>>
        Customer.GET(CustomerNo);
        if Customer."Bill-to Customer No." <> '' then begin
            SellToCustomer.GET(Customer."No.");
            B2BCustomerIncludedExcluded.SETRANGE(Included, true);
            B2BCustomerIncludedExcluded.SETRANGE(Code, SellToCustomer."Bill-to Customer No.");
            if B2BCustomerIncludedExcluded.FINDFIRST() then
                CreateAndSendCreditLimitXML(SellToCustomer."No.");
        end else begin
            SellToCustomer.SETRANGE("Bill-to Customer No.", Customer."No.");
            if SellToCustomer.FINDSET() then begin
                B2BCustomerIncludedExcluded.SETRANGE(Included, true);
                B2BCustomerIncludedExcluded.SETRANGE(Code, SellToCustomer."Bill-to Customer No.");
                if B2BCustomerIncludedExcluded.FINDFIRST() then
                    repeat
                        CreateAndSendCreditLimitXML(SellToCustomer."No.");
                    until SellToCustomer.NEXT() = 0;
            end;
        end;
        //HEI.06<<
    end;

    local procedure CreateAndSendCreditLimitXML(CustomerNo: Code[20]);
    var
        InterfaceSetup: Record "Interface Setup INT";
        IntegrationFrameworkLog: Record "Integration Framework Log INT";
        IntegrationFrameworkLog2: Record "Integration Framework Log INT";
        //BC Upgrade GUNREM01 replaced var >>
        // XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        XMLDoc: XmlDocument;
        XMLCurrNode: XmlNode;
        XMLCurrNode2: XmlNode;
        RespBlob: Codeunit "Temp Blob";
        RespIn: InStream;
        RespOut: OutStream;
        RespText: Text;
        Request: BigText;

        //BC Upgrade GUNREM01 replaced var <<
        OutputStream: OutStream;
        Customer: Record Customer;
        TempBigText: BigText;
    begin
        //HEI.06>>
        InterfaceSetup.GET(B2BInterfaceSetup."B2B Credit Limit Interface");

        //Insert in Integration Framework Log
        IntegrationFrameworkLog.INIT();
        if IntegrationFrameworkLog2.FINDLAST() then
            IntegrationFrameworkLog."Entry No" := IntegrationFrameworkLog2."Entry No" + 1;
        IntegrationFrameworkLog."Interface Code" := B2BInterfaceSetup."B2B Credit Limit Interface";
        IntegrationFrameworkLog."Request Sync. Date/Time" := CURRENTDATETIME;
        IntegrationFrameworkLog."Call Type" := InterfaceSetup."Call Type";
        IntegrationFrameworkLog.INSERT(true);

        //Create XML Signature
        CreateResponseXMLMsg(XMLDoc, XMLCurrNode, 'CreditLimitPayload');

        //Create XML Message
        Customer.GET(CustomerNo);
        CreateCreditLimitMsg(XMLDoc, XMLCurrNode, XMLCurrNode2, Customer);

        //Update Integration Framework Log
        IntegrationFrameworkLog.CALCFIELDS("Response File");
        IntegrationFrameworkLog."Response File".CREATEOUTSTREAM(OutputStream, TextEncoding::UTF8); // SHUKLP03 <<
        IntegrationFrameworkLog."Response Date/Time" := CURRENTDATETIME;

        //HEI.07>>
        // SHUKLP03 >>
        //XMLDoc.Save(OutputStream);
        // TempBigText.ADDTEXT(XMLDoc.InnerXml);
        // TempBigText.WRITE(OutputStream);
        // CLEAR(TempBigText);
        // RespBlob.CreateOutStream(RespOut, TextEncoding::UTF8);
        // XMLDoc.WriteTo(RespOut);
        // RespBlob.CreateInStream(RespIn, TextEncoding::UTF8);
        // RespIn.ReadText(RespText);
        // Request.AddText(RespText);
        XMLDoc.WriteTo(OutputStream);
        // SHUKLP03 <<

        //HEI.07<<

        IntegrationFrameworkLog."Source No." := Customer."No.";
        IntegrationFrameworkLog.MODIFY(true);

        //Send XML message
        IntegrationFrameworkLog.SendMessage();
        //HEI.06<<

        //HEI.08>>
        CLEAR(XMLDoc);
        CLEAR(XMLCurrNode);
        CLEAR(XMLCurrNode2);
        //HEI.08<<
        CLEAR(OutputStream); //HEI.09
    end;

    // local procedure CreateCreditLimitMsg(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; var XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; Customer: Record Customer);
    local procedure CreateCreditLimitMsg(var XMLDoc: XmlDocument; var XMLCurrNode: XmlNode; var XMLCurrNode2: XmlNode; Customer: Record Customer);

    var
        XMLDOMMgt: Codeunit "XML DOM Management";
        //BC Upgrade GUNREM01 >>
        // NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        NewChildNode: XmlNode;
        XMLElem: XmlElement;
        //BC Upgrade GUNREM01 <<
        BillToCustomer: Record Customer;
        CreditAmount: Decimal;
        BalanceAmount: Decimal;
        PaymentTerms: Record "Payment Terms";
    begin
        //HEI.06>>
        if Customer."Bill-to Customer No." <> '' then
            BillToCustomer.GET(Customer."Bill-to Customer No.")
        else
            BillToCustomer.GET(Customer."No.");
        BillToCustomer.CALCFIELDS("Balance (LCY)");
        //BC Upgrade GUNREM01 >>
        // XMLCurrNode2 := XMLDoc.CreateElement('CreditLimit');
        // XMLCurrNode.AppendChild(XMLCurrNode2);

        // SHUKLP03 >>
        // XMLDoc := XmlDocument.Create();
        // XMLElem := XmlElement.Create('CreditLimit');
        // XMLDoc.Add(XMLElem);

        XMLElem := XmlElement.Create('CreditLimit');
        XMLCurrNode2 := XMLElem.AsXmlNode();
        XMLCurrNode.AsXmlElement().Add(XMLCurrNode2);
        // SHUKLP03 <<

        //BC Upgrade GUNREM01 <<
        XMLDOMMgt.AddElement(XMLCurrNode2, 'Tenant', UPPERCASE(TENANTID()), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'Company', UPPERCASE(COMPANYNAME), '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'OutletID', Customer."No.", '', NewChildNode);

        CreditAmount := BillToCustomer."Credit Limit (LCY)" - BillToCustomer."Balance (LCY)";
        XMLDOMMgt.AddElement(XMLCurrNode2, 'CreditAmount', CheckNumberFormat(FORMAT(CreditAmount)), '', NewChildNode);

        if (Customer.Blocked = Customer.Blocked::Ship) or
           (Customer.Blocked = Customer.Blocked::All)
        then
            XMLDOMMgt.AddElement(XMLCurrNode2, 'BlockReason', Customer."Blocked Reason Code FND", '', NewChildNode)
        else
            XMLDOMMgt.AddElement(XMLCurrNode2, 'BlockReason', '', '', NewChildNode);

        if BillToCustomer."Payment Terms Code" <> '' then
            PaymentTerms.GET(BillToCustomer."Payment Terms Code");
        XMLDOMMgt.AddElement(XMLCurrNode2, 'CreditTerms', PaymentTerms.Description, '', NewChildNode);
        XMLDOMMgt.AddElement(XMLCurrNode2, 'OutstandingAmount', CheckNumberFormat(FORMAT(BillToCustomer."Balance (LCY)")), '', NewChildNode);
        //HEI.06>>

        CLEAR(NewChildNode); //HEI.08
    end;

    local procedure CheckB2BUOM(ItemNo: Code[20]; UnitOfMeasure: Code[10]): Boolean;
    begin
        //HEI.10>>
        B2BItemUnitsofMeasure.RESET();
        if B2BItemUnitsofMeasure.ISEMPTY then
            exit(true)
        else begin
            B2BItemUnitsofMeasure.SETRANGE("Item No.", ItemNo);
            B2BItemUnitsofMeasure.SETRANGE(Code, UnitOfMeasure);
            if B2BItemUnitsofMeasure.FINDFIRST() then
                exit(B2BItemUnitsofMeasure."B2B UOM");
        end;
        //HEI.10<<
    end;

    procedure SetRunDate(RunningDate: Date);
    begin
        //HEI.12
        RunDate := RunningDate;
    end;
}

