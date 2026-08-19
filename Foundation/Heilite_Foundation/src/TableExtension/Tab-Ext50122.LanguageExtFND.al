tableextension 50122 LanguageExtFND extends Language
{
    // version NAVW19.00,DITW18.00,HEI.01
    // DITW15.00.00.38 DDR 25/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    2014472 EU Language Code
    // DITW15.00.00.39 DDR 09/05/2011 issue 1328 Shop (iPos) Functionnalities
    //                                  Added fields
    //                                    2014503 ISO Language Text
    //                                  Added keys
    //                                    "Windows Language ID"
    //                                    "EU Language Code"
    //                                    "ISO Language Text"

    // HEI.01 FDD-PURGAPINT002 IBM LAZARE02 15.11.2017 # New field Use In Maximo

    // HEI.02 FDD-HT664 IBM SURYAS01 02-jan-2020
    //   #Created New Fields - "55000 & 55001"

    // BC Upgrade PATELS08 >>
    // Added procedure 'GetLanguageID' - dependency of 'Check Haiti Commercial'
    // BC Upgrade PATELS08 <<
    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Windows Language ID")
        {
            CaptionML = ENU = 'Windows Language ID', FRA = 'ID langue Windows';
        }
        modify("Windows Language Name")
        {

            //Unsupported feature: Change CalcFormula on ""Windows Language Name"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Windows Language Name', FRA = 'Nom langue Windows';
        }
        field(50000; "Use In Maximo FND"; Boolean)
        {
            Caption = 'Use In Maximo';
            Description = 'HEI.01';
        }
        field(55000; "Notifcation Letter Subject FND"; Text[100])
        {
            CaptionML = ENU = 'Payment Notification Letter Subject',
                        FRA = 'Objet lettre de notification de paiement';
            Description = 'HEI.02';
        }
        field(55001; "Notification Letter Body FND"; Text[250])
        {
            CaptionML = ENU = 'Payment Notification Letter Body',
                        FRA = 'Texte de la lettre de notification de paiement';
            Description = 'HEI.02';
        }
        //BC Upgrade SHARMP16 BEGIN<< ---IBM GAP STP 48
        field(55003; "ISO Language Text1 FND"; Text[10])
        {
            CaptionML = ENU = 'ISO Language',
                        FRA = 'langue ISO';
        }
        //BC Upgrade SHARMP16 END>> ---IBM GAP STP 48
        // field(2014472; "EU Language Code"; Code[10])
        // {
        //     CaptionML = ENU = 'EU Language Code',
        //                 FRA = 'Code langue Union Européenne';
        //     Description = 'DITW15.00.00.38';
        // }
        // field(2014503; "ISO Language Text"; Text[10])
        // {
        //     CaptionML = ENU = 'ISO Language',
        //                 FRA = 'langue ISO';
        //     Description = 'DITW15.00.00.39 #1328';
        // }  // BC Upgrade NANDIS03
    }
    keys
    {
        key(Key50000; "Windows Language ID")
        {
        }
        // key(Key2; "EU Language Code")
        // {
        // }
        // key(Key3; "ISO Language Text")
        // {
        // }  // BC Upgrade NANDIS03
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    // BC Upgrade PATELS08 >> added dependency of Report 'Check Haiti Commercial'
    procedure GetLanguageID(LanguageCode: Code[10]): Integer
    begin
        CLEAR(Rec);
        IF LanguageCode <> '' THEN
            IF GET(LanguageCode) THEN
                EXIT("Windows Language ID");
        "Windows Language ID" := GLOBALLANGUAGE;
        EXIT("Windows Language ID");
    end;
    // BC Upgrade PATELS08 <<

}

