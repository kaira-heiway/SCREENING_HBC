table 50156 "Global No. Series Line FND"
{
    // version HEI.01

    // HEI.01 FDD-HT817 CHG2034523 IBM GUNERE01 30.10.2019 # Table created
    // HEI.02 FDD-HT923 CHG2034529 IBM GUNERE01 30.10.2019 # Table created

    CaptionML = ENU = 'No. Series Line',
                FRA = 'Ligne souche de n°';
    DataPerCompany = false;
    DrillDownPageID = "Global No. Series Lines";
    LookupPageID = "Global No. Series Lines";

    fields
    {
        field(1; "Series Code"; Code[10])
        {
            CaptionML = ENU = 'Series Code',
                        FRA = 'Code souche';
            NotBlank = true;
            TableRelation = "Global No. Series FND";
        }
        field(2; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.',
                        FRA = 'N° ligne';
        }
        field(3; "Starting Date"; Date)
        {
            CaptionML = ENU = 'Starting Date',
                        FRA = 'Date début';
        }
        field(4; "Starting No."; Code[20])
        {
            CaptionML = ENU = 'Starting No.',
                        FRA = 'N° début';

            trigger OnValidate();
            begin
                UpdateLine("Starting No.", FIELDCAPTION("Starting No."));
            end;
        }
        field(5; "Ending No."; Code[20])
        {
            CaptionML = ENU = 'Ending No.',
                        FRA = 'N° fin';

            trigger OnValidate();
            begin
                if "Ending No." = '' then
                    "Warning No." := '';
                UpdateLine("Ending No.", FIELDCAPTION("Ending No."));
                VALIDATE(Open);
            end;
        }
        field(6; "Warning No."; Code[20])
        {
            CaptionML = ENU = 'Warning No.',
                        FRA = 'N° alerte';

            trigger OnValidate();
            begin
                TESTFIELD("Ending No.");
                UpdateLine("Warning No.", FIELDCAPTION("Warning No."));
            end;
        }
        field(7; "Increment-by No."; Integer)
        {
            CaptionML = ENU = 'Increment-by No.',
                        FRA = 'Espace entre n°';
            InitValue = 1;
            MinValue = 1;
        }
        field(8; "Last No. Used"; Code[20])
        {
            CaptionML = ENU = 'Last No. Used',
                        FRA = 'Dernier n° utilisé';

            trigger OnValidate();
            begin
                UpdateLine("Last No. Used", FIELDCAPTION("Last No. Used"));
                VALIDATE(Open);
            end;
        }
        field(9; Open; Boolean)
        {
            CaptionML = ENU = 'Open',
                        FRA = 'Ouvert';
            Editable = false;
            InitValue = true;

            trigger OnValidate();
            begin
                Open := ("Ending No." = '') or ("Ending No." <> "Last No. Used");
            end;
        }
        field(10; "Last Date Used"; Date)
        {
            CaptionML = ENU = 'Last Date Used',
                        FRA = 'Dernière date utilisée';
        }
    }

    keys
    {
        key(Key1; "Series Code", "Line No.")
        {
        }
        key(Key2; "Series Code", "Starting Date", "Starting No.")
        {
        }
        key(Key3; "Starting No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        GlobalNoSeriesManagement: Codeunit GlobalNoSeriesManagement;

    local procedure UpdateLine(NewNo: Code[20]; NewFieldName: Text[100]);
    begin
        GlobalNoSeriesManagement.UpdateGlobalNoSeriesLine(Rec, NewNo, NewFieldName);
    end;
}

