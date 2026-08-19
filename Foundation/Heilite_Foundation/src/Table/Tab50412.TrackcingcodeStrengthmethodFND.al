table 50412 "TrackingCode & StrMethod FND"
{
    Caption = 'TrackingCode & StrengthMethod';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Tracking Code FND"; Code[20])
        {
            Caption = 'Tracking Code';
        }
        field(2; "Strength Method FND"; Text[20])
        {
            Caption = 'Strength Method';

        }
        field(3; "New Tracking code FND"; Code[20])
        {
            Caption = 'New Tracking code';
        }
    }
    keys
    {
        key(PK; "Tracking Code FND", "Strength Method FND", "New Tracking code FND")
        {
            Clustered = true;
        }
    }
}
