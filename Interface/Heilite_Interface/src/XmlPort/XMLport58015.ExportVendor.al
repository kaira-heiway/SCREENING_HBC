xmlport 58015 "Export Vendor"
{
    // version ESKER1.0.4

    // ------------------------------------------------------------------------------------------------
    // DIAGONAL - www.groupediagonal.com
    // ------------------------------------------------------------------------------------------------
    // ESKER Connector
    // DIAG: 29/04/2015 - CBO [ESKER1.0] : - Creation
    //                                       Export Vendor List
    // ------------------------------------------------------------------------------------------------
    // FDD HNK 100391 IBM.CHAUHB01  14/04/2017  : Added filters to export only unblock Vendor
    // HEI.01 FDD HB1348 CHG2061857 IBM SHANKJ03 25.06.2020
    //   #added new tag VendPstgrp

    //Bc Upgrade YADAVM09 Old id is-50011.

    CaptionML = ENU = 'Export Vendor',
                FRA = 'Exporter fournisseur';
    Direction = Export;
    FieldDelimiter = '"';
    FieldSeparator = ',';
    Format = VariableText;
    TableSeparator = '<NewLine>';
    TextEncoding = UTF8;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'VendorHeader';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(CompanyNameTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CompanyNameTitle := Txt50001;
                    end;
                }
                textelement(VendorNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VendorNoTitle := Txt50002;
                    end;
                }
                textelement(VendorNameTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VendorNameTitle := Txt50003;
                    end;
                }
                textelement(VendorAddressTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VendorAddressTitle := Txt50004;
                    end;
                }
                textelement(VendorCityTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VendorCityTitle := Txt50005;
                    end;
                }
                textelement(PostCodeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        PostCodeTitle := Txt50006;
                    end;
                }
                textelement(VendorCountyTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VendorCountyTitle := Txt50007;
                    end;
                }
                textelement(VendorCountryRegionCodeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VendorCountryRegionCodeTitle := Txt50008;
                    end;
                }
                textelement(VendorPhoneNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VendorPhoneNoTitle := Txt50009;
                    end;
                }
                textelement(VendorFaxNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VendorFaxNoTitle := Txt50010;
                    end;
                }
                textelement(VendorVATRegistrationNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VendorVATRegistrationNoTitle := Txt50011;
                    end;
                }
                textelement(VendorPaymentTermsCode)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VendorPaymentTermsCode := Txt50012;
                    end;
                }
                textelement(VendorEMailTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VendorEMailTitle := Txt50013;
                    end;
                }
                textelement(VendorCurrencyTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VendorCurrencyTitle := Txt50014;
                    end;
                }
            }
            tableelement(Vendor; Vendor)
            {
                RequestFilterFields = "No.";
                XmlName = 'Vendor';
                SourceTableView = SORTING("No.") WHERE(Blocked = FILTER(<> All));
                textelement(CurrentCompany)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CurrentCompany := COMPANYNAME;
                        if CompName <> '' then
                            CurrentCompany := CompName;
                    end;
                }
                fieldelement(No; Vendor."No.")
                {
                }
                fieldelement(Name; Vendor.Name)
                {
                }
                fieldelement(Address; Vendor.Address)
                {
                }
                fieldelement(City; Vendor.City)
                {
                }
                fieldelement(PostCode; Vendor."Post Code")
                {
                }
                fieldelement(County; Vendor.County)
                {
                }
                fieldelement(CountryRegionCode; Vendor."Country/Region Code")
                {
                }
                fieldelement(PhoneNo; Vendor."Phone No.")
                {
                }
                fieldelement(FaxNo; Vendor."Fax No.")
                {
                }
                fieldelement(VatRegistrationNo; Vendor."VAT Registration No.")
                {
                }
                fieldelement(PaymentTermsCode; Vendor."Payment Terms Code")
                {
                }
                fieldelement("E-Mail"; Vendor."E-Mail")
                {
                }
                fieldelement(Currency; Vendor."Currency Code")
                {
                }
                fieldelement(VendorPstGrp; Vendor."Vendor Posting Group")
                {
                }
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

    trigger OnPostXmlPort();
    begin
        currXMLport.FILENAME := STRSUBSTNO(Txt50000, FORMAT(CURRENTDATETIME, 0, '<Year4><Month,2><Day,2><Hours24><Minutes,2><Seconds,2>'), '.csv');
    end;

    trigger OnPreXmlPort();
    begin
        if (COMPANYNAME <> CompName) and (CompName <> '') then
            Vendor.CHANGECOMPANY(CompName);
    end;

    var
        Txt50000: TextConst ENU = 'NAV__Vendors__%1%2', FRA = 'NAV__Vendors__%1%2';
        Txt50001: TextConst ENU = 'CompanyCode__', FRA = 'CompanyCode__';
        Txt50002: TextConst ENU = 'Number__', FRA = 'Number__';
        Txt50003: TextConst ENU = 'Name__', FRA = 'Name__';
        Txt50004: Label 'Street__';
        Txt50005: Label 'City__';
        Txt50006: Label 'PostalCode__';
        Txt50007: Label 'Region__';
        Txt50008: Label 'Country__';
        Txt50009: Label 'PhoneNumber__';
        Txt50010: Label 'FaxNumber__';
        Txt50011: Label 'VATNumber__';
        Txt50012: Label 'PaymentTermCode__';
        Txt50013: Label 'Email__';
        CompName: Text[30];
        Txt50014: Label 'Currency__';

    procedure SetCompany(CompanyName2: Text[30]);
    begin
        CompName := CompanyName2;
    end;
}

