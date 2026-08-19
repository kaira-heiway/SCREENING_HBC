table 50045 "Account Group FND"
{
    // version HEI.02

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 18.08.2017 # MDM Customer Card
    //   # Object created
    // HEI.02 RFC-CHG0264361 IBM.AB 20.12.2018
    //   # New Fields created: 3 - "Trading End Date Enable"
    // HEI.03 FDD - Indirect Customer Master IBM.NAIKH01 18.01.2019
    //   # New Field created : 4 - "Contract type Editable"
    // HEI.04 RFC-CHG2007388 IBM.KUMARN15 12.09.2019
    //   # New field created: 5 - "Available for Sales Order/Return Order"
    // HEI.05 FDD_HT587 IBM BULIMC01 15/10/2019 #New boolean field added - "Customer Classification"

    Caption = 'Account Group';
    DrillDownPageID = "Account Group List";
    LookupPageID = "Account Group List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "Trading End Date Enable"; Boolean)
        {
            Description = 'HEI.02';
        }
        field(4; "Contract type Editable"; Boolean)
        {
            Description = 'HEI.03';
        }
        field(5; "Avail. for Sales/Return Order"; Boolean)
        {
            Description = 'HEI.04';

            trigger OnValidate();
            var
                Customer: Record Customer;
            begin
                Customer.SETRANGE("Account Group FND", Code);  // BC Upgrade NANDIS03
                Customer.MODIFYALL("Avail.for Sales/ReturnOrd. FND", Rec."Avail. for Sales/Return Order");  // BC Upgrade NANDIS03
            end;
        }
        field(6; "Customer Classification"; Boolean)
        {
            Caption = 'Customer Classification';
            Description = 'HEI.05';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

