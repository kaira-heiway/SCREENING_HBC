table 58050 "LSR Interface Setup INT"
{
    // Heilite Navision Old Id - 50183
    // version HEI.09

    // HEI.01 FDD-HB899 - CHG2044703 IBM GAVANM01 13.12.2020 # New POS System Required for OPCO
    //   # New Table created for LSR Interfaces
    // HEI.02 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # New field created: 40 - Fixed Lot No.
    // HEI.03 FDD-HB899 - CHG2093868 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New fields created: 45 - PO Inbound Interface
    //                         50 - PO Outbound Interface
    //                         55 - PR Interface
    //                         57 - Payout Interface
    //                         60 - Order Nos.
    //                         65 - Quote Nos.
    //                         70 - Payouts Gen. Journal Template
    //                         75 - Payouts Gen. Journal Batch
    // HEI.04 FDD-HB899 - CHG2093869 IBM NASTAA02 23.02.2021 # LSR - Transfer and Stock
    //   # New Fields created: 90 - Transfer Shipment Interface
    //                         91 - Transfer Receipt Interface
    //                         92 - Transfer Receipt Interface Out
    //                         93 - Item Reclas. Jnl Template
    //                         94 - Item Reclass. Jnl Batch
    //                         95 - Stock Adjustment Interface
    // HEI.05 FDD-HB899 - CHG2093869 IBM GAVANM1 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
    //   # New fields created: 100 - Transfer Order Interface
    //                         101 - Transfer Order Del. Interface
    //                         102 - Transfer Shipment Out. Interf.
    // HEI.06 HB3459 CHG2213859 IBM COSTES04 15.09.2023 LSR- Customer Ledger entries apply matching entries- Dev
    //   # New field  Source System Identifier
    // HEI.07 CHG2216722 IBM SISUM01 03.10.2023  Request for email functionality for Transfer Order Creation
    //   # New fields: id 103 to 106
    // HEI.08 CHG2227143 IBM COSTE04 14.03.2024 Item Reclass to Support LSR Integrations
    //   # New field added Item Reclass Tracking Code
    // HEI.09 CHG2290087 IBM COSTE04 02.04.2025-HB3894-Payouts Posting from LSR
    //   # Add Balance account from setup


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(5; "Enable LSR Interface"; Boolean)
        {
        }
        field(10; "LSR Item Interface"; Code[20])
        {
            TableRelation = "Interface Setup INT";
        }
        field(15; "LSR Customer Interface"; Code[20])
        {
            TableRelation = "Interface Setup INT";
        }
        field(20; "LSR Vendor Interface"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Interface Setup INT";
        }
        field(25; "Item Category Filter"; Text[100])
        {
            Caption = 'Item Category to be Included';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";
            ValidateTableRelation = false;
        }
        field(30; "Customer Acc Group Filter"; Text[100])
        {
            Caption = 'Customer Account groups to be Included';
            DataClassification = ToBeClassified;
            TableRelation = "Account Group FND";
            ValidateTableRelation = false;
        }
        field(35; "Vendor Acc Group Filter"; Text[100])
        {
            Caption = 'Vendor Account groups to be Included';
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Type FND";
            ValidateTableRelation = false;
        }
        field(40; "Fixed Lot No."; Code[20])
        {
            Caption = 'Fixed Lot No.';
            DataClassification = ToBeClassified;
        }
        field(45; "PO Inbound Interface"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT";
        }
        field(50; "PO Outbound Interface"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT";
        }
        field(55; "PR Interface"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT";
        }
        field(57; "Payout Interface"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT";
        }
        field(60; "Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "No. Series";
        }
        field(65; "Quote Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "No. Series";
        }
        field(70; "Payouts Gen. Journal Template"; Code[10])
        {
            Caption = 'Payouts - Gen. Journal Template';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Gen. Journal Template";
        }
        field(75; "Payouts Gen. Journal Batch"; Code[10])
        {
            Caption = 'Payouts-Gen. Journal Batch';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Payouts Gen. Journal Template"));
        }
        field(90; "Transfer Shipment Interface"; Code[20])
        {
            Caption = 'Transfer Shipment Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(91; "Transfer Receipt Interface"; Code[20])
        {
            Caption = 'Transfer Receipt Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(92; "Transfer Receipt Interface Out"; Code[20])
        {
            Caption = 'Transfer Receipt Interface Outbound';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(93; "Item Reclass. Jnl. Template"; Code[10])
        {
            Caption = 'Item Reclassification Journal Template';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Item Journal Template" WHERE(Type = FILTER(Transfer));
        }
        field(94; "Item Reclass. Jnl. Batch"; Code[10])
        {
            Caption = 'Item Reclassification Journal Batch';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Item Reclass. Jnl. Template"));
        }
        field(95; "Stock Adjustment Interface"; Code[20])
        {
            Caption = 'Stock Adjustment Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(96; "Stock Image Interface"; Code[20])
        {
            Caption = 'Stock Image Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(97; "LSR Central Locations"; Text[250])
        {
            Caption = 'LSR Central Locations';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = Location;
            ValidateTableRelation = false;
        }
        field(98; "Source System Identifier"; Code[10])
        {
            Caption = 'Source System Identifier';
            DataClassification = CustomerContent;
            Description = 'HEI.06';
            TableRelation = "Source Sys Identifier API FND";
        }
        field(100; "Transfer Order Interface"; Code[20])
        {
            Caption = 'Transfer Order Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
            TableRelation = "Interface Setup INT";
        }
        field(101; "Transfer Order Del. Interface"; Code[20])
        {
            Caption = 'Transfer Order Deletion Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
            TableRelation = "Interface Setup INT";
        }
        field(102; "Transfer Shipment Out. Interf."; Code[20])
        {
            Caption = 'Transfer Shipment Outbound Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
            TableRelation = "Interface Setup INT";
        }
        field(103; "Enable Email LSR-TO"; Boolean)
        {
            Caption = 'Enable Email LSR-TO';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(104; "Enable Email LSR-TS-OUT"; Boolean)
        {
            Caption = 'Enable Email LSR-TS-OUT';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(105; "Body Email LSR-TO"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
            TableRelation = "Standard Text".Code;
        }
        field(106; "Body Email LSR-TS-OUT"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
            TableRelation = "Standard Text".Code;
        }
        field(110; "Item Reclass. Tracking Code"; Code[100])
        {
            Caption = 'Item Reclass. Tracking Code';
            DataClassification = CustomerContent;
            Description = 'HEI.08';
            TableRelation = "Item Tracking Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(120; "Payouts Payment Method"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
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

