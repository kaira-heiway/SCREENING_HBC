table 55005 "Item Attribute CIL Code RTR"
{
    // version HEI.01

    // HEI.01 FDD-PRDGAP043 IBM LAZARE02 03.11.2017 # New table for mapping item attributes to CIL Code

    // BC Upgrade Kamnay01 Original(Heilite) Table id 50054


    fields
    {
        field(1; "Attribute ID"; Integer)
        {
            Caption = 'Attribute ID';
            TableRelation = "Item Attribute";

            trigger OnValidate();
            var
                ItemAttribute: Record "Item Attribute";
            begin
                if "Attribute ID" <> xRec."Attribute ID" then
                    VALIDATE("Attribute Value ID", 0);
            end;
        }
        field(2; "Attribute Name"; Text[250])
        {
            CalcFormula = Lookup("Item Attribute".Name WHERE(ID = FIELD("Attribute ID")));
            Caption = 'Attribute Name';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup();
            var
                ItemAttribute: Record "Item Attribute";
                ItemAttributes: Page "Item Attributes";
                AttributeID: Integer;
            begin
            end;
        }
        field(3; "Attribute Value ID"; Integer)
        {
            Caption = 'Attribute Value ID';
            TableRelation = "Item Attribute Value".ID WHERE("Attribute ID" = FIELD("Attribute ID"));
        }
        field(4; "Attribute Value"; Text[250])
        {
            CalcFormula = Lookup("Item Attribute Value".Value WHERE("Attribute ID" = FIELD("Attribute ID"),
                                                                     ID = FIELD("Attribute Value ID")));
            Caption = 'Attribute Value';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup();
            var
                ItemAttributeValue: Record "Item Attribute Value";
            begin
            end;
        }
        field(11; "CIL ID Code"; Code[10])
        {
            CaptionML = ENU = 'CIL ID Code',
                        FRA = 'CIL ID Code';
            TableRelation = "CIL Code RTR";
        }
        field(12; "CIL ID2 Code"; Code[10])
        {
            Caption = 'CIL ID2 Code';
            TableRelation = "CIL2 Code RTR";
        }
    }

    keys
    {
        key(Key1; "Attribute ID", "Attribute Value ID")
        {
        }
    }

    fieldgroups
    {
    }
}

