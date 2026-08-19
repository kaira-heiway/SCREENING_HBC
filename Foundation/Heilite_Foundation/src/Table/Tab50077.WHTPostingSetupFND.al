table 50077 "WHT Posting Setup FND"
{
    // version HEI.01,WHT

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # Object created
    // HEI.02 CHG2057437 IBM POENAB02 28.04.2020 # FDD_HT1104_DRC_WHT functionality enhancement
    //   # New field: 26 "WHT Bearer"
    //   # Code added in
    //     # WHT Bearer - OnValidate
    //     # Realized WHT Type - OnValidate
    // HEI.03 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field created: 30- CAD Account

    DrillDownPageID = "WHT Posting Setup List";
    LookupPageID = "WHT Posting Setup List";

    fields
    {
        field(1; "WHT Business Posting Group"; Code[10])
        {
            CaptionML = ENU = 'WHT Business Posting Group',
                        ENA = 'WHT Business Posting Group';
            TableRelation = "WHT Business Posting Group FND";
        }
        field(2; "WHT Product Posting Group"; Code[10])
        {
            CaptionML = ENU = 'WHT Product Posting Group',
                        ENA = 'WHT Product Posting Group';
            TableRelation = "WHT Product Posting Group FND";
        }
        field(3; "WHT %"; Decimal)
        {
            CaptionML = ENU = 'WHT %',
                        ENA = 'WHT %';
        }
        field(4; "Prepaid WHT Account Code"; Code[20])
        {
            CaptionML = ENU = 'Prepaid WHT Account Code',
                        ENA = 'Prepaid WHT Account Code';
            TableRelation = "G/L Account";
        }
        field(5; "Payable WHT Account Code"; Code[20])
        {
            CaptionML = ENU = 'Payable WHT Account Code',
                        ENA = 'Payable WHT Account Code';
            TableRelation = "G/L Account";
        }
        field(7; "WHT Report"; Option)
        {
            CaptionML = ENU = 'WHT Report',
                        ENA = 'WHT Report';
            OptionCaptionML = ENU = ' ,Por Ngor Dor 1,Por Ngor Dor 2,Por Ngor Dor 3,Por Ngor Dor 53,Por Ngor Dor 54',
                              ENA = ' ,Por Ngor Dor 1,Por Ngor Dor 2,Por Ngor Dor 3,Por Ngor Dor 53,Por Ngor Dor 54';
            OptionMembers = " ","Por Ngor Dor 1","Por Ngor Dor 2","Por Ngor Dor 3","Por Ngor Dor 53","Por Ngor Dor 54";
        }
        field(8; "WHT Report Line No. Series"; Code[10])
        {
            CaptionML = ENU = 'WHT Report Line No. Series',
                        ENA = 'WHT Report Line No. Series';
            TableRelation = "No. Series";
        }
        field(9; "Revenue Type"; Code[10])
        {
            CaptionML = ENU = 'Revenue Type',
                        ENA = 'Revenue Type';
            TableRelation = "WHT Revenue Types FND";
        }
        field(10; "Bal. Prepaid Account Type"; Option)
        {
            CaptionML = ENU = 'Bal. Prepaid Account Type',
                        ENA = 'Bal. Prepaid Account Type';
            OptionCaptionML = ENU = 'Bank Account,G/L Account',
                              ENA = 'Bank Account,G/L Account';
            OptionMembers = "Bank Account","G/L Account";
        }
        field(11; "Bal. Prepaid Account No."; Code[20])
        {
            CaptionML = ENU = 'Bal. Prepaid Account No.',
                        ENA = 'Bal. Prepaid Account No.';
            TableRelation = IF ("Bal. Prepaid Account Type" = CONST("Bank Account")) "Bank Account"
            else IF ("Bal. Prepaid Account Type" = CONST("G/L Account")) "G/L Account";
        }
        field(12; "Bal. Payable Account Type"; Option)
        {
            CaptionML = ENU = 'Bal. Payable Account Type',
                        ENA = 'Bal. Payable Account Type';
            OptionCaptionML = ENU = 'Bank Account,G/L Account',
                              ENA = 'Bank Account,G/L Account';
            OptionMembers = "Bank Account","G/L Account";
        }
        field(13; "Bal. Payable Account No."; Code[20])
        {
            CaptionML = ENU = 'Bal. Payable Account No.',
                        ENA = 'Bal. Payable Account No.';
            TableRelation = IF ("Bal. Payable Account Type" = CONST("Bank Account")) "Bank Account"
            else IF ("Bal. Payable Account Type" = CONST("G/L Account")) "G/L Account";
        }
        field(20; "Purch. WHT Adj. Account No."; Code[20])
        {
            CaptionML = ENU = 'Purch. WHT Adj. Account No.',
                        ENA = 'Purch. WHT Adj. Account No.';
            TableRelation = "G/L Account";
        }
        field(21; "Sales WHT Adj. Account No."; Code[20])
        {
            CaptionML = ENU = 'Sales WHT Adj. Account No.',
                        ENA = 'Sales WHT Adj. Account No.';
            TableRelation = "G/L Account";
        }
        field(22; Sequence; Integer)
        {
            CaptionML = ENU = 'Sequence',
                        ENA = 'Sequence';
        }
        field(23; "Realized WHT Type"; Option)
        {
            CaptionML = ENU = 'Realized WHT Type',
                        ENA = 'Realised WHT Type';
            OptionCaptionML = ENU = ' ,Invoice,Payment,Earliest',
                              ENA = ' ,Invoice,Payment,Earliest';
            OptionMembers = " ",Invoice,Payment,Earliest;

            trigger OnValidate();
            begin
                //HEI.02>>
                if (xRec."Realized WHT Type" = xRec."Realized WHT Type"::Payment) and
                  (xRec."Realized WHT Type" <> Rec."Realized WHT Type") then begin
                    "WHT Bearer" := "WHT Bearer"::Vendor;
                    MODIFY();
                    MESSAGE(Text50001);
                end;
                //HEI.02<<
            end;
        }
        field(24; "WHT Minimum Invoice Amount"; Decimal)
        {
            CaptionML = ENU = 'WHT Minimum Invoice Amount',
                        ENA = 'WHT Minimum Invoice Amount';
        }
        field(25; "WHT Calculation Rule"; Option)
        {
            CaptionML = ENU = 'WHT Calculation Rule',
                        ENA = 'WHT Calculation Rule';
            OptionCaptionML = ENU = 'Less than,Less than or equal to,Equal to,Greater than,Greater than or equal to',
                              ENA = 'Less than,Less than or equal to,Equal to,Greater than,Greater than or equal to';
            OptionMembers = "Less than","Less than or equal to","Equal to","Greater than","Greater than or equal to";
        }
        field(26; "WHT Bearer"; Option)
        {
            Caption = 'WHT Bearer';
            Description = 'HEI.02';
            OptionCaption = 'Vendor,Opco';
            OptionMembers = Vendor,Opco;

            trigger OnValidate();
            begin
                //HEI.02>>
                if ("WHT Bearer" = "WHT Bearer"::Opco) and ("Realized WHT Type" <> "Realized WHT Type"::Payment) then
                    ERROR(Text50000);
                //HEI.02<<
            end;
        }
        field(30; "CAD Account"; Code[20])
        {
            Caption = 'CAD Account';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "WHT Business Posting Group", "WHT Product Posting Group")
        {
        }
        key(Key2; "WHT Business Posting Group", Sequence)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text50000: Label 'You cannot select "Opco" because "Realized WHT Type" is not Payment!';
        Text50001: Label '"""WHT Bearer"" was changed to Vendor!"';
}

