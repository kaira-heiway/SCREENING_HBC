table 50264 "PAC Post Code FND"
{
    // version HEI.01

    // HEI.01 CHG2194603 HB3289 COSTES04 26.10.2023 Electronic invoice interface
    //   # New object createds

    DataCaptionFields = "Code", Description;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(20; City; Code[35])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(30; District; Code[30])
        {
            Caption = 'District';
            DataClassification = CustomerContent;
        }
        field(40; County; Code[30])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; City, District, County)
        {
        }
    }

    fieldgroups
    {
    }
}

