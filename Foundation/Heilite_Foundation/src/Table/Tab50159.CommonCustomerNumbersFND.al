table 50159 "Common Customer Numbers FND"
{
    // version HEI.01

    // HEI.01 FDD-HT788 IBM BULIMC01 13.10.2019 #new table created for Customer code sharing

    Caption = 'Common Customer Numbers';
    DataPerCompany = false;
    DrillDownPageID = "Common Customer Numbers";
    LookupPageID = "Common Customer Numbers";

    fields
    {
        field(10; "Company ID"; Text[30])
        {
            Caption = 'Company ID';
            Description = 'HEI.01';
            TableRelation = Company.Name;
        }
        field(20; "Global ID"; Text[250])
        {
            Caption = 'Global ID';
            Description = 'HEI.01';
            //TableRelation = Customer."Customer Description";  // BC Upgrade NANDIS03 - Dependency on Customer extension compilation
        }
        field(30; "Local ID"; Code[20])
        {
            Caption = 'Local ID';
            Description = 'HEI.01';
            TableRelation = Customer."No.";
        }
        field(40; Blocked; Boolean)
        {
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; "Company ID", "Global ID", "Local ID", Blocked)
        {
        }
    }

    fieldgroups
    {
    }

    var
    //MendixInterfaceWebServices: Codeunit "Mendix Interface Web Services";  // BC Upgrade NANDIS03 - Blocked as no usage found
    //CheckCustDuplicatesResult: XMLport "Export GL Without MVMT";  // BC Upgrade NANDIS03 - Blocked as no usage found
}

