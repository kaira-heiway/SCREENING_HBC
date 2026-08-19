xmlport 58016 "Export General Account"
{
    // version ESKER1.0.4

    // ------------------------------------------------------------------------------------------------
    // DIAGONAL - www.groupediagonal.com
    // ------------------------------------------------------------------------------------------------
    // ESKER Connector
    // DIAG: 29/04/2015 - CBO [ESKER1.0] : - Creation
    //                                       Export General Account
    // ------------------------------------------------------------------------------------------------
    // FDD HNK 100391 IBM.CHAUHB01  14/04/2017  : Added filters to export account whre Direct posting is  yes

    CaptionML = ENU = 'Export General Account',
                FRA = 'Exporter compte g?n?ral';
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
                textelement(GLAccountNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        GLAccountNoTitle := Txt50002;
                    end;
                }
                textelement(GLAccountNameTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        GLAccountNameTitle := Txt50003;
                    end;
                }
            }
            tableelement("G/L Account"; "G/L Account")
            {
                XmlName = 'GLAccount';
                SourceTableView = SORTING("No.") WHERE("Direct Posting" = CONST(true), "Account Type" = CONST(Posting), Blocked = CONST(false));
                textelement(CurrentCompany)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CurrentCompany := COMPANYNAME;
                        if CompName <> '' then
                            CurrentCompany := CompName;
                    end;
                }
                fieldelement(No; "G/L Account"."No.")
                {
                }
                fieldelement(Name; "G/L Account".Name)
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
        currXMLport.FILENAME := STRSUBSTNO(Txt50000, FORMAT(CURRENTDATETIME, 0, '<Year4><Month,2><Day,2><Hours24,2><Minutes,2><Seconds,2>'), '.csv');
    end;

    trigger OnPreXmlPort();
    begin
        if (COMPANYNAME <> CompName) and (CompName <> '') then
            "G/L Account".CHANGECOMPANY(CompName);
    end;

    var
        Txt50000: TextConst ENU = 'NAV__GLaccount__%1%2', FRA = 'NAV__GLaccount__%1%2';
        Txt50001: TextConst ENU = 'CompanyCode__', FRA = 'CompanyCode__';
        Txt50002: TextConst ENU = 'Account__', FRA = 'Account__';
        Txt50003: TextConst ENU = 'Description__', FRA = 'Description__';
        CompName: Text[30];

    procedure SetCompany(CompanyName2: Text[30]);
    begin
        CompName := CompanyName2;
    end;
}

