table 50099 "Request Order Line Archive FND"
{
    // version HEI.01

    // HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Table created

    Caption = 'Request Order Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(4; Description; Text[50])
        {
            Editable = false;
        }
        field(5; "Unit of Measure Code"; Text[10])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = FIELD("Item No."));
        }
        field(6; "Requested Quantity"; Decimal)
        {
        }
        field(7; "Actual Qty."; Decimal)
        {
        }
        field(8; "Outstanding Qty."; Decimal)
        {
            Editable = false;
        }
        field(9; "From-Code"; Code[10])
        {
            TableRelation = Location;
        }
        field(20; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Quantity per Unit of Measure';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        ERROR(Text001, TABLECAPTION);
    end;

    var
        Text001: TextConst ENU = 'You cannot delete a %1.', FRA = 'Vous ne pouvez pas renommer l''enregistrement %1.';
}

