tableextension 50127 NoSeriesLineExtFND extends "No. Series Line"
{
    //HEI.01 Defect#1959 IBM LAZARE02 12.04.2018
    //# Add dummy fields for dummy lines in order to combine multiple records into one SQL data page; purpose is to reduce locks
    // New Extension created - //BC Upgrade SHARMP16
    fields
    {
        field(50000; "Dummy FND"; Boolean)
        {
            CaptionML = ENU = 'Dummy';
            DataClassification = CustomerContent;

        }
        field(50001; "Dummy 1 FND"; Text[250])
        {
            CaptionML = ENU = 'Dummy 1';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(50002; "Dummy 2 FND"; Text[250])
        {
            CaptionML = ENU = 'Dummy 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(50003; "Dummy 3 FND"; Text[250])
        {
            CaptionML = ENU = 'Dummy 3';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(50004; "Dummy 4 FND"; Text[250])
        {
            CaptionML = ENU = 'Dummy 4';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
    }

    keys
    {
    }

    fieldgroups
    {

    }

    var
        myInt: Integer;
}