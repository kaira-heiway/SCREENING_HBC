pageextension 51066 CountriesRegionExtCBN extends "Countries/Regions"
{
    //     DITW17.00.02 DDR 04/06/2013 DIT-770 #99 Added fields "UK VAT Bus. Posting Group"
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99
    // DITW17.00.02 RPG 05/11/2013 DIT-770 #235 Added New Action 'Comments' in Navigate tab

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // HEI.01 FDD PRDGAP004-  AUtomatic assignment of Batch Number: IBM.NAIKH01 , 19.09.2017
    //   # Added new field "Country Dialing code"
    // HEI.02 CHG0270593 - IBM ISYED01 2.15.2019
    //  # renamed the column Country Dialing Code to Numeric Country ISO Code.
    // HEI.03 V1.05 HT84 IBM POENAB02 03.04.2019
    // # New fields for Bank Connectivity interface
    //   # ISO Country/Region Code
    //   # IBAN Country/Region
    // HEI.04 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New fields:
    //     # "SEPA Allowed"
    layout
    {
        addafter("VAT Scheme")
        {
            field("Numeric Country ISO Code"; Rec."Country Dialing code FND")
            {
                Caption = 'Numeric Country ISO Code';
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Numeric Country ISO Code field.';

            }
            field("ISO Country/Region Code"; Rec."ISO Country/Region Code FND")
            {
                Caption = 'ISO Country/Region Code';
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the ISO Country/Region Code field.';
            }
            field("IBAN Country/Region"; Rec."IBAN Country/Region FND")
            {
                ApplicationArea = all;
                Caption = 'IBAN Country/Region';
                ToolTip = 'Specifies the value of the IBAN Country/Region field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}