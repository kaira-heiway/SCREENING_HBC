xmlport 58013 "Check Cust. Duplicates Result"
{
    // Heilite Navision Old Id - 50048
    // HEI.01 FDD-SLSGAP020 IBM HORTOC01 #new xmlport - customer mendix interface

    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/Result';
    UseDefaultNamespace = true;
    UseRequestPage = false;

    schema
    {
        textelement(webCheckCustomerResult)
        {
            MaxOccurs = Once;
            MinOccurs = Zero;
            tableelement(Customer; Customer)
            {
                MaxOccurs = Unbounded;
                MinOccurs = Zero;
                XmlName = 'Customer';
                fieldelement(No; Customer."No.")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(Name1; Customer.Name)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(Address; Customer.Address)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(Address2; Customer."Address 2")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(City; Customer.City)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(VatRegNo; Customer."VAT Registration No.")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Distance)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Matching)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                tableelement("Customer Attributes FND"; "Customer Attributes FND")
                {
                    LinkFields = "Customer No." = FIELD("No.");
                    LinkTable = Customer;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    XmlName = 'CustomerAttributes';
                    fieldelement(Street3; "Customer Attributes FND"."Street 3")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(Street4; "Customer Attributes FND"."Street 4")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(Street5; "Customer Attributes FND"."Street 5")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(HouseNo; "Customer Attributes FND"."House No. 1")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(TaxNumber1; "Customer Attributes FND"."Tax Number 1")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(TaxNumber2; "Customer Attributes FND"."Tax Number 2")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(POBox; "Customer Attributes FND"."P.O.Box")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    Distance := '0';
                    if TempCustomerDistance.GET(Customer."No.") then
                        Distance := FORMAT(TempCustomerDistance."Column 1 Amt.");

                    case TempCustomerDistance."Column 2 Amt." of
                        1:
                            Matching := Text001;
                        2:
                            Matching := Text002;
                        3:
                            Matching := Text003;
                        4:
                            Matching := Text004;
                    end;
                end;

                trigger OnPreXmlItem();
                begin
                    //ERROR('cust filter: ' +CustomerFilter);
                    Customer.SETFILTER("No.", CustomerFilter);
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

    var
        //CustomerCheckDuplicate : Codeunit "Customer Check Duplicate";
        CustomerFilter: Text;
        MendixInterfaceWebServices: Codeunit "Mendix Interface Web Services";
        TempCustomerDistance: Record "Aging Band Buffer" temporary;
        Text001: Label 'Matched On Customer Description';
        Text002: Label 'Matched On VAT Registration no.';
        Text003: Label 'Matched On Tax Number 1';
        Text004: Label 'Matched On Tax Number 2';

    procedure SetValues(CustNoFilter: Text; var TempCustDistance: Record "Aging Band Buffer" temporary);
    var
        Counter: Integer;
    begin
        CustomerFilter := CustNoFilter;
        //ERROR(CustomerFilter);
        //ERROR('distance: '+ TempCustDistance."Currency Code");
        TempCustDistance.RESET();
        TempCustDistance.SETFILTER("Currency Code", CustomerFilter);
        if TempCustDistance.findset() then
            repeat
                TempCustomerDistance."Currency Code" := TempCustDistance."Currency Code";
                TempCustomerDistance."Column 1 Amt." := TempCustDistance."Column 1 Amt.";
                TempCustomerDistance."Column 2 Amt." := TempCustDistance."Column 2 Amt.";
                TempCustomerDistance.INSERT();
            until TempCustDistance.NEXT() = 0;
        //ERROR('counter: '+ FORMAT(Counter));
    end;
}

