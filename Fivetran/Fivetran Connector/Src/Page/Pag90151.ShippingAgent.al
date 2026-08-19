page 90151 "Shipping Agent API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Shipping Agent';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Shipping Agent';
    EntitySetCaption = 'Shipping Agent';
    EntityName = 'shippingAgent';
    EntitySetName = 'shippingAgent';
    SourceTable = "Shipping Agent";
    ODataKeyFields = SystemID;

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
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(internetAddress; Rec."Internet Address")
                {
                    Caption = 'Internet Address';
                }
                field(accountNo; Rec."Account No.")
                {
                    Caption = 'Account No.';
                }
                field(ownLogisticsFND; Rec."Own Logistics FND")
                {
                    Caption = 'Own Logistics';
                }
                field(autoMailOnReleaseOrderFND; Rec."Auto Mail on release Order FND")
                {
                    Caption = 'Auto Mail on release Order';
                }
                field(address; Rec."Address 113FDW")
                {
                    Caption = 'Address';
                }
                field(city; Rec."City 113FDW")
                {
                    Caption = 'City';
                }
                field(countryRegion; Rec."Country/Region 113FDW")
                {
                    Caption = 'Country/Region Code';
                }
                field(postCode; Rec."Post Code 113FDW")
                {
                    Caption = 'Post Code';
                }
                field(consignorGuarantee; Rec."Consignor Guarantee 113FDW")
                {
                    Caption = 'Consignor Guarantee';
                }
                field(firstTranspTrader; Rec."First Transp. Trader 113FDW")
                {
                    Caption = 'First Transporter Trader';
                }
                field(vatRegistrationNo; Rec."VAT Registration No. 113FDW")
                {
                    Caption = 'VAT Registration No.';
                }
            }
        }
    }
}
