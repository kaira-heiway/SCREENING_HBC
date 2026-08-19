tableextension 50207 AgingBandBufferExtFND extends "Aging Band Buffer"
{
    // version NAVW16.00
    // BC Upgrade BHARDA11

    fields
    {
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Column 1 Amt.")
        {
            CaptionML = ENU = 'Column 1 Amt.', FRA = 'Montant colonne 1';
        }
        modify("Column 2 Amt.")
        {
            CaptionML = ENU = 'Column 2 Amt.', FRA = 'Montant colonne 2';
        }
        modify("Column 3 Amt.")
        {
            CaptionML = ENU = 'Column 3 Amt.', FRA = 'Montant colonne 3';
        }
        modify("Column 4 Amt.")
        {
            CaptionML = ENU = 'Column 4 Amt.', FRA = 'Montant colonne 4';
        }
        modify("Column 5 Amt.")
        {
            CaptionML = ENU = 'Column 5 Amt.', FRA = 'Montant colonne 5';
        }
        field(50000; "Disputed Amt. FND"; Decimal)
        {
            caption = 'Disputed Amount';
            Description = 'HEI.01';
        }
        field(50010; "Column E1 Amt. FND"; Decimal)
        {
            CaptionML = ENU = 'Column 1 Amt.',
                        FRA = 'Montant colonne 1';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(50020; "Column E2 Amt. FND"; Decimal)
        {
            CaptionML = ENU = 'Column 2 Amt.',
                        FRA = 'Montant colonne 2';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(50030; "Column E3 Amt. FND"; Decimal)
        {
            CaptionML = ENU = 'Column 3 Amt.',
                        FRA = 'Montant colonne 3';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(50040; "Column E4 Amt. FND"; Decimal)
        {
            CaptionML = ENU = 'Column 4 Amt.',
                        FRA = 'Montant colonne 4';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(50050; "Column E5 Amt. FND"; Decimal)
        {
            CaptionML = ENU = 'Column 5 Amt.',
                        FRA = 'Montant colonne 5';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(50060; "Disputed EAmt. FND"; Decimal)
        {
            Caption = 'Disputed EAmt.';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
    }
    keys
    {

        //Unsupported feature: Deletion on ""Currency Code"(Key)". Please convert manually.

        key(Key2; "Currency Code")
        {
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

