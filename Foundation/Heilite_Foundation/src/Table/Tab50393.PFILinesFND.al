table 50393 "PFI Lines FND"
{
    // Heilite Navision Old Id - 80074
    // version HEI.03

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 25.06.2021 Ibecor - PO API
    //   # New Table created for Ibecor PFI Interface
    // HEI.02 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # New field added - ID - 27 - Direct Multiplier of BO - Decimal
    // HEI.03 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # New field added - ID - 28 - UOM of BO - Code - 10

    // BC Upgrade PATELP08>>
    // Moved table from Interface to Foundation Ext.
    // Changed name of table from "PFI Lines" to "PFI Lines FND"
    // BC Upgrade PATELP08<<

    fields
    {
        field(1; "PFI Document No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Item,"Item Charge";
        }
        field(5; "PFI Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "CMG Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge";
        }
        field(8; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(12; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Unit Of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }
        field(15; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            DataClassification = ToBeClassified;
        }
        field(16; "Price from Blanket Order"; Decimal)
        {
            AutoFormatType = 2;
            DataClassification = ToBeClassified;
        }
        field(17; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Blanket Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Shipping Agent Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent".Code;
        }
        field(24; "Shipping Agent Service Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent Services".Code;
        }
        field(26; "PO Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST(Order),
                                                           "No." = FIELD("PO Number"));
            ValidateTableRelation = false;
        }
        field(27; "Direct Multiplier of BO"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(28; "UOM of BO"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
    }

    keys
    {
        key(Key1; "PFI Document No.", "Line No")
        {
        }
        key(Key2; "PFI Document No.", "Blanket Order No")
        {
        }
    }

    fieldgroups
    {
    }

    procedure SetStyle(): Text;
    begin
        if ("Unit Price" <> "Price from Blanket Order") then
            exit('Unfavorable');
        exit('');
    end;
}

