table 58027 "EBMS Interface Setup INT"
{
    // Heilite Navision Old Id - 50135
    // version HEI.04

    // HEI.01 CHG2151260-HB2788 COSTES04 23.12.2022 Table created
    // HEI.02 CHG2151260 HB2788 COSTES04 02.01.2023 # Burundi Fiscal Invoice
    //   # Field Added
    // HEI.03 CHG2151260 HB2788 COSTES04 06.01.2023 # Burundi Fiscal Invoice
    //   # Field Added
    // HEI.04 CHG2151260 HB2788 COSTES04 10.01.2023 # Burundi Fiscal Invoice
    //   # Change field type


    fields
    {
        field(1; PK; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(2; "EBMS Interface Enabled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Send Invoice Interface"; Code[20])
        {
            Caption = 'Send Invoice Interface';
            DataClassification = ToBeClassified;
            TableRelation = "Interface Setup INT";
        }
        field(4; "Sales Confirmation Interface"; Code[20])
        {
            Caption = 'Sales Confirmation Interface';
            DataClassification = ToBeClassified;
            TableRelation = "Interface Setup INT";
        }
        field(7; "No. of Confirmation Attempts"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Customer Account Group Filter"; Code[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Account Group FND";
            ValidateTableRelation = false;
        }
        field(9; "Item Category Code Filter"; Code[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";
            ValidateTableRelation = false;
        }
        field(20; "Taxpayer System ID"; Text[50])
        {
            Caption = 'Taxpayer System ID';
            DataClassification = CustomerContent;
        }
        field(30; "Send Invoice Interface Res."; Code[20])
        {
            Caption = 'Send Invoice Interface Response';
            DataClassification = CustomerContent;
            TableRelation = "Interface Setup INT";
        }
        field(40; "CT Gen. Prod. Posting Gr."; Code[50])
        {
            Caption = 'CT Gen. Prod. Posting Gr.';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Product Posting Group";
            ValidateTableRelation = false;
        }
        field(50; "TL Gen. Prod. Posting Gr."; Code[50])
        {
            Caption = 'TL Gen. Prod. Posting Gr.';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Product Posting Group";
            ValidateTableRelation = false;
        }
        field(60; "Shipping Cost Item Charge No."; Code[50])
        {
            Caption = 'Shipping Cost Item Charge No.';
            DataClassification = CustomerContent;
            Description = 'HEI.03';
            TableRelation = "Item Charge";
            ValidateTableRelation = false;
        }
        field(70; "VAT Cust. Gen. Prod. P. Gr."; Code[50])
        {
            Caption = 'VAT Cust. Gen. Prod. Posting Gr.';
            DataClassification = CustomerContent;
            Description = 'HEI.03';
            TableRelation = "Gen. Product Posting Group";
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; PK)
        {
        }
    }

    fieldgroups
    {
    }
}

