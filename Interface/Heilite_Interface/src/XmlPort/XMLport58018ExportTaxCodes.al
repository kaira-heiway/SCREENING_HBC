xmlport 58018 "Export Tax Codes"
{
    // version ESKER1.0.4

    // ------------------------------------------------------------------------------------------------
    // DIAGONAL - www.groupediagonal.com
    // ------------------------------------------------------------------------------------------------
    // ESKER Connector
    // DIAG: 29/04/2015 - CBO [ESKER1.0] : - Creation
    //                                       Export VAT Posting Setup
    // ------------------------------------------------------------------------------------------------

    //Bc Upgrade YADAVM09 Old id is-50014.

    CaptionML = ENU = 'Export Tax Codes.',
                FRA = 'Exporter code taxe';
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
                XmlName = 'GLAccountHeader';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(CompanyNameTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CompanyNameTitle := Txt50001;
                    end;
                }
                textelement(TaxCodeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        TaxCodeTitle := Txt50002;
                    end;
                }
                textelement(DescriptionTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        DescriptionTitle := Txt50003;
                    end;
                }
                textelement(TaxRateTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        TaxRateTitle := Txt50004;
                    end;
                }
                textelement(PurchasesTaxAccountTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        PurchasesTaxAccountTitle := Txt50005;
                    end;
                }
                textelement(SalesTaxAccountTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        SalesTaxAccountTitle := Txt50006;
                    end;
                }
            }
            tableelement("VAT Posting Setup"; "VAT Posting Setup")
            {
                XmlName = 'GLAccount';
                textelement(CurrentCompany)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CurrentCompany := COMPANYNAME;
                        if CompName <> '' then
                            CurrentCompany := CompName;
                    end;
                }
                textelement(TaxCode)
                {

                    trigger OnBeforePassVariable();
                    begin
                        TaxCode := "VAT Posting Setup"."VAT Identifier";
                        if "VAT Posting Setup"."VAT Bus. Posting Group" <> '' then
                            TaxCode := TaxCode + ' (' + "VAT Posting Setup"."VAT Bus. Posting Group" + ')';
                    end;
                }
                textelement(Description)
                {

                    trigger OnBeforePassVariable();
                    begin
                        Description := "VAT Posting Setup"."VAT Bus. Posting Group" + ' ' + "VAT Posting Setup"."VAT Prod. Posting Group";
                    end;
                }
                textelement(TaxRate)
                {

                    trigger OnBeforePassVariable();
                    begin
                        TaxRate := FORMAT("VAT Posting Setup"."VAT %", 0, 9);
                    end;
                }
                fieldelement(PurchasesTaxAccount; "VAT Posting Setup"."Purchase VAT Account")
                {
                }
                fieldelement(SalesTaxAccount; "VAT Posting Setup"."Sales VAT Account")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    if "VAT Posting Setup"."VAT Bus. Posting Group" = '' then
                        currXMLport.SKIP
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

    trigger OnPostXmlPort();
    begin
        currXMLport.FILENAME := STRSUBSTNO(Txt50000, FORMAT(CURRENTDATETIME, 0, '<Year4><Month,2><Day,2><Hours24,2><Minutes,2><Seconds,2>'), '.csv');
    end;

    trigger OnPreXmlPort();
    begin
        if (COMPANYNAME <> CompName) and (CompName <> '') then
            "VAT Posting Setup".CHANGECOMPANY(CompName);
    end;

    var
        Txt50000: TextConst ENU = 'NAV__Taxcodes__%1%2', FRA = 'NAV__Taxcodes__%1%2';
        Txt50001: TextConst ENU = 'CompanyCode__', FRA = 'CompanyCode__';
        Txt50002: TextConst ENU = 'TaxCode__', FRA = 'TaxCode__';
        Txt50003: TextConst ENU = 'Description__', FRA = 'Description__';
        Txt50004: TextConst ENU = 'TaxRate__', FRA = 'TaxRate__';
        Txt50005: TextConst ENU = 'TaxAccount__', FRA = 'TaxAccount__';
        Txt50006: TextConst ENU = 'TaxAccountForCollection__', FRA = 'TaxAccountForCollection__';
        CompName: Text[30];

    procedure SetCompany(CompanyName2: Text[30]);
    begin
        CompName := CompanyName2;
    end;
}

