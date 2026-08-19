page 90009 "API- Currency Exchange Rates"
{
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Currency Exchange Rate';
    EntitySetCaption = 'Currency Exchange Rates';
    EntityName = 'currencyExchangeRate';
    EntitySetName = 'currencyExchangeRates';
    PageType = API;
    SourceTable = "Currency Exchange Rate";
    ODataKeyFields = SystemId;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(adjustmentExchRateAmount; Rec."Adjustment Exch. Rate Amount")
                {
                    Caption = 'Adjustment Exch. Rate Amount';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(exchangeRateAmount; Rec."Exchange Rate Amount")
                {
                    Caption = 'Exchange Rate Amount';
                }
                field(fixExchangeRateAmount; Rec."Fix Exchange Rate Amount")
                {
                    Caption = 'Fix Exchange Rate Amount';
                }
                field(relationalAdjmtExchRateAmt; Rec."Relational Adjmt Exch Rate Amt")
                {
                    Caption = 'Relational Adjmt Exch Rate Amt';
                }
                field(relationalCurrencyCode; Rec."Relational Currency Code")
                {
                    Caption = 'Relational Currency Code';
                }
                field(relationalExchRateAmount; Rec."Relational Exch. Rate Amount")
                {
                    Caption = 'Relational Exch. Rate Amount';
                }
                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                }
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
            }
        }
    }
}
