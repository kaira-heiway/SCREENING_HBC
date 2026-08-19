table 58058 "B2B Interface Setup INT"
{
    // Heilite Navision Old Id - 50202
    // version HEI.08

    // HEI.01 FDD-HB1234 - CHG2053453 IBM NASTAA02 15.02.2021 # B2B Order Status
    //   # New Table created for B2B Interfaces
    // HEI.02 FDD-HB1281 - CHG2056937 IBM NASTAA02 12.04.2021 # B2B Pricing Interface
    //   # New Fields created: 20 - B2B Pricing Interface Code
    //                         25 - Customer Acc. Group Included
    //                         30 - Run Sales Gross Net Price Rep
    // HEI.03 INC3510045 - CHG2112803 IBM NASTAA02 02.06.2021 # HeiLite to B2B pricing the file generated is very big and can't be sent via Boomi or Solace
    //   # Deleted Field 25 - Customer Acc. Group Included
    //   # Changed Caption of Field 30 - Run Sales Gross Net Price Rep
    //   # New Fields created: 35 - Split Pricing File
    //                         36 - No of Customers per File
    // HEI.04 FDD-HB1281 - CHG2056937 IBM NASTAA02 04.10.2021 # B2B Pricing Interface
    //   # New Field created: 40 - Skip Multi Currency Prices
    // HEI.05 HB2427 - CHG2121928 IBM NASTAA02 20.11.2021 # B2B Invoice API
    //   # New Fields created: 50 - Send all Invoices and Cr Memos
    //                         51 - B2B Invoice /Cr Memo Interface
    // HEI.06 HB2024 - CHG2137488 IBM NASTAA02 06.01.2022 # B2B Credit Limit
    //   # New Field created: 55 - B2B Credit Limit Interface
    // HEI.07 CHG2056939 DEBUSD01 17.10.2022 #Promotion Interface b2b
    //   # New field : 100 - B2B Promotion Interface
    // HEI.08 CHG2174235 IBM COSTES04 20.03.2023 Interface Order Simulation
    //   # new fields Order Simulation Interface, Default Souce System Ident.

    Caption = 'B2B Interface Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(5; "Enable B2B Interfaces"; Boolean)
        {
            Caption = 'Enable B2B Interfaces';
            DataClassification = ToBeClassified;
        }
        field(15; "Pick-up Shipment Method"; Text[250])
        {
            Caption = 'Pick-up Shipment Method';
            DataClassification = ToBeClassified;
            TableRelation = "Shipment Method";
            ValidateTableRelation = false;
        }
        field(20; "B2B Pricing Interface Code"; Code[20])
        {
            Caption = 'B2B Pricing Interface Code';
            DataClassification = ToBeClassified;
            TableRelation = "Interface Setup INT";
        }
        field(30; "Run Sales Gross Net Price Rep"; Boolean)
        {
            Caption = 'Run Sales Gross Net Price Report only for Selected Customers';
            DataClassification = ToBeClassified;
        }
        field(35; "Split Pricing File"; Boolean)
        {
            Caption = 'Split Pricing File';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(36; "No of Customers per File"; Integer)
        {
            Caption = 'No of Customers Sent per File';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            MinValue = 0;
        }
        field(40; "Skip Multi Currency Prices"; Boolean)
        {
            Caption = 'Skip Multi Currency Prices';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50; "Send all Invoices and Cr Memos"; Boolean)
        {
            Caption = 'Send all Invoices and Credit Memos';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
        }
        field(51; "B2B Invoice /Cr Memo Interface"; Code[20])
        {
            Caption = 'B2B Invoice /Credit Memo Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
            TableRelation = "Interface Setup INT";
        }
        field(55; "B2B Credit Limit Interface"; Code[20])
        {
            Caption = 'B2B Credit Limit Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
            TableRelation = "Interface Setup INT";
        }
        field(100; "B2B Promotion Interface"; Code[20])
        {
            Caption = 'B2B Promotion Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
            TableRelation = "Interface Setup INT";
        }
        field(110; "Order Simulation Interface"; Code[20])
        {
            Caption = 'Order Simulation Interface';
            DataClassification = CustomerContent;
            Description = 'HEI.08';
            TableRelation = "Interface Setup INT";
        }
        field(120; "Default Souce System Ident."; Code[10])
        {
            Caption = 'Default Source System Identifier';
            DataClassification = CustomerContent;
            Description = 'HEI.08';
            TableRelation = "Source Sys Identifier API FND";
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

