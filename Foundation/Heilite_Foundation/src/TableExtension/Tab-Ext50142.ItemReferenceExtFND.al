tableextension 50142 ItemReferenceExtFND extends "Item Reference"
{
    //BC Upgrade PATHAA02-15-09-25
    //Table 5717 from NAV-Item Cross Reference is deprecated in BC and it is replaced with T5777-Item Reference 
    // HEI.01 FDD-GAPID043 IBM LAZARE02 06.07.2017
    // # New field: EAN Category Code
    // # Changed caption of Cross-Reference No. to EAN

    fields
    {
        field(50000; "EAN Category Code FND"; Code[20])
        {
            Caption = 'EAN Category Code';
            DataClassification = ToBeClassified;
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