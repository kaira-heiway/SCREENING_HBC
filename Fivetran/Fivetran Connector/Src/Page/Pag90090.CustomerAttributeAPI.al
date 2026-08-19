namespace InterfaceMTC.InterfaceMTC;

page 90090 "Customer Attribute API"
{
    APIGroup = 'customEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'customerAttributeAPI';
    DelayedInsert = true;
    EntityName = 'CustomerAttribute';
    EntitySetName = 'CustomerAttribute';
    DataAccessIntent = ReadOnly;
    Editable = false;
    PageType = API;
    ODataKeyFields = SystemId;
    SourceTable = "Customer Attributes FND";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(customerType; Rec."Customer Type")
                {
                    Caption = 'Customer Type';
                }
                field(businessSegment; Rec."Business Segment")
                {
                    Caption = 'Business Segment';
                }
                field(businessOrganizationalSegment; Rec."Business OrganizationalSegment")
                {
                    Caption = 'Business Organizational Segment';
                }
                field(customerSubType; Rec."Customer Sub-Type")
                {
                    Caption = 'Customer Sub-Type';
                }
                field(localCustomerSubType; Rec."Local Customer Sub-Type")
                {
                    Caption = 'Local Customer Sub-Type';
                }
                field(name3; Rec."Name 3")
                {
                    Caption = 'Name 3';
                }
                field(name4; Rec."Name 4")
                {
                    Caption = 'Name 4';
                }
                field(search2; Rec."Search 2")
                {
                    Caption = 'Search 2';
                }
                field(cOName; Rec."C/O Name")
                {
                    Caption = 'C/O Name';
                }
                field(street3; Rec."Street 3")
                {
                    Caption = 'Street 3';
                }
                field(street4; Rec."Street 4")
                {
                    Caption = 'Street 4';
                }
                field(street5; Rec."Street 5")
                {
                    Caption = 'Street 5';
                }
                field(houseNo1; Rec."House No. 1")
                {
                    Caption = 'House No. 1';
                }
                field(houseSupplement2; Rec."House Supplement 2")
                {
                    Caption = 'House Supplement 2';
                }
                field(district; Rec.District)
                {
                    Caption = 'District';
                }
                field(differentCity; Rec."Different City")
                {
                    Caption = 'Different City';
                }
                field(pOBox; Rec."P.O.Box")
                {
                    Caption = 'P.O.Box';
                }
                field(pOBoxW0No; Rec."P.O.Box w/0 No.")
                {
                    Caption = 'P.O.Box w/0 No.';
                }
                field(typeOfDeliveryService; Rec."Type of Delivery Service")
                {
                    Caption = 'Type of Delivery Service';
                }
                field(otherCity; Rec."Other City")
                {
                    Caption = 'Other City';
                }
                field(noOfDeliveryService; Rec."No. of Delivery Service")
                {
                    Caption = 'No. of Delivery Service';
                }
                field(pOBoxPostalCode; Rec."P.O.Box Postal Code")
                {
                    Caption = 'P.O.Box Postal Code';
                }
                field(otherCountry; Rec."Other Country")
                {
                    Caption = 'Other Country';
                }
                field(otherRegion; Rec."Other Region")
                {
                    Caption = 'Other Region';
                }
                field(companyPostalCode; Rec."Company Postal Code")
                {
                    Caption = 'Company Postal Code';
                }
                field(authorizationGroup; Rec."Authorization Group")
                {
                    Caption = 'Authorization Group';
                }
                field(taxNumber2; Rec."Tax Number 2")
                {
                    Caption = 'Tax Number 2';
                }
                field(taxNumber3; Rec."Tax Number 3")
                {
                    Caption = 'Tax Number 3';
                }
                field(taxNumber4; Rec."Tax Number 4")
                {
                    Caption = 'Tax Number 4';
                }
                field(legalForm; Rec."Legal Form")
                {
                    Caption = 'Legal Form';
                }
                field(countryLicense; Rec."Country License")
                {
                    Caption = 'Country License';
                }
                field(licenseType; Rec."License Type")
                {
                    Caption = 'License Type';
                }
                field(licenseNo; Rec."License No.")
                {
                    Caption = 'License No.';
                }
                field(licenseValidFrom; Rec."License Valid from")
                {
                    Caption = 'License Valid from';
                }
                field(licenseValidTo; Rec."License Valid to")
                {
                    Caption = 'License Valid to';
                }
                field(paymentValidFrom; Rec."Payment valid from")
                {
                    Caption = 'Payment valid from';
                }
                field(paymentValidTo; Rec."Payment valid to")
                {
                    Caption = 'Payment valid to';
                }
                field(strategicIndicator; Rec."Strategic Indicator")
                {
                    Caption = 'Strategic Indicator';
                }
                field(localKeyAccount; Rec."Local key Account")
                {
                    Caption = 'Local key Account';
                }
                field(flagForDeletion; Rec."Flag for Deletion")
                {
                    Caption = 'Flag for Deletion';
                }
                field(invoiceEmailAddress; Rec."Invoice Email Address")
                {
                    Caption = 'Invoice Email Address';
                }
                field(tradingPartner; Rec."Trading Partner")
                {
                    Caption = 'Trading Partner';
                }
                field(taxNumber1; Rec."Tax Number 1")
                {
                    Caption = 'Tax Number 1';
                }
                field(freeGoods; Rec."Free Goods")
                {
                    Caption = 'Free Goods';
                }
                field(marketType; Rec."Market Type")
                {
                    Caption = 'Market Type';
                }
                field(registreDeCommerce; Rec."Registre de Commerce")
                {
                    Caption = 'Registre de Commerce';
                }
                field(articleDImposition; Rec."Article d'imposition")
                {
                    Caption = 'Article d''imposition';
                }
                field(nIS; Rec."N.I.S.")
                {
                    Caption = 'N.I.S.';
                }
                field(nif; Rec.NIF)
                {
                    Caption = 'NIF';
                }
                field(checkDigitVAT; Rec."Check Digit -VAT")
                {
                    Caption = 'Check Digit -VAT';
                }
                field(visitDay; Rec."Visit day")
                {
                    Caption = 'Visit day';
                }
                field(classification; Rec.Classification)
                {
                    Caption = 'Classification';
                }
                field(search; Rec.Search)
                {
                    Caption = 'Search';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
