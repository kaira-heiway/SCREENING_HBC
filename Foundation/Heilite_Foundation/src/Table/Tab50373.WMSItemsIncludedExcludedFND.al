table 50373 "WMS Items Included/ExcludedFND"
{
    // Heilite Navision Old Id - 50175
    // HEI.01 CHG2077574 IBM GAVANM01 04.09.2020 # WMS Integration - new table for include/exclude items to be exported

    // BC Upgrade MISHRS14 >>
    // Changed length of Data type - text from 50 to 100 due to warning in field 20.
    // BC Upgrade MISHRS14 <<

    // BC UPGRADE PATELS08 >>
    // # Table moved from INTERFACES to Foundation Layer
    // # Table name changed from "WMS Items Included/Excluded" to "WMS Items Included/ExcludedFND"
    // BC UPGRADE PATELS08 <<

    fields
    {
        field(10; "Item Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Item;
        }

        // BC Upgrade MISHRS14 >>
        // Changed length of Data type - text from 50 to 100 due to warning.
        //field(20; Description; Text[50])
        field(20; Description; Text[100])
        // BC Upgrade MISHRS14 <<
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Item Category"; Code[20])
        {
            CalcFormula = Lookup(Item."Item Category Code" WHERE("No." = FIELD("Item Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; Included; Boolean)
        {

            trigger OnValidate();
            begin
                if Included then
                    Excluded := false;
            end;
        }
        field(50; Excluded; Boolean)
        {

            trigger OnValidate();
            begin
                if Excluded then
                    Included := false;
            end;
        }
    }

    keys
    {
        key(Key1; "Item Code")
        {
        }
    }

    fieldgroups
    {
    }
}

