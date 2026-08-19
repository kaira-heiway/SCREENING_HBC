table 50088 "General OpCo Setup FND"
{
    // version HEI.22

    // HEI.01 FDD-AL-GAPLOG05 IBM NASTAA02 29.09.2017 # Unloading Note template for Algeria
    //   # New field created to store the Report ID which will be used for Unloading Note in Sales Return Order
    // HEI.02 FDD-PA-HURGAP010 IBM HORTOC01 16.10.2017
    //   # New fields used for Import Payroll Panama
    // HEI.03  IBM HORTOC01 13.11.2017 # add new field for Payroll import
    // HEI.04 FDD-PTPGAP072 IBM NASTAA02 31.01.2017 # Cashier Order Creation
    //   # Field Deleted: 9 - Cashier Order Report ID
    // HEI.05 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Field created: 10 - Enable Request Order
    // HEI.06 FDD-BA-PRDGAP01 IBM POSTOI01 12.07.2018
    //   # new field created : 54 Spare Part Consumption boolean - for spare parts Bahamas functionality
    // 
    // HEI.05 FDD-BA-PURGAP03- Bottle Recycling Centre - V2.6 IBM NAIKH01 11.10.2018
    //   # Added new Field "BRC Location Code"
    // 
    // HEI.06 FDD-BA-PURGAP03- Bottle Recycling Centre - V2.6 and BRD V4.02 25-07-2018_Local Vendor type-Vendor Category and label Vendor,  IBM NAIKH01 16.10.2018
    //   # Added New field "Local Vendor type" and "Item Category"
    // 
    // HEI.08 RFC-CHG0255624 IBM.LS 15.11.2018
    //   # Increased the following fields length to 250 from 10. Changed the ValidateTableRelation and TestTableRelation properties too.
    //   # "RC Brewing Zone code", "RC F&Mat Zone Code", "RC F&Mix Zone Code" and "RC Packaging Zone Code".
    // HEI.10 FDD BA-PTPGAP03 IBM NASTAA02 04.02.2019 # Digital Checks Printout
    //   # New Field created: 11 - Enable Digital Check Printout
    // HEI.11 BRD HT434 IBM GAVANM01 21.06.2019
    //   # New Field created: 78 - Deposit% on the net price
    // HEI.12 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2019 # Maraki POS Interface
    //   # New Field created: 12 - Enable Send to Maraki
    // HEI.13 FDD-HT915 IBM NASTAA02 27.09.2019 # OtC Billing – Invoice Layout local requirements for Domestic Invoice/Credit Memo/Sundry, and Export Invoice
    //   # New Fields created: 100 - Bank Name 3
    //                         101 -Bank Account No. 3
    //                         102 - IBAN 3
    //                         103 - SWIFT Code 3
    //                         104 - Bank Name 4
    //                         105 - Bank Account No. 4
    //                         106 - IBAN 4
    //                         107 - SWIFT Code 4
    //                         108 - Bank Name 5
    //                         109 - Bank Account No. 5
    //                         110 - IBAN 5
    //                         111 - SWIFT Code 5
    //                         112 - Bank Name 6
    //                         113 - Bank Account No. 6
    //                         114 - IBAN 6
    //                         115 - SWIFT Code 6
    //                         116 - Report Invoice Type 3
    //                         117 - Report Invoice Type 4
    //                         118 - Report Invoice Type 5
    //                         119 - Report Invoice Type 6
    //   # New Functions created: "CheckIBAN", "IBANError", "ConvertIBAN", "CalcModulus", "ConvertLetter"
    // HEI.15 FDD-HT1139A IBM NASTAA02 12.05.2020 # DRC - BVM Interface
    //   # New Field created: 14 - Enable BVM Integration
    // HEI.16 CHG2085435 IBM GAVANM01 25.11.2020 - HT1773 Sales documents layout
    //   # new field added: 120-Currency 3
    //   # length increased to 50 for the field 101 - Bank Account No. 3
    // HEI.17 CHG2135905 IBM BHATTA09 07.01.2022 # HB2663 Payment remittance advice – French translation
    //   # New field added: 121-French Payment Remittance
    //   # New field added: 122-Payment Remittance Language
    // HEI.18 CHG2171687 IBM SISUM01 06/03/2023 #add new field for filter pattern on EBF Matrix
    // HEI.19 CHG2171687 IBM SISUM01 19/05/2023 HB3907 EBF Matrix
    //   #add new field to activate the new version - Id 128
    // HEI.20 IBM YADAVM09 12/10/23 CHG2218600_HB3954 DRC Interredional transfer exclusion from WIS MSV
    // #Added new field Exclude Interreg. WIS and MSV
    // HEI.21 CHG2171687 IBM SISUM01 22/11/2023 HB3907 EBF Matrix
    //   #add new field to skip validation of dimension value when the EBF Matrix Setup is updated/created - Id 130
    // HEI.22 CHG2244079 IBM VERMAA03 13.06.2024 HB3802 Remittance advice – Spanish translation
    //   #New fields added: 131 - "Spanish Payment Remittance"
    //   #New fields added: 132 - "Payment Remittance Language Sp"


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Payroll Report ID"; Integer)
        {
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = FILTER(Report));
        }
        field(3; "Unloading Note Report ID"; Integer)
        {
            Description = 'HEI.01';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = FILTER(Report));
        }
        field(4; "RC Location Code"; Code[10])
        {
            Description = 'Role';
            TableRelation = Location.Code;
        }
        field(5; "RC Brewing Zone code"; Code[250])
        {
            Description = 'Role,HEI.08';
            TableRelation = Zone.Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(6; "RC F&Mat Zone Code"; Code[250])
        {
            Description = 'Role,HEI.08';
            TableRelation = Zone.Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(7; "RC F&Mix Zone Code"; Code[250])
        {
            Description = 'Role,HEI.08';
            TableRelation = Zone.Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(8; "RC Packaging Zone Code"; Code[250])
        {
            Description = 'Role,HEI.08';
            TableRelation = Zone.Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(10; "Enable Request Order"; Boolean)
        {
            Description = 'HEI.05';
        }
        field(11; "Enable Digital Check Printout"; Boolean)
        {
            Description = 'HEI.10';
        }
        field(12; "Enable Send to Maraki"; Boolean)
        {
            Description = 'HEI.12';
        }
        field(14; "Enable BVM Integration"; Boolean)
        {
            Caption = 'Enable BVM Integration';
            Description = 'HEI.15';
        }
        field(50; "Export Path"; Text[100])
        {
            CaptionML = ENU = 'Payroll Export Path',
                        FRA = 'Payroll Export Path',
                        ESA = 'Payroll Export Path';
            Description = 'HEI.02';
        }
        field(51; "Gen. Journal Template"; Code[10])
        {
            Caption = 'Payroll Gen. Journal Template';
            Description = 'HEI.02';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(52; "Gen. Journal Batch"; Code[10])
        {
            Caption = 'Payroll Gen. Journal Batch';
            Description = 'HEI.02';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = FIELD("Gen. Journal Template"));
        }
        field(53; "Employee Payroll Dimension"; Code[20])
        {
            Caption = 'Employee Payroll Dimension';
            Description = 'HEI.03';
            TableRelation = Dimension.Code;
        }
        field(54; "Spare Part Consumption"; Boolean)
        {
            Description = 'HEI.06';
        }
        field(73; "BRC Location Code"; Code[10])
        {
            Description = 'HEI.05';
            TableRelation = Location;
        }
        field(74; "Local Vendor type"; Code[10])
        {
            Description = 'HEI.06';
            TableRelation = "Local Vendor Type FND";
        }
        field(75; "Item Category"; Code[20])
        {
            Description = 'HEI.06';
            TableRelation = "Item Category";
        }
        field(78; "Deposit% on the net price"; Integer)
        {
            Description = 'HEI.11';
            MaxValue = 100;
        }
        field(100; "Bank Name 3"; Text[30])
        {
            CaptionML = ENU = 'Bank Name 3',
                        FRA = 'Nom de la banque 3';
            Description = 'HEI.13';
        }
        field(101; "Bank Account No. 3"; Text[50])
        {
            CaptionML = ENU = 'Bank Account No. 3',
                        FRA = 'N° compte bancaire 3';
            Description = 'HEI.13,HEI.16';
        }
        field(102; "IBAN 3"; Code[50])
        {
            CaptionML = ENU = 'IBAN 3',
                        FRA = 'IBAN 3';
            Description = 'HEI.13';

            trigger OnValidate();
            begin
                CheckIBAN("IBAN 3");
            end;
        }
        field(103; "SWIFT Code 3"; Code[20])
        {
            CaptionML = ENU = 'SWIFT Code 3',
                        FRA = 'Code SWIFT 3';
            Description = 'HEI.13';
        }
        field(104; "Bank Name 4"; Text[30])
        {
            CaptionML = ENU = 'Bank Name 4',
                        FRA = 'Nom de la banque 4';
            Description = 'HEI.13';
        }
        field(105; "Bank Account No. 4"; Text[20])
        {
            CaptionML = ENU = 'Bank Account No. 4',
                        FRA = 'N° compte bancaire 4';
            Description = 'HEI.13';
        }
        field(106; "IBAN 4"; Code[50])
        {
            CaptionML = ENU = 'IBAN 4',
                        FRA = 'IBAN 4';
            Description = 'HEI.13';

            trigger OnValidate();
            begin
                CheckIBAN("IBAN 4");
            end;
        }
        field(107; "SWIFT Code 4"; Code[20])
        {
            CaptionML = ENU = 'SWIFT Code 4',
                        FRA = 'Code SWIFT 4';
            Description = 'HEI.13';
        }
        field(108; "Bank Name 5"; Text[30])
        {
            CaptionML = ENU = 'Bank Name 5',
                        FRA = 'Nom de la banque 5';
            Description = 'HEI.13';
        }
        field(109; "Bank Account No. 5"; Text[20])
        {
            CaptionML = ENU = 'Bank Account No. 5',
                        FRA = 'N° compte bancaire 5';
            Description = 'HEI.13';
        }
        field(110; "IBAN 5"; Code[50])
        {
            CaptionML = ENU = 'IBAN 5',
                        FRA = 'IBAN 5';
            Description = 'HEI.13';

            trigger OnValidate();
            begin
                CheckIBAN("IBAN 5");
            end;
        }
        field(111; "SWIFT Code 5"; Code[20])
        {
            CaptionML = ENU = 'SWIFT Code 5',
                        FRA = 'Code SWIFT 5';
            Description = 'HEI.13';
        }
        field(112; "Bank Name 6"; Text[30])
        {
            CaptionML = ENU = 'Bank Name 6',
                        FRA = 'Nom de la banque 6';
            Description = 'HEI.13';
        }
        field(113; "Bank Account No. 6"; Text[20])
        {
            CaptionML = ENU = 'Bank Account No. 6',
                        FRA = 'N° compte bancaire 6';
            Description = 'HEI.13';
        }
        field(114; "IBAN 6"; Code[50])
        {
            CaptionML = ENU = 'IBAN 6',
                        FRA = 'IBAN 6';
            Description = 'HEI.13';

            trigger OnValidate();
            begin
                CheckIBAN("IBAN 6");
            end;
        }
        field(115; "SWIFT Code 6"; Code[20])
        {
            CaptionML = ENU = 'SWIFT Code 6',
                        FRA = 'Code SWIFT 6';
            Description = 'HEI.13';
        }
        field(116; "Report Invoice Type 3"; Option)
        {
            Caption = 'Report Invoice Type 3';
            Description = 'HEI.13';
            OptionCaption = '" ,Invoice,Sundry,Export"';
            OptionMembers = " ",Invoice,Sundry,Export;
        }
        field(117; "Report Invoice Type 4"; Option)
        {
            Caption = 'Report Invoice Type 4';
            Description = 'HEI.13';
            OptionCaption = '" ,Invoice,Sundry,Export"';
            OptionMembers = " ",Invoice,Sundry,Export;
        }
        field(118; "Report Invoice Type 5"; Option)
        {
            Caption = 'Report Invoice Type 5';
            Description = 'HEI.13';
            OptionCaption = '" ,Invoice,Sundry,Export"';
            OptionMembers = " ",Invoice,Sundry,Export;
        }
        field(119; "Report Invoice Type 6"; Option)
        {
            Caption = 'Report Invoice Type 6';
            Description = 'HEI.13';
            OptionCaption = '" ,Invoice,Sundry,Export"';
            OptionMembers = " ",Invoice,Sundry,Export;
        }
        field(120; "Currency 3"; Code[10])
        {
            Description = 'HEI.16';
            TableRelation = Currency;
        }
        field(121; "French Payment Remittance"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.17';
        }
        field(122; "Payment Remittance Language"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.17';
            TableRelation = Language.Code;
        }
        field(123; "EBF SCOA Range Start Position"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.18';
        }
        field(124; "EBF SCOA Range Digit Nos."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.18';
        }
        field(125; "EBF Operator Filter"; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.18';
        }
        field(126; "EBF Dim Filter Start Position"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.18';
        }
        field(127; "EBF Dim Filter Digit Nos."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.18';
        }
        field(128; "Enable New EBF Matrix Version"; Boolean)
        {
            Caption = 'Enable New EBF Matrix Version';
            DataClassification = ToBeClassified;
            Description = 'HEI.19';
        }
        field(129; "Exclude Interreg. WIS and MSV"; Boolean)
        {
            Caption = 'Exclude Interreg. WIS and MSV';
            DataClassification = ToBeClassified;
            Description = 'HEI.20';
        }
        field(130; "Validate Dimension Value (EBF)"; Boolean)
        {
            Caption = 'Validate Dimension Value (EBF)';
            DataClassification = ToBeClassified;
            Description = 'HEI.21';
        }
        field(131; "Spanish Payment Remittance"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.22';
        }
        field(132; "Payment Remittance Language Sp"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.22';
            TableRelation = Language.Code;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    var
        IBANNotValidErr: Label 'The number that you entered is not a valid International Bank Account Number (IBAN).';
        Text000: TextConst ENU = 'The number that you entered may not be a valid International Bank Account Number (IBAN). Do you want to continue?', FRA = 'Le numéro entré n''est peut-être pas un numéro de compte bancaire international (IBAN) valide. Voulez-vous continuer ?';

    procedure CheckIBAN(IBANCode: Code[100]);
    var
        I: Integer;
        Modulus97: Integer;
    begin
        //HEI.13>>
        if IBANCode = '' then
            exit;
        IBANCode := DELCHR(IBANCode);
        Modulus97 := 97;
        if (STRLEN(IBANCode) <= 5) or (STRLEN(IBANCode) > 34) then
            IBANError();
        ConvertIBAN(IBANCode);
        while STRLEN(IBANCode) > 6 do
            IBANCode := CalcModulus(COPYSTR(IBANCode, 1, 6), Modulus97) + COPYSTR(IBANCode, 7);
        EVALUATE(I, IBANCode);
        if (I mod Modulus97) <> 1 then
            IBANError();
        //HEI.13<<
    end;

    local procedure IBANError();
    begin
        //HEI.13>>
        if GUIALLOWED then begin
            if not CONFIRM(Text000) then
                ERROR('');
        end else
            ERROR(IBANNotValidErr);
        //HEI.13<<
    end;

    local procedure ConvertIBAN(var IBANCode: Code[100]);
    var
        I: Integer;
    begin
        //HEI.13>>
        IBANCode := COPYSTR(IBANCode, 5) + COPYSTR(IBANCode, 1, 4);
        I := 0;
        while I < STRLEN(IBANCode) do begin
            I := I + 1;
            if ConvertLetter(IBANCode, COPYSTR(IBANCode, I, 1), I) then
                I := 0;
        end;
        //HEI.13<<
    end;

    local procedure CalcModulus(Number: Code[10]; Modulus97: Integer): Code[10];
    var
        I: Integer;
    begin
        //HEI.13>>
        EVALUATE(I, Number);
        I := I mod Modulus97;
        if I = 0 then
            exit('');
        exit(FORMAT(I));
        //HEI.13<<
    end;

    local procedure ConvertLetter(var IBANCode: Code[100]; Letter: Code[1]; LetterPlace: Integer): Boolean;
    var
        Letter2: Code[2];
    begin
        //HEI.13>>
        if (Letter >= 'A') and (Letter <= 'Z') then begin
            case Letter of
                'A':
                    Letter2 := '10';
                'B':
                    Letter2 := '11';
                'C':
                    Letter2 := '12';
                'D':
                    Letter2 := '13';
                'E':
                    Letter2 := '14';
                'F':
                    Letter2 := '15';
                'G':
                    Letter2 := '16';
                'H':
                    Letter2 := '17';
                'I':
                    Letter2 := '18';
                'J':
                    Letter2 := '19';
                'K':
                    Letter2 := '20';
                'L':
                    Letter2 := '21';
                'M':
                    Letter2 := '22';
                'N':
                    Letter2 := '23';
                'O':
                    Letter2 := '24';
                'P':
                    Letter2 := '25';
                'Q':
                    Letter2 := '26';
                'R':
                    Letter2 := '27';
                'S':
                    Letter2 := '28';
                'T':
                    Letter2 := '29';
                'U':
                    Letter2 := '30';
                'V':
                    Letter2 := '31';
                'W':
                    Letter2 := '32';
                'X':
                    Letter2 := '33';
                'Y':
                    Letter2 := '34';
                'Z':
                    Letter2 := '35';
            end;
            if LetterPlace = 1 then
                IBANCode := Letter2 + COPYSTR(IBANCode, 2)
            else begin
                if LetterPlace = STRLEN(IBANCode) then
                    IBANCode := COPYSTR(IBANCode, 1, LetterPlace - 1) + Letter2
                else
                    IBANCode :=
                      COPYSTR(IBANCode, 1, LetterPlace - 1) + Letter2 + COPYSTR(IBANCode, LetterPlace + 1);
            end;
            exit(true);
        end;
        if (Letter >= '0') and (Letter <= '9') then
            exit(false);

        IBANError();
        //HEI.13<<
    end;
}

