tableextension 50058 AdjustExchangeRateBufferExtFND extends "Adjust Exchange Rate Buffer"
{
    // version NAVW19.00,HEI.02
    // HEI.02 CHG2236692 IBM SISUM01 29.02.2024 HB3717_Development to perform revaluation for AR/AP
    //   #add field id 50002
    fields
    {
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Posting Group")
        {
            CaptionML = ENU = 'Posting Group', FRA = 'Groupe comptabilisation';
        }
        modify(AdjBase)
        {
            CaptionML = ENU = 'AdjBase', FRA = 'AjustBase';
        }
        modify(AdjBaseLCY)
        {
            CaptionML = ENU = 'AdjBaseLCY', FRA = 'AjustBaseDS';
        }
        modify(AdjAmount)
        {
            CaptionML = ENU = 'AdjAmount', FRA = 'AjusterMnt';
        }
        modify(TotalGainsAmount)
        {
            CaptionML = ENU = 'TotalGainsAmount', FRA = 'TotalGainsMontant';
        }
        modify(TotalLossesAmount)
        {
            CaptionML = ENU = 'TotalLossesAmount', FRA = 'TotalPertesMontant';
        }
        modify("Dimension Entry No.")
        {
            CaptionML = ENU = 'Dimension Entry No.', FRA = 'N° séquence analytique';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("IC Partner Code")
        {
            CaptionML = ENU = 'IC Partner Code', FRA = 'Code du partenaire IC';
        }
        modify(Index)
        {
            CaptionML = ENU = 'Index', FRA = 'Réévaluer';
        }
        field(50000; "Detailed Entry No. FND"; Integer)
        {
            Caption = 'Detailed Entry No.';
        }
        field(50001; "Acc Type FND"; Integer)
        {
            Caption = 'Account Type';
        }
        field(50002; "CV Ledger Entry No. FND"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            Caption = 'CV Ledger Entry No.';
        }
    }
    keys
    {

        //Unsupported feature: Deletion on ""Currency Code","Posting Group","Dimension Entry No.","Posting Date","IC Partner Code"(Key)". Please convert manually.

        // key(Key1; "Currency Code", "Posting Group", "Dimension Entry No.", "Posting Date", "IC Partner Code", "Detailed Entry No.")
        // {
        // }  // BC Upgrade NANDIS03
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

