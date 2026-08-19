page 90007 "API - Countries/Regions"
{
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Countries Region';
    EntitySetCaption = 'Countries Regions';
    DelayedInsert = true;
    EntityName = 'countryRegion';
    EntitySetName = 'countriesRegions';
    ODataKeyFields = SystemId;
    PageType = API;
    SourceTable = "Country/Region";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(addressFormat; Rec."Address Format")
                {
                    Caption = 'Address Format';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(contactAddressFormat; Rec."Contact Address Format")
                {
                    Caption = 'Contact Address Format';
                }
                field(countyName; Rec."County Name")
                {
                    Caption = 'County Name';
                }
                field(euCountryRegionCode; Rec."EU Country/Region Code")
                {
                    Caption = 'EU Country/Region Code';
                }
                field(isoCode; Rec."ISO Code")
                {
                    Caption = 'ISO Code';
                }
                field(isoNumericCode; Rec."ISO Numeric Code")
                {
                    Caption = 'ISO Numeric Code';
                }
                field(intrastatCode; Rec."Intrastat Code")
                {
                    Caption = 'Intrastat Code';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                // field(satCountryCode; Rec."SAT Country Code")
                // {
                //     Caption = 'SAT Country Code';
                // }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(vatScheme; Rec."VAT Scheme")
                {
                    Caption = 'VAT Scheme';
                }
                //BC UPGRADE KUMARR78 >>
                field(countryDialingCode; Rec."Country Dialing code FND")
                {
                    Caption = 'Country Dialing Code';
                }

                field(isoCountryRegionCode; Rec."ISO Country/Region Code FND")
                {
                    Caption = 'ISO Country/Region Code';
                }

                field(ibanCountryRegion; Rec."IBAN Country/Region FND")
                {
                    Caption = 'IBAN Country/Region';
                }
                //BC UPGRADE KUMARR78 <<
            }
        }
    }
}
