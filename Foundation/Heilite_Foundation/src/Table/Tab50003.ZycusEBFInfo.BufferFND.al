table 50003 "Zycus EBF Info. Buffer FND"
{
    // Heilite NAV Old Id - 50296
    // version HEI.02

    // HEI.01 CHG2293872 SHARMP16 07.04.2025 Zycus - E2E test for Zycus HL integration - G/L EBF Rule Map
    //   # Created New Table: 50296 - Zycus EBF Information Buffer
    //   # Created New Function - SetLastModifiedDateTime
    //   # Added Code
    // HEI.02 CHG2293872 HB3493 SHARMP16 25.04.2025 Zycus - HL integration - EBF GL Rule Map Delta
    //   # Removed Fields: CTP Code, GL Account Type, Last Modified Date, Last Modified Time
    //   # Created new field: Last Date time modified
    //   # Added Code in SetLastModifiedDateTime

    // BC UPGRADE PATELP08 >>
    // # Tags HEI.01 and HEI.02 added
    // # Created table from NAV object Table 50296 - Zycus EBF Information Buffer
    // BC UPGRADE <<

    Caption = 'Zycus EBF Information Buffer';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            NotBlank = true;
            Editable = false;
        }
        field(2; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            NotBlank = true;
            Editable = false;
            TableRelation = Dimension;
        }
        field(3; "CCC Code"; Code[20])
        {
            Caption = 'CCC Code';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            NotBlank = true;
            Editable = false;
        }
        field(5; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(7; Restriction; Option)
        {
            Caption = 'Restriction';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
            OptionCaption = 'Allowed,Not Allowed,Allowed with Warning';
            OptionMembers = Allowed,"Not Allowed","Allowed with Warning";
        }
        field(9; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            Editable = false;
        }
        field(12; "Last Modified By User"; Code[50])
        {
            Caption = 'Last Modified By User';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            Editable = false;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                UserMgtL: Codeunit "User Management";
            begin
                // HEI.01>>
                // UserMgtL.LookupUserID("Last Modified By User"); // BC Upgrade PATELP08 >> funtion not in bc
                UserMgtL.DisplayUserInformation("Last Modified By User");
                // HEI.01<<
            end;
        }
        field(16; "Last Date time modified"; DateTime)
        {
            Caption = 'Last Date time modified';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // HEI.01>>
        SetLastModifiedDateTime();
        // HEI.01<<
    end;

    trigger OnModify()
    begin
        // HEI.01>>
        SetLastModifiedDateTime();
        // HEI.01<<
    end;

    local procedure SetLastModifiedDateTime()
    var
        DateFilterCalcL: Codeunit "DateFilter-Calc";
        NowL: DateTime;
    begin
        // HEI.01>>
        NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
        // HEI.02>>
        // "Last Date Modified" := DT2DATE(NowL);
        // "Last Time Modified" := DT2TIME(NowL);
        "Last Modified By User" := USERID;
        "Last Date time modified" := NowL;
        // HEI.02<<
        // HEI.01<<
    end;
}
