tableextension 50109 CountryRegionExtFND extends "Country/Region"
{
    // version NAVW19.00,FINXL7.00,DITW18.00,HEI.01
    // FINXL7.00.001 RBE 20/03/2013 : Added field ENUName

    // DITW17.00.02 DDR 04/06/2013 DIT-770 #99 Added fields
    //                                            2014560 UK VAT Bus. Posting Group
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // HEI.01 FDD-PRDGAP004 - Automatic Batch Number Generation , 10.09.2017 IBM.NAIKH01
    //   # Added new fields "Country Dailing Code"
    // HEI.02 V1.05 HT84 IBM POENAB02 28.03.2019
    //   # New fields for Bank Connectivity interface
    //     # 50001 ISO Country/Region Code
    //     # 50002 IBAN Country/Region
    //   # New function for Bank Connectivity interface
    //     # DetermineCountry

    // HEI.03 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New field: 10800 SEPA Allowed
    //   # New options for field "Address Format" (including translation)
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
        modify("EU Country/Region Code")
        {
            CaptionML = ENU = 'EU Country/Region Code', FRA = 'Code pays/région Union Européenne';
        }
        modify("Intrastat Code")
        {
            CaptionML = ENU = 'Intrastat Code', FRA = 'Code intracommunautaire';
        }
        modify("Address Format")
        {

            //Unsupported feature: Change InitValue on ""Address Format"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Address Format', FRA = 'Format adresse';
           // OptionCaptionML = ENU = 'Post Code+City,City+Post Code,City+County+Post Code,Blank Line+Post Code+City,Post Code+City/County,County/Post Code+City', FRA = 'CP + Ville,Ville + CP,Ville + Région + CP,Ligne blanche + CP + Ville,CP + Ville/Région,Région/CP + Ville';

            //Unsupported feature: Change OptionString on ""Address Format"(Field 8)". Please convert manually.

        }
        modify("Contact Address Format")
        {

            //Unsupported feature: Change InitValue on ""Contact Address Format"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Contact Address Format', FRA = 'Format adresse contact';
            OptionCaptionML = ENU = 'First,After Company Name,Last', FRA = 'Début,Après nom société,Fin';
        }
        modify("VAT Scheme")
        {
            CaptionML = ENU = 'VAT Scheme', FRA = 'Régime de TVA';
        }
        // field(10800; "SEPA Allowed"; Boolean)
        // {
        //     CaptionML = ENU = 'SEPA Allowed',
        //                 FRA = 'SEPA autorisé';
        //     Description = 'HEI.03';
        // }  // BC Upgrade NANDIS03 - BLocked as it's aFR localization field
        field(50000; "Country Dialing code FND"; Text[3])
        {
            caption ='Country Dialing code';
            Description = 'PRDGAP004';
        }
        field(50001; "ISO Country/Region Code FND"; Code[2])
        {
            CaptionML = ENU = 'ISO Country/Region Code',
                        FRB = 'Code pays/région ISO',
                        NLB = 'ISO-land-/regiocode';
            Description = 'HEI.02';
        }
        field(50002; "IBAN Country/Region FND"; Boolean)
        {
            Caption = 'IBAN Country/Region';
            Description = 'HEI.02';
        }
        // field(2029610;ENUName;Text[50])
        // {
        //     CaptionML = ENU='ENUName',
        //                 FRA='ENUName';
        //     Description = 'FINXL7.00.001';
        // }  // BC Upgrade NANDIS03 - DIT dependency
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        Text50000: TextConst ENU = 'BE', FRB = 'BE', NLB = 'BE';

    // BC Upgrade NANDIS03 >>
    procedure DetermineCountry(CountryCode: Code[10]): Boolean

    begin
        //HEI.02>>
        IF CountryCode = '' THEN
            EXIT(TRUE);

        GET(CountryCode);
        IF "ISO Country/Region Code FND" <> Text50000 THEN
            EXIT(FALSE);
        EXIT(TRUE);
        //HEI.02<<
    end;
    // BC Upgrade NANDIS03 <<
}

