table 50284 "Trans Rcpt Logs (Std Cost) FND"
{
    // version HEI.01

    // HEI.01 CHG2253923 IBM POENAB02 04.12.2024 HB3943 Stock in transit - enablement of updating standard cost
    //   # Object created

    Caption = 'Transfer Receipt Logs (Std. Cost)';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(3; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(6; "Qty."; Decimal)
        {
            Caption = 'Qty.';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(7; "Receiving Location"; Code[10])
        {
            Caption = 'Receiving Location';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(8; "Unit Cost (Receipt)"; Decimal)
        {
            Caption = 'Unit Cost (Receipt)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Description = 'HEI.01';
        }
        field(9; "Standatd Cost (Item)"; Decimal)
        {
            Caption = 'Standatd Cost (Item)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Description = 'HEI.01';
        }
        field(10; "Difference (Per Unit)"; Decimal)
        {
            Caption = 'Difference (Per Unit)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Description = 'HEI.01';
        }
        field(11; "Total Difference"; Decimal)
        {
            Caption = 'Total Difference';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Description = 'HEI.01';
        }
        field(12; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

