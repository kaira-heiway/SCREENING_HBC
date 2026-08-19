table 58077 "Ibecor Interface Setup INT"
{
    // Heilite Navision Old Id - 80072
    // version HEI.03

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 25.06.2021 Ibecor - PO API
    //   # New Table created for Ibecor PFI Interface
    // HEI.02 CHG2156104 IBM NANDIS01 17.11.2022 #Replace Ibecor Led contracts with Pro-formas
    //   # New field Ibecor PO channel added
    // HEI.03 CHG2255708 SAHAL01 26.08.2024 Ibecor PFI Acknowledgment Interface
    //   # Created New Field: 17 - IBECOR PFI Confmtion Interface


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Interface Enable/Disable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "IBECOR PFI"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Interface Setup INT".Code;
        }
        field(4; "IBECOR PFI Rejection"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Interface Setup INT".Code;
        }
        field(5; "IBECOR PO"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Interface Setup INT".Code;
        }
        field(6; "IBECOR API PO Notification"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Interface Setup INT".Code;
        }
        field(7; "IBC Item Category"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";
            ValidateTableRelation = false;
        }
        field(8; "IBECOR Vendor"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "IBECOR Shipping Agent Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Default CMG"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge";
        }
        field(14; "Ibecor PO Channel"; Code[1])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "Channel FND";
        }
        field(15; "IBECOR PFI Confmtion Interface"; Code[20])
        {
            Caption = 'IBECOR PFI Confirmation Interface';
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

