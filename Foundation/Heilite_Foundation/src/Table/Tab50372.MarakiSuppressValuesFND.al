table 50372 "Maraki Suppress Values FND"
{
    // Heilite Navision Old Id - 50146
    // version HEI.01

    // HEI.01 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New table created to store Maraki Supress Values

    // BC UPGRADE PATELS08 >>
    // # Table moved from INTERFACES to Foundation Layer
    // # Table name changed from "Maraki Suppress Values" to "Maraki Suppress Values FND"
    // BC UPGRADE PATELS08 <<

    Caption = 'Maraki Suppress Values';

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Item,Item Charge';
            OptionMembers = Item,"Item Charge";
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST(Item)) Item
            ELSE IF (Type = CONST("Item Charge")) "Item Charge";

            trigger OnValidate();
            var
                Item: Record Item;
                ItemCharge: Record "Item Charge";
            begin
                if Type = Type::Item then begin
                    Item.GET("No.");
                    Description := Item.Description;
                end else if Type = Type::"Item Charge" then begin
                    ItemCharge.GET("No.");
                    Description := ItemCharge.Description;
                end;
            end;
        }
        field(11; Description; Text[50])
        {
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) Item.Description WHERE("No." = FIELD("No."))
            ELSE IF (Type = CONST("Item Charge")) "Item Charge".Description WHERE("No." = FIELD("No."));
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; Type, "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

