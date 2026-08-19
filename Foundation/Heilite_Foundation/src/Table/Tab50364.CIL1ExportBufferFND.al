table 50364 "CIL1 Export Buffer FND"
{
    // version HEI.04

    // HEI:EDD072:1:1 02/01/2015 TECTURA.WSA
    //   # Created the table
    // 
    // HEI.02 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Migrated table from HEI.2.0 to Base
    // HEI.03 FDD-HB1425 BULIMC01 IBM 03.06.2020 #new fields added
    //     #50000 - P_PACKTYPE
    //     #50001 - CHANNEL
    //     #Primary key updated with the above fields
    // HEI.04 FDD-HB2977 CHG2161959 YADAVM05 02.11.2022 # New Field Added BIB Quantity

    // BC Upgrade Kamnay01 Original(Heilite) Table id 50038
    Caption = 'CIL1 Export Buffer';

    fields
    {
        field(10; CALYEAR; Text[4])
        {
        }
        field(20; CALWEEK; Text[7])
        {
        }
        field(30; OPCO; Text[30])
        {
        }
        field(40; COUNTRY; Text[30])
        {
        }
        field(50; BRAND; Text[30])
        {
        }
        field(60; LINEXTEN; Text[30])
        {
        }
        field(70; MARKET; Text[30])
        {
        }
        field(80; PRODTYP; Text[30])
        {
        }
        field(90; QVLD02; Decimal)
        {
        }
        field(100; YVERSION; Text[30])
        {
        }
        field(120; "CIL ID"; Text[25])
        {
        }
        field(130; "Business Type"; Text[20])
        {
        }
        field(50000; P_PACKTYPE; Text[30])
        {
            Description = 'HEI.03';
        }
        field(50001; CHANNEL; Text[30])
        {
            Description = 'HEI.03';
        }
        field(50002; "BIB Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
    }

    keys
    {
        key(Key1; CALYEAR, CALWEEK, OPCO, COUNTRY, BRAND, LINEXTEN, MARKET, PRODTYP, YVERSION, "CIL ID", "Business Type", P_PACKTYPE, CHANNEL)
        {
        }
    }

    fieldgroups
    {
    }
}

