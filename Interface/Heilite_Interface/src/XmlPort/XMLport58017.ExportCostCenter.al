xmlport 58017 "Export Cost Center"
{
    // version ESKER1.0.4

    // ------------------------------------------------------------------------------------------------
    // DIAGONAL - www.groupediagonal.com
    // ------------------------------------------------------------------------------------------------
    // ESKER Connector
    // DIAG: 29/04/2015 - CBO [ESKER1.0] : - Creation
    //                                       Export Cost Center
    // ------------------------------------------------------------------------------------------------

    //Bc Upgrade YADAVM09 Old id is-50012.
    CaptionML = ENU = 'Export Cost Center',
                FRA = 'Exporter centre de co?ts';
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
                XmlName = 'CostCenterHeader';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(CompanyNameTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CompanyNameTitle := Txt50001;
                    end;
                }
                textelement(CostCenterNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CostCenterNoTitle := Txt50002;
                    end;
                }
                textelement(CostCenterNameTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CostCenterNameTitle := Txt50003;
                    end;
                }
            }
            tableelement("Dimension Value"; "Dimension Value")
            {
                XmlName = 'CostCenter';
                SourceTableView = SORTING("Dimension Code", Code) WHERE("Dimension Code" = CONST('CCCS'));
                textelement(CurrentCompany)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CurrentCompany := COMPANYNAME;
                        if CompName <> '' then
                            CurrentCompany := CompName;
                    end;
                }
                fieldelement(Code; "Dimension Value".Code)
                {
                }
                fieldelement(Name; "Dimension Value".Name)
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
        if (COMPANYNAME <> CompName) and (CompName <> '') then;
        //  "Cost Center".CHANGECOMPANY(CompName);
    end;

    var
        Txt50000: TextConst ENU = 'NAV__Costcenters__%1%2', FRA = 'NAV__Costcenters__%1%2';
        Txt50001: TextConst ENU = 'CompanyCode__', FRA = 'CompanyCode__';
        Txt50002: TextConst ENU = 'CostCenter__', FRA = 'CostCenter__';
        Txt50003: TextConst ENU = 'Description__', FRA = 'Description__';
        CompName: Text[30];

    procedure SetCompany(CompanyName2: Text[30]);
    begin
        CompName := CompanyName2;
    end;
}

