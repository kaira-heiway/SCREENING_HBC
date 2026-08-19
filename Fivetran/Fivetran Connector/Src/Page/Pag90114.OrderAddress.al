page 90114 "API - Order Addresses"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    EntityName = 'orderAddress';
    EntitySetName = 'orderAddresses';
    SourceTable = "Order Address";
    Editable = false;
    ODataKeyFields = SystemId;
    DelayedInsert = true;

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
                field(vendorNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                }
                field(code; Rec.Code)
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(contact; Rec.Contact)
                {
                    Caption = 'Contact';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(telexNo; Rec."Telex No.")
                {
                    Caption = 'Telex No.';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }
                field(telexAnswerBack; Rec."Telex Answer Back")
                {
                    Caption = 'Telex Answer Back';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(homePage; Rec."Home Page")
                {
                    Caption = 'Home Page';
                }
                field(supplyingPlantVendorNumberFND; Rec."Supplying Plant Vndor Num. FND")
                {
                    Caption = 'Supplying Plant Vendor Number';
                }
                field(taxRegistrationNo; Rec."Tax Registration No. 113FDW")
                {
                    Caption = 'Tax Registration No.';
                }
                field(fiscalRepresentativeNo; Rec."Fiscal Rep. No. 113FDW")
                {
                    Caption = 'Fiscal Representative No.';
                }

                field(route; Rec."Default Route 107FDW")
                {
                    Caption = 'Route';
                }
                field(taxWarehouseReference; Rec."Tax Warehouse Ref. 113FDW")
                {
                    Caption = 'Tax Warehouse Reference';
                }
                field(taxOfficeCode; Rec."Tax Office Code 102FDW")
                {
                    Caption = 'Tax Office Code';
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