tableextension 58021 "ReturnReceiptHeaderIntExt_INT" extends "Return Receipt Header"
{
    //     HEI.06 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Added field "Source System Identifier"
    // HEI.09 CHG2210794 SAHAL01 15.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50078 - Zycus GR UUID
    //                         50079 - Zycus GR Cancel UUID
    //                         50081 - PO Transaction Interface Zycus
    //                         50082 - GR Transaction Interface Zycus
    //                         50085 - Processed PO Transaction Zycus
    //                         50086 - Processed GR Transaction Zycus
    fields
    {
        field(50075; "Zycus Order No. INT"; Code[20])
        {
            Caption = 'Zycus Order No.';
            Description = 'HEI.09';
            Editable = false;
        }
        field(50078; "Zycus GR UUID INT"; Text[50])
        {
            Caption = 'Zycus GR UUID';
            Description = 'HEI.09';
            Editable = false;
        }
        field(50079; "Zycus GR Cancel UUID INT"; Text[50])
        {
            Caption = 'Zycus GR Cancel UUID';
            Description = 'HEI.09';
            Editable = false;
        }
        field(50081; "PO Transaction IntF. Zycus INT"; Code[20])
        {
            Caption = 'PO Transaction Interface Zycus';
            Description = 'HEI.09';
            Editable = false;
            TableRelation = "Interface Setup INT";
        }
        field(50082; "GR Transaction Intf. Zycus INT"; Code[20])
        {
            Caption = 'GR Transaction Interface Zycus';
            Description = 'HEI.09';
            Editable = false;
            TableRelation = "Interface Setup INT";
        }
        field(50085; "Processed PO Trans. Zycus INT"; Boolean)
        {
            Caption = 'Processed PO Transaction Zycus';
            Description = 'HEI.09';
            Editable = false;
        }
        field(50086; "Processed GR Trans. Zycus INT"; Boolean)
        {
            Caption = 'Processed GR Transaction Zycus';
            Description = 'HEI.09';
            Editable = false;
        }
        field(50060; "Source System Identifier INT"; Code[10])
        {
            Caption = 'Source System Identifier';
            Description = 'HEI.06';
            Editable = false;
            TableRelation = "Source Sys Identifier API FND";
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