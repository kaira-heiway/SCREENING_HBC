table 50240 "C2S/COGS Running Calendar FND"
{
    // version HEI.03

    // HEI.01 CHG2141694 BULIMC01 IBM 13/04/2022#new table created to setup the automatic running f C2S
    // HEI.02 CHG2132673 BULIMC01 IBM 26/04/2022#COGS Allocation
    //   #table name changed to C2S/COGS Running Calendar
    //   #new field added for COGS Allocation - "COGS Job Queue Run"
    //   #boolean field "Job Queue Run" renamed to "C2S Job Queue Run"
    // HEI.03 CHG2162842 IBM SAMANR01 20/06/202022 #C2S optimazation & archiving
    //   # New field created: 9 - Automatic Run Archive Date

    Caption = 'Running Calendar';

    fields
    {
        field(1; "Starting Date"; Date)
        {
            CaptionML = ENU = 'Starting Date',
                        FRA = 'Date début';
            Editable = false;
            NotBlank = true;
        }
        field(2; Name; Text[10])
        {
            CaptionML = ENU = 'Name',
                        FRA = 'Nom';
            Editable = false;
        }
        field(3; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            Editable = false;
        }
        field(4; "Automatic Run Pre-Close Date"; Date)
        {
            Caption = 'Automatic Run Pre-Close Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Manual Run Date"; Date)
        {
            Caption = 'Manual Run Date';
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                if ("Manual Run Date" <> 0D) and ("Manual Run Date" < WORKDATE()) then
                    ERROR(Text001);

                if Rec."Manual Run Date" <> xRec."Manual Run Date" then begin
                    "C2S Job Queue Run" := false;
                    MODIFY();
                end;
            end;
        }
        field(6; "C2S Job Queue Run"; Boolean)
        {
            Caption = 'C2S Job Queue Run';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            Editable = false;
        }
        field(7; "Automatic Run Close Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "COGS Job Queue Run"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            Editable = false;
        }
        field(9; "Automatic Run Archive Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
    }

    keys
    {
        key(Key1; "Starting Date")
        {
        }
        key(Key2; "Ending Date", "Manual Run Date")
        {
        }
        key(Key3; "Automatic Run Pre-Close Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Starting Date", Name, "Ending Date", "Automatic Run Pre-Close Date")
        {
        }
    }

    var
        Text001: TextConst ENU = 'Manual Run Date must be at least today.', FRA = '<Month Text>';
}

