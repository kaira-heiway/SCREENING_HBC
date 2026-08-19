table 50367 "CIL2 Export Buffer FND"
{
    // version HEI.04

    // HEI:EDD072:1:1 21/12/14 TECTURA.WSA
    // HEI.02 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Migrated table from HEI.2.0 to Base
    // HEI.03 FDD-HB2997 CHG2161959 IBM YADAVM05 02.11.2022
    // # add field BIB Quantity
    // HEI.04 IBM YADAVM09 10/01/23 CHG2234742_System error - We can't download MSV
    // #Change field legth Country 10 to 20 #Field used in report50020 only

    // BC Upgrade Kamnay01 Original(Heilite) Table id 50040
    Caption = 'CIL2 Export Buffer';

    fields
    {
        field(10; Time; Text[7])
        {
            Description = 'HEI.01';
        }
        field(30; "Product Type"; Text[10])
        {
            Description = 'HEI.01';
        }
        field(40; Brand; Text[20])
        {
            Description = 'HEI.01';
        }
        field(50; "Line Extension"; Text[20])
        {
            Description = 'HEI.01';
        }
        field(60; "Pack type"; Text[10])
        {
            Description = 'HEI.01';
        }
        field(70; "Market type"; Text[10])
        {
            Description = 'HEI.01';
        }
        field(80; "Channel category"; Text[25])
        {
            Description = 'HEI.01';
        }
        field(90; Country; Text[20])
        {
            Description = 'HEI.04';
        }
        field(95; "Trading partner"; Text[25])
        {
            Description = 'HEI.01';
        }
        field(100; "CIL ID"; Text[25])
        {
            Description = 'HEI.01';
        }
        field(110; Quantity; Decimal)
        {
            DecimalPlaces = 4 : 4;
            Description = 'HEI.01';
        }
        field(120; "Data Version"; Text[30])
        {
            Description = 'HEI.01';
        }
        field(130; "Business Type"; Text[20])
        {
            Description = 'HEI.01';
        }
        field(131; "BIB Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
    }

    keys
    {
        key(Key1; Time, "Product Type", Brand, "Line Extension", "Pack type", "Market type", "Channel category", Country, "Trading partner", "CIL ID", "Data Version", "Business Type")
        {
        }
    }

    fieldgroups
    {
    }
}

