report 51008 "Month End Sales Cut off CBN"
{
    // version HEI.02 IBM

    // HEI.01 FDD-RTRGAP048- Month-end Sales Cut off , IBM.NAIKH01 19.08.2017
    // # Created a  new report
    // 
    // HEI.02 Month-end Sales Cut off , IBM.IPO 31.10.2017
    // # Reason : Defect #711 Filtering report on Request page for web client was not visible
    // # Action : Add 3 fields (No., Posting Date, Order Date) on ReqFilterFields on DataItem Sales Header properties
    // BC Upgrade BHARDA11 >>
    // 1. Add layout path and change layout extension rdlc to rdl.
    // 2. Remove Drink-IT Field ("Amount Including VAT",Amount).
    // 3  Add ApplicationArea in Report .
    // BC Upgrade BHARDA11 <<

    //BC Upgrade KAPOOV01: PID# PID-443 Updated source expression for Column- Amount to replace Drink-IT field->"Sales Shipment Header".Amount.
    //BC Upgrade KAPOOV01: PID# PID-443 Added code for VATAmount Calculation to replace Drink-IT field->"Sales Shipment Header"."Amount Including VAT".
    //BC Upgrade YADAVM09 BCUP0-35.

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Month End Sales Cut off.rdl'; // BC Upgrade BHARDA11 ---Add Path and change extension rdlc to rdl
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Posting Date", "Order Date";
            dataitem("Sales Shipment Header"; "Sales Shipment Header")
            {
                DataItemLink = "Order No." = FIELD("No.");
                column(Cust_No; "Sales Shipment Header"."Sell-to Customer No.")
                {
                }
                column(Doc_No; "Sales Shipment Header"."No.")
                {
                }
                column(Curr_Code; "Sales Shipment Header"."Currency Code")
                {
                }
                column(Doc_Date; FORMAT("Sales Shipment Header"."Document Date"))
                {
                }
                column(Order_Date; FORMAT("Sales Shipment Header"."Order Date"))
                {
                }
                column(PaymentMethodCode; "Sales Shipment Header"."Shipment Method Code")
                {
                }
                column(ShipmentDate_SalesInvoiceHeader; FORMAT("Sales Shipment Header"."Shipment Date"))
                {
                }
                // column(Amount; "Sales Shipment Header".Amount) // BC Upgrade BHARDA11 ---Drink-IT Field(Amount)
                // {
                // }
                column(BaseAmount; BaseAmount) // BC Upgrade KAPOOV01 Replaced Drink-IT Field-> "Sales Shipment Header".Amount by BaseAmount. 
                {
                }
                column(VAT_Amount; VATAmount)
                {
                }
                column(Comp_Name; CompanyInformation.Name)
                {
                }
                column(UserID; USERID)
                {
                }
                column(TODAY; TODAY)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Amount Including VAT",Amount)
                    // "Sales Shipment Header".CALCFIELDS("Sales Shipment Header"."Amount Including VAT", "Sales Shipment Header".Amount);
                    // VATAmount := ("Sales Shipment Header"."Amount Including VAT") - ("Sales Shipment Header".Amount);
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields("Amount Including VAT",Amount)

                    // BC Upgrade KAPOOV01 Added code for VATAmount Calculation to replace Drink-IT field->"Sales Shipment Header"."Amount Including VAT" >>

                    BaseAmount := 0;
                    VATAmount := 0;

                    SalesShipmentLine.Reset();
                    SalesShipmentLine.SetRange("Document No.", "No.");
                    SalesShipmentLine.SetRange(Type, SalesShipmentLine.type::Item);//BC Upgrade YADAVM09 BCUP0-35<<
                    if SalesShipmentLine.FindSet() then begin
                        repeat
                            clear(LineAmount);
                            LineAmount := SalesShipmentLine."Unit Price" * SalesShipmentLine.Quantity;

                            BaseAmount += LineAmount;
                            VATAmount += (SalesShipmentLine."VAT %" / 100) * LineAmount;
                        until SalesShipmentLine.Next() = 0;

                    end;
                    // BC Upgrade KAPOOV01 Added code for VATAmount Calculation to replace Drink-IT field->"Sales Shipment Header"."Amount Including VAT" <<
                end;

            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        CompanyInformation.GET;
    end;

    var
        CompanyInformation: Record "Company Information";
        VATAmount: Decimal;
        BaseAmount: Decimal; // BC Upgrade KAPOOV01
        SalesShipmentLine: Record "Sales Shipment Line"; // BC Upgrade KAPOOV01
        LineAmount: Decimal; // BC Upgrade KAPOOV01
}

