page 90104 "API - Currency Exchange Rates"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityName = 'currencyExchangeRate';
    EntitySetName = 'currencyExchangeRates';
    SourceTable = "Currency Exchange Rate";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
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
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }

                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                }

                field(exchangeRateAmount; Rec."Exchange Rate Amount")
                {
                    Caption = 'Exchange Rate Amount';
                }

                field(adjustmentExchangeRateAmount; Rec."Adjustment Exch. Rate Amount")
                {
                    Caption = 'Adjustment Exch. Rate Amount';
                }

                field(relationalCurrencyCode; Rec."Relational Currency Code")
                {
                    Caption = 'Relational Currency Code';
                }

                field(relationalExchangeRateAmount; Rec."Relational Exch. Rate Amount")
                {
                    Caption = 'Relational Exch. Rate Amount';
                }

                field(fixExchangeRateAmount; Rec."Fix Exchange Rate Amount")
                {
                    Caption = 'Fix Exchange Rate Amount';
                }

                field(relationalAdjmtExchRateAmt; Rec."Relational Adjmt Exch Rate Amt")
                {
                    Caption = 'Relational Adjmt Exch Rate Amt';
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