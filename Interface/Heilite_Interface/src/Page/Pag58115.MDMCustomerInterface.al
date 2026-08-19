page 58115 "MDM Customer Interface"
{
    // version HEI.14

    // HEI.01 IBM HORTOC01 # filter page by account group SORTING(No.) WHERE(Account Group=FILTER(<>Y008&<>Y009))
    // HEI.02 IBM NASTAA02 # New Fields added
    // HEI.03 IBM BULIMC01 14/10/2019 # New Field added "Classification"
    // HEI.04 FDD-HT BULIMC01 IBM 18.11.2019 #New Field added "Contract Type"
    // HEI.05 IBM NASTAA02 # "Reserve" and "Shipping Advice" should be shown as integer values
    // HEI.06 CHG2034524 FDD-HT788 IBM GAVANM01 25.02.2020 # New field added: Search
    // HEI.07 CHG2068464 IBM.GAVANM01 23.07.2020 Intercompany billing
    //   # New global variable SendDocument2
    //   # New fields added in the page: "Purchasing code" and "SendDocument2"
    // HEI.08 CHG2073953 IBM.GAVANM01 16.09.2020 Interface fields geo coordinates and delivery windows
    //   # New fields added: Latitude Coordinates, Longitude Coordinates
    //   # new part page added: MDM Customer Delivery Times
    // HEI.09 CHG2099832 HB2080 IBM.GAVANM01 05.03.2021 #Add Customer Tax Group field to Mendix-Heilite Interface
    //   # New field added: Customer DTax Group Code
    // HEI.10 CHG2129700 INC3758798 IBM GAVANM01 06.10.2021 #SEM ID is not available for Mendix
    //   # New field added: SEM Id
    // HEI.11 CHG2132219 HB2607 IBM GAVANM01 25.01.2022 #Customer Creation Integration with Mendix (SEPA)
    //   # new part page added: MDM SEPA Direct Debit Mandate
    // HEI.13 CHG2178940 IBM COSTES04 16.01.2023 #Add "Required Freshness" field to Mendix-Heilite Interface
    //   # New field added: Required Freshness
    // HEI.12 CHG2154294 HB2899 IBM BHANDS01 02.06.2022 #Add "Trading End Date" field to Mendix-Heilite Interface
    //   # New field added: "Trading End Date"
    // HEI.14 CHG2154294 HB2899 IBM BHANDS01 29.03.2023 #Add "Trading End Date" field to Mendix-Heilite Interface
    //   # Replacing Record field "Trading End Date" with Global Variable TradingEndDate for blank date issue

    //BC Upgrade PATELP08 >>
    // #Old object id-50215
    // #new object id-58115
    // Blocked some part of code of trigger OnAfterGetRecord because dependency on drink it fields.
    // Blocked the drink it fields
    // in fields added Rec. before field name as per new syntax change in BC upgrade
    // added application area
    // Blocking "MDM Customer Delivery Times" page as the table - (2014083)Delivery time(DITW18.00.07) is a Drink it.
    //BC Upgrade PATELP08 <<

    Caption = 'Customer';
    Editable = false;
    PageType = Document;
    SourceTable = Customer;
    SourceTableView = SORTING("No.")
                      WHERE("Account Group FND" = FILTER('<>Y008&<>Y009'));

    //BC Upgrade PATELP08 >> added application area and usage category
    ApplicationArea = All;
    //BC Upgrade PATELP08 <<
    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Account Group FND"; Rec."Account Group FND")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Search Name"; Rec."Search Name")
                {
                }
                field(Search; Rec."Search FND")
                {
                }
                field("Search 2"; Rec."Search 2 FND")
                {
                }
                field("Name 2"; Rec."Name 2")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field(City; Rec.City)
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                {
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
                field(Blocked; Blocked2)
                {
                    Caption = 'Blocked';
                }
                field(County; Rec.County)
                {
                }
                field("Service Zone Code"; Rec."Service Zone Code")
                {
                }
                // BC Upgrade PATELP08 >> Drink It Fields- "Credit Limit","Customer Template Code"
                // field("Credit Limit"; "Credit Limit")
                // {
                // }
                // field("Customer Template Code";Rec."Customer Template Code")
                // {
                // }
                // BC Upgrade PATELP08 <<

                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                }

                //BC Upgrade PATELP08 >> Drink It Fields - "Loan Interest Cust. Post. Grp.","Customer DDeposit Group Code","Contract Cust. Post. Gr. Other","Contract Cust. Post. Gr. Rent","Contract Cust. Post. Gr. Maint","Contract Cust. Post. Gr. Loan", "Contract Cust. Post. Gr. LoanU","Contract Cust. Post. Gr. Plant"
                // field("Customer DDeposit Group Code";Rec."Customer DDeposit Group Code")
                // {
                // } 
                // field("Contract Cust. Post. Gr. Rent";Rec."Contract Cust. Post. Gr. Rent")
                // {
                // } 
                // field("Contract Cust. Post. Gr. Loan";Rec."Contract Cust. Post. Gr. Loan")
                // {
                // } 
                // field("Contract Cust. Post. Gr. LoanU";Rec."Contract Cust. Post. Gr. LoanU")
                // {
                // } 
                // field("Contract Cust. Post. Gr. Maint";Rec."Contract Cust. Post. Gr. Maint")
                // {
                // }
                // field("Contract Cust. Post. Gr. Other";Rec."Contract Cust. Post. Gr. Other")
                // {
                // }
                // field("Contract Cust. Post. Gr. Plant";Rec."Contract Cust. Post. Gr. Plant")
                // {
                // }
                // field("Loan Interest Cust. Post. Grp.";Rec."Loan Interest Cust. Post. Grp.")
                // {
                // }
                // BC Upgrade PATELP08 <<

                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Fax No."; Rec."Fax No.")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                }
                field("Invoice Copies"; Rec."Invoice Copies")
                {
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                }
                field(GLN; Rec.GLN)
                {
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                }
                field("Risk Category"; Rec."Risk Category FND")
                {
                }
                //  BC Upgrade PATELP08 >> Drink it field
                // field("Free Item";Rec."Free Item")
                // {
                // }
                //  BC Upgrade PATELP08 <<
                field("Return Order Mandatory"; Rec."Return Order Mandatory FND")
                {
                }
                field("Invoice Method"; InvoiceMethod)
                {
                    Caption = 'Invoice Method';
                }
                field("Invoice Period"; InvoicePeriod)
                {
                    Caption = 'Invoice Period';
                }
                field("Empty Goods Statement On"; EmptyGoodsStatementOn)
                {
                    Caption = 'Empty Goods Statement On';
                }
                field("Ext. Doc. No. Mandatory"; ExtDocNoMandatory)
                {
                    Caption = 'Ext. Doc. No. Mandatory';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                }
                field("Fin. Charge Terms Code"; Rec."Fin. Charge Terms Code")
                {
                }
                field("Last Statement No."; Rec."Last Statement No.")
                {
                }
                field("Print Statements"; Rec."Print Statements")
                {
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                }
                field("Application Method"; ApplicationMethod)
                {
                    Caption = 'Application Method';
                }
                field("Reminder Terms Code"; Rec."Reminder Terms Code")
                {
                }
                field("Block Payment Tolerance"; Rec."Block Payment Tolerance")
                {
                }
                field("Partner Type"; PartnerType)
                {
                    Caption = 'Partner Type';
                }
                field("Preferred Bank Account Code"; Rec."Preferred Bank Account Code")
                {
                }
                field("Cash Flow Payment Terms Code"; Rec."Cash Flow Payment Terms Code")
                {
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Language Code"; Rec."Language Code")
                {
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                }
                //  BC Upgrade PATELP08 >> Drink it field
                // field("Split Deposit on Invoice";Rec."Split Deposit on Invoice")
                // {
                // }
                //  BC Upgrade PATELP08 <<
                //  BC Upgrade KUMARR78 >> 22-06-2026
                field("Split Deposit on Invoice"; Rec."Is Split EGM Cust. 104FDW")
                {

                }
                //  BC Upgrade KUMARR78 << 22-06-2026

                field("Autom. Item Charge"; AutomItemCharge)
                {
                    Caption = 'Autom. Item Charge';
                }
                //  BC Upgrade PATELP08 >> Drink it fields -"Tax Registration No.","Fiscal Representative No.","Gen. Bus. Posting Free Group"
                // field("Tax Registration No.";Rec."Tax Registration No.")
                // {
                // }
                // field("Fiscal Representative No.";Rec."Fiscal Representative No.")
                // {
                // }
                // field("Gen. Bus. Posting Free Group";Rec."Gen. Bus. Posting Free Group")
                // {
                // }
                //  BC Upgrade PATELP08 <<
                //BC UPGRADE KUMARR78 >> 22-06-2026
                field("Tax Registration No. 113FDW"; Rec."Tax Registration No. 113FDW")
                {

                }
                field("Fiscal Rep. No. 113FDW"; Rec."Fiscal Rep. No. 113FDW")
                {

                }

                //BC UPGRADE KUMARR78 << 22-06-2026
                field("Free Item Posting Type"; FreeItemPostingType)
                {
                    Caption = 'Free Item Posting Type';
                }
                //  BC Upgrade PATELP08 >> Drink it fields - "Free Reason Code",Exclusivity
                // field("Free Reason Code";Rec."Free Reason Code")
                // {
                // }
                // field(Exclusivity;Rec.Exclusivity)
                // {
                // }
                //  BC Upgrade PATELP08 <<
                //BC UPGRADE KUMARR78 >> 22-06-2026
                field("Exclusivity Cust. 106FDW"; Rec."Exclusivity Cust. 106FDW")
                {

                }
                //BC UPGRADE KUMARR78 << 22-06-2026

                field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
                {
                }
                //  BC Upgrade PATELP08 >> Drink it fields -"Shortcut Property 1 Code","Shortcut Property 2 Code"
                // field("Shortcut Property 1 Code";Rec."Shortcut Property 1 Code")
                // {
                // }
                // field("Shortcut Property 2 Code";Rec."Shortcut Property 2 Code")
                // {
                // }
                //  BC Upgrade PATELP08 <<
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    CaptionML = ENU = 'Shortcut Dimension 1 Code',
                                FRA = 'Code axe principal 1';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    CaptionML = ENU = 'Shortcut Dimension 2 Code',
                                FRA = 'Code axe principal 2';
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                }
                field("Approval Of Alcohol"; Rec."Approval Of Alcohol FND")
                {
                }
                field("Blocked Reason Code"; Rec."Blocked Reason Code FND")
                {
                }
                field("Risk Score"; Rec."Risk Score FND")
                {
                }
                field("RPM Exposure"; Rec."RPM Exposure FND")
                {
                }
                field("FFE Security Amount"; Rec."FFE Security Amount FND")
                {
                }
                field("Interest Rate Credit Amount"; Rec."Interest Rate Credit Amt FND")
                {
                }
                field("Packaging Credit Value (PCV)"; Rec."Packaging Credit Value PCV FND")
                {
                }
                field("Check FFE Bal/FFE security Amt"; Rec."Check Bal/FFE security Amt FND")
                {
                }
                field("Additional RPM Return"; Rec."Additional RPM Return FND")
                {
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                }
                field("Combine Shipments"; Rec."Combine Shipments")
                {
                }
                field(Reserve; Reserve2)
                {
                    Description = 'HEI.05';
                }
                field("Shipping Advice"; ShippingAdvice)
                {
                    Description = 'HEI.05';
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                }
                field("Truck Zone"; TruckZone)
                {
                }
                //  BC Upgrade PATELP08 >> Drink it fields -"Shipment Date Formula","Require 2 Drivers","Delivery Sequence", "Delivery Note Copies","Customer Delivery Type", Distance, route
                // field("Shipment Date Formula";Rec."Shipment Date Formula")
                // {
                // }
                // field("Require 2 Drivers";Rec."Require 2 Drivers")
                // {
                // }
                // field("Customer Delivery Type";Rec."Customer Delivery Type")
                // {
                // }
                // field(Distance;Rec.Distance)
                // {
                // }
                // field(Route;Rec.Route)
                // {
                // }
                // field("Delivery Note Copies";Rec."Delivery Note Copies")
                // {
                // }
                // field("Delivery Sequence";Rec."Delivery Sequence")
                // {
                // }
                //  BC Upgrade PATELP08 <<
                //  BC UPGRADE KUMARR78 >>22-06-2026
                field("Two Drivers Req. 107FDW"; Rec."Two Drivers Req. 107FDW")
                {

                }
                field("Default Route 107FDW"; Rec."Default Route 107FDW")
                {

                }
                //  BC UPGRADE KUMARR78 >> 22-06-2026
                field("Picking Type"; PickingType)
                {
                }
                field("Empty Returned Items Based On"; EmptyReturnItemBasedOn)
                {
                    Caption = 'Empty Returned Items Based On';
                }
                field("Sales Routes"; Rec."Sales Routes FND")
                {
                }
                field(Contact; Rec.Contact)
                {
                }
                //  BC Upgrade PATELP08 >> Drink it field
                // field("Purchasing Code";Rec."Purchasing Code")
                // {
                // }
                //  BC Upgrade PATELP08 <<
                field(SendDocument; SendDocument2)
                {
                    CaptionML = ENU = 'Send Document',
                                FRA = 'Envoyer Document';
                }
                field("Longitude Coordinate"; Rec."Longitude Coordinate FND")
                {
                }
                field("Latitude Coordinate"; Rec."Latitude Coordinate FND")
                {
                }
                //  BC Upgrade PATELP08 >> Drink it field
                // field("Customer Tax Group Code";Rec."Customer DTax Group Code")
                // {
                // }
                //  BC Upgrade PATELP08 <<
                //  BC UPGARDE KUMARR78 >> 22-06-2026
                field("Default Class. 102FDW"; Rec."Default Class. 102FDW")
                {

                }
                //  BC UPGARDE KUMARR78 << 22-06-2026
                field("SEM Id"; Rec."SEM Id FND")
                {
                }
                field("Trading End Date"; TradingEndDate)
                {
                    Caption = 'Trading End Date';
                }
                field("Required Freshness"; Rec."Required Freshness FND")
                {
                }
                field("CustomerAttributes.""Strategic Indicator"""; CustomerAttributes."Strategic Indicator")
                {
                }
                field("CustomerAttributes.""Local key Account"""; CustomerAttributes."Local key Account")
                {
                }
                field("CustomerAttributes.""Different City"""; CustomerAttributes."Different City")
                {
                }
                field("CustomerAttributes.District"; CustomerAttributes.District)
                {
                }
                field(HouseNo; Rec."House No. FND")
                {
                    Caption = 'House Number';
                }
                field("House Supplement 2"; Rec."House Supplement 2 FND")
                {
                    Caption = 'House Number Supplement';
                }
                field("CustomerAttributes.""Name 3"""; CustomerAttributes."Name 3")
                {
                    Caption = 'Name 3';
                }
                field("CustomerAttributes.""Name 4"""; CustomerAttributes."Name 4")
                {
                    Caption = 'Name 4';
                }
                field("Street 3"; Rec."Street 3 FND")
                {
                    Caption = 'Street';
                }
                field("Street 4"; Rec."Street 4 FND")
                {
                }
                field("Street 5"; Rec."Street 5 FND")
                {
                }
                field("CustomerAttributes.""Flag for Deletion"""; CustomerAttributes."Flag for Deletion")
                {
                }
                field("CustomerAttributes.""C/O Name"""; CustomerAttributes."C/O Name")
                {
                }
                field("CustomerAttributes.""Company Postal Code"""; CustomerAttributes."Company Postal Code")
                {
                }
                field("CustomerAttributes.""No. of Delivery Service"""; CustomerAttributes."No. of Delivery Service")
                {
                }
                field("CustomerAttributes.""Other City"""; CustomerAttributes."Other City")
                {
                }
                field("CustomerAttributes.""Other Region"""; CustomerAttributes."Other Region")
                {
                }
                field("CustomerAttributes.""Other Country"""; CustomerAttributes."Other Country")
                {
                }
                field("P.O.Box"; Rec."P.O.Box FND")
                {
                    Caption = 'PO Box Number';
                }
                field("CustomerAttributes.""P.O.Box Postal Code"""; CustomerAttributes."P.O.Box Postal Code")
                {
                }
                field("CustomerAttributes.""P.O.Box w/0 No."""; CustomerAttributes."P.O.Box w/0 No.")
                {
                }
                field("CustomerAttributes.""Type of Delivery Service"""; CustomerAttributes."Type of Delivery Service")
                {
                }
                field("Tax Number 1"; Rec."Tax Number 1 FND")
                {
                    Caption = 'Tax Number1';
                }
                field("Tax Number 2"; Rec."Tax Number 2 FND")
                {
                    Caption = 'Tax Number2';
                }
                field("Tax Number 3"; Rec."Tax Number 3 FND")
                {
                    Caption = 'Tax Number3';
                }
                field("Tax Number 4"; Rec."Tax Number 4 FND")
                {
                    Caption = 'Tax Number4';
                }
                field("CustomerAttributes.""Invoice Email Address"""; CustomerAttributes."Invoice Email Address")
                {
                }
                field("CustomerAttributes.""Legal Form"""; CustomerAttributes."Legal Form")
                {
                }
                field("CustomerAttributes.""License Type"""; CustomerAttributes."License Type")
                {
                }
                field("CustomerAttributes.""License No."""; CustomerAttributes."License No.")
                {
                }
                field("CustomerAttributes.""Business Segment"""; CustomerAttributes."Business Segment")
                {
                }
                field("CustomerAttributes.""Business OrganizationalSegment"""; CustomerAttributes."Business OrganizationalSegment")
                {
                }
                field("CustomerAttributes.""Customer Type"""; CustomerAttributes."Customer Type")
                {
                }
                field("CustomerAttributes.""Customer Sub-Type"""; CustomerAttributes."Customer Sub-Type")
                {
                }
                field("CustomerAttributes.""Local Customer Sub-Type"""; CustomerAttributes."Local Customer Sub-Type")
                {
                }
                field("CustomerAttributes.""Market Type"""; CustomerAttributes."Market Type")
                {
                }
                field("CustomerAttributes.""Registre de Commerce"""; CustomerAttributes."Registre de Commerce")
                {
                }
                field("CustomerAttributes.""Article d'imposition"""; CustomerAttributes."Article d'imposition")
                {
                }
                field("CustomerAttributes.""N.I.S."""; CustomerAttributes."N.I.S.")
                {
                }
                field("CustomerAttributes.NIF"; CustomerAttributes.NIF)
                {
                }
                field("CustomerAttributes.""Visit day"""; CustomerAttributes."Visit day")
                {
                }
                field("Trading Partner"; Rec."Trading Partner FND")
                {
                }
                field("Flag for Deletion"; Rec."Flag for Deletion FND")
                {
                }
                field("Vendor No."; Rec."Vendor No. FND")
                {
                }
                //  BC Upgrade PATELP08 >> Drink it field
                // field("Deposit Limit";Rec."Deposit Limit")
                // {
                //     Description = 'HEI.02';
                // }
                // field("Deposit Limit (LCY)";Rec."Deposit Limit (LCY)")
                // {
                // }
                //  BC Upgrade PATELP08 <<
                field("Payment Valid From"; PaymentValidFrom)
                {
                    Caption = 'Payment Valid From';
                    Description = 'HEI.02';
                }
                field("Payment Valid To"; PaymentValidTo)
                {
                    Caption = 'Payment Valid To';
                    Description = 'HEI.02';
                }
                field("License Valid From"; LicenseValidFrom)
                {
                    Caption = 'License Valid From';
                    Description = 'HEI.02';
                }
                field("License Valid To"; LicenseValidTo)
                {
                    Caption = 'License Valid To';
                    Description = 'HEI.02';
                }
                field(Classification; CustomerAttributes.Classification)
                {
                }
                field(ContractType; ContractType)
                {
                }
                part(Control55147; "MDM Cust. Bank Acc. Interface")
                {
                    Editable = false;
                    SubPageLink = "Customer No." = FIELD("No.");
                }
                //  BC Upgrade PATELP08 >> Blocking "MDM Customer Delivery Times" page as the table - (2014083)Delivery time(DITW18.00.07) is a Drink it.
                // part(Control55168; "MDM Customer Delivery Times")
                // {
                //     Editable = false;
                //     SubPageLink = "No." = FIELD("No."),
                //                   "Source Type" = CONST(Customer);
                // }
                // BC Upgrade PATELP08 <<
                //BC UPGRADE KUMARR78 << 22-06-2026
                part("MDM Customer Delivery Times"; DeliveryTimes107FDW)
                {
                    Editable = false;
                    SubPageLink = "Source Code" = FIELD("No."),
                                  "Source Type" = CONST(Customer);
                }
                //BC UPGRADE KUMARR78 >> 22-06-2026
                part(Control55170; "MDM SEPA Direct Debit Mandate")
                {
                    Description = 'HEI.11';
                    Editable = false;
                    SubPageLink = "Customer No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        if CustomerAttributes.GET(Rec."No.") then;
        //  BC Upgrade PATELP08 >> Blocking these fields -> Drink it seires
        // InvoiceMethod := "Invoice Method";
        // InvoicePeriod := "Invoice Period";
        // EmptyGoodsStatementOn := "Empty Goods Statement On";
        // ExtDocNoMandatory := "Ext. Doc. No. Mandatory";
        //  BC Upgrade PATELP08 <<
        //BC UPGRADE KUMARR78 >> 22-06-2026
        InvoicePeriod := Rec."Invoice Period 101FDW";
        EmptyGoodsStatementOn := Rec."Statement On 104FDW";
        ExtDocNoMandatory := Rec."Ext.Doc. No. mand. 106FDW";
        //BC UPGRADE KUMARR78 << 22-06-2026

        //  BC Upgrade PATELP08 >> add Rec. before field name as per new syntax change in BC upgrade
        ApplicationMethod := Rec."Application Method".AsInteger();
        PartnerType := Rec."Partner Type".AsInteger();
        //  BC Upgrade PATELP08 <<

        //  BC Upgrade PATELP08 >> Blocking these fields -> Drink it seires
        //AutomItemCharge := "Autom. Item Charge";
        //FreeItemPostingType := "Free Item Posting Type";
        //Blocked2 := Blocked;
        //EmptyReturnItemBasedOn := "Empty Returned Items Based On";
        //PickingType := "Picking Type";
        //TruckZone := "Truck Zone";
        //ContractType := "Contract Type"; //HEI.04
        //  BC Upgrade PATELP08 << 
        //BC UPGRADE KUMARR78 << 22-06-2026
        Blocked2 := Rec.Blocked;
        PickingType := Rec.PickMethodCode75FDW;
        ContractType := Rec."Contract Type FND"; //HEI.04
        //BC UPGRADE KUMARR78 >> 22-06-2026
        //HEI.05>>
        //  BC Upgrade PATELP08 >> add Rec. before field name as per new syntax change in BC upgrade
        Reserve2 := Rec.Reserve.AsInteger();
        ShippingAdvice := Rec."Shipping Advice".AsInteger();
        //HEI.05<<
        //  BC Upgrade PATELP08 <<

        //  BC Upgrade PATELP08 >> Blocking these fields -> Drink it seires
        SendDocument2 := Rec."Send Document FND";  //HEI.07 // BC Upgrade SHUKLP03 << OTC008 Testscript
        //  BC Upgrade PATELP08 << 

        //HEI.02>>
        if CustomerAttributes."Payment valid from" = 0D then
            PaymentValidFrom := ''
        else
            PaymentValidFrom := FORMAT(CustomerAttributes."Payment valid from", 0, '<Month,2>/<DAY,2>/<Year4>');

        if CustomerAttributes."Payment valid to" = 0D then
            PaymentValidTo := ''
        else
            PaymentValidTo := FORMAT(CustomerAttributes."Payment valid to", 0, '<Month,2>/<DAY,2>/<Year4>');

        if CustomerAttributes."License Valid from" = 0D then
            LicenseValidFrom := ''
        else
            LicenseValidFrom := FORMAT(CustomerAttributes."License Valid from", 0, '<Month,2>/<DAY,2>/<Year4>');

        if CustomerAttributes."License Valid to" = 0D then
            LicenseValidTo := ''
        else
            LicenseValidTo := FORMAT(CustomerAttributes."License Valid to", 0, '<Month,2>/<DAY,2>/<Year4>');
        //HEI.02<<

        //HEI.14>>
        if Rec."Trading End Date FND" = 0D then
            TradingEndDate := ''
        else
            TradingEndDate := FORMAT(Rec."Trading End Date FND", 0, '<Month,2>/<DAY,2>/<Year4>');
        //HEI.14<<
    end;

    var
        CustomerAttributes: Record "Customer Attributes FND";
        InvoiceMethod: Integer;
        InvoicePeriod: Integer;
        EmptyGoodsStatementOn: Integer;
        ExtDocNoMandatory: Integer;
        ApplicationMethod: Integer;
        PartnerType: Integer;
        AutomItemCharge: Integer;
        FreeItemPostingType: Integer;
        Blocked2: Integer;
        EmptyReturnItemBasedOn: Integer;
        // PickingType: Integer; //BC UPGRADE KUMARR78 22-06-2026 Comment
        PickingType: Code[10];//BC UPGRADE KUMARR78 22-06-2026 Comment
        TruckZone: Integer;
        ContractType: Integer;
        Reserve2: Integer;
        ShippingAdvice: Integer;
        PaymentValidFrom: Text;
        PaymentValidTo: Text;
        LicenseValidFrom: Text;
        LicenseValidTo: Text;
        SendDocument2: Integer;
        TradingEndDate: Text;
}

