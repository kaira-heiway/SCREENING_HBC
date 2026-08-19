tableextension 50254 PostedWhseRcptHeaderExtFND extends "Posted Whse. Receipt Header"
{
    //     HEI.04 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New field created: 50004 - LSR Order No,  50005 - LSR Receipt No.
    //BC Upgrade SHARP16--- Interface related fields shifted from main Ext

    // BC Upgrade MISHRS14 >>
    // Changed table extension name to "PostedWhseReceiptHeaderIntExtFND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    fields
    {
        field(50004; "LSR Order No. FND"; Code[20])
        {
            Caption = 'LSR Order No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50005; "LSR Receipt No. FND"; Code[20])
        {
            Caption = 'LSR Receipt No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}