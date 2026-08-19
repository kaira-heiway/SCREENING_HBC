xmlport 52001 "Export Vendor Posting Grp"
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

    // BC Upgrade SHUKLP03 >> Nav old id - 50052.

    CaptionML = ENU = 'Export Vendor',
                FRA = 'Exporter fournisseur';
    DefaultFieldsValidation = true;
    Direction = Export;
    FieldDelimiter = '"';
    FieldSeparator = ',';
    Format = VariableText;
    FormatEvaluate = Legacy;
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
            }
            tableelement("Vendor Posting Group"; "Vendor Posting Group")
            {
                XmlName = 'VendorPostingGroup';
                textelement(CurrentCompany)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CurrentCompany := COMPANYNAME;
                        if CompName <> '' then
                            CurrentCompany := CompName;
                    end;
                }
                fieldelement(Code; "Vendor Posting Group".Code)
                {
                }
                fieldelement(PayableAccount; "Vendor Posting Group"."Payables Account")
                {
                }
                fieldelement(ServiceChargeAcc; "Vendor Posting Group"."Service Charge Acc.")
                {
                }
                fieldelement(PaymentDiscDebitAcc; "Vendor Posting Group"."Payment Disc. Debit Acc.")
                {
                }
                fieldelement(InvoiceRoundingAccount; "Vendor Posting Group"."Invoice Rounding Account")
                {
                }
                fieldelement(DebitCurrApplnRndgAcc; "Vendor Posting Group"."Debit Curr. Appln. Rndg. Acc.")
                {
                }
                fieldelement(CreditCurrApplnRndgAcc; "Vendor Posting Group"."Credit Curr. Appln. Rndg. Acc.")
                {
                }
                fieldelement(DebitRoundingAccount; "Vendor Posting Group"."Debit Rounding Account")
                {
                }
                fieldelement(CreditRoundingAccount; "Vendor Posting Group"."Credit Rounding Account")
                {
                }
                fieldelement(PaymentDiscCreditAcc; "Vendor Posting Group"."Payment Disc. Credit Acc.")
                {
                }
                fieldelement(PaymentToleranceDebitAcc; "Vendor Posting Group"."Payment Tolerance Debit Acc.")
                {
                }
                fieldelement(PaymentToleranceCreditAcc; "Vendor Posting Group"."Payment Tolerance Credit Acc.")
                {
                }
                fieldelement(PrepaymentRequestAccount; "Vendor Posting Group"."Prepayment Request Account FND")
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
            "Vendor Posting Group".CHANGECOMPANY(CompName);
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

