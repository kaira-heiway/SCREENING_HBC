table 50374 "LSR Master Inc/Exc FND"
{
    // Heilite Navision Old Id - 50184
    // version HEI.01

    // HEI.01 FDD-HB899 - CHG2044703 IBM GAVANM01 13.12.2020 # New POS System Required for OPCO
    //   # New Table created for LSR Interfaces

    // BC UPGRADE PATELS08 >>
    // # Table moved from Interfaces to Foundation Layer
    // # Table name changed from "LSR Master Included/Excluded" to "LSR Master Inc/Exc FND"
    // BC UPGRADE PATELS08 <<

    Caption = 'LSR Master Included/Excluded';
    DataCaptionFields = Type, "Code";

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Item,Customer,Vendor';
            DataClassification = ToBeClassified;
            OptionMembers = Item,Customer,Vendor;
        }
        field(5; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = IF (Type = CONST(Item)) Item
            ELSE IF (Type = CONST(Customer)) Customer
            ELSE IF (Type = CONST(Vendor)) Vendor;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                case Type of
                    Type::Item:
                        if Item.GET(Code) then
                            VALIDATE(Description, Item.Description);
                    Type::Customer:
                        if Customer.GET(Code) then
                            VALIDATE(Description, Customer.Name);
                    Type::Vendor:
                        if Vendor.GET(Code) then
                            VALIDATE(Description, Vendor.Name);
                    else
                        VALIDATE(Description);
                end;
            end;
        }
        field(10; Description; Text[50])
        {
            Editable = false;
        }
        field(15; Included; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                Excluded := not Included;
            end;
        }
        field(20; Excluded; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = true;

            trigger OnValidate();
            begin
                Included := not Excluded
            end;
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
        Customer: Record Customer;
        Vendor: Record Vendor;
}

