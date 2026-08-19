tableextension 50261 TransfrShipmentHeaderExtFND extends "Transfer Shipment Header"
{
    //     HEI.05 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
    //   # new field added: 50009 - LSR Order No
    //Bc upgrade SHARMP16-- Inerface realated fields added
    fields
    {
        field(50009; "LSR Order No FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
            Editable = false;
            caption = 'LSR Order No';
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