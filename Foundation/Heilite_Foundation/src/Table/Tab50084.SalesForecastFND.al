table 50084 "Sales Forecast FND"
{
    // version HEI.01

    // HEI.01 FDD-RTRGAP060 IBM HORTOC01 30.08.2017
    //   # New Object created
    // HEI.02 DefectID 746 IBM HORTOC01  18.12.2017
    //   # change doc type


    fields
    {
        field(1; Year; Integer)
        {
            Caption = 'Year';
        }
        field(2; Month; Integer)
        {
            Caption = 'Month';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Document Type"; Option)
        {
            OptionCaption = 'Sales Order,Sales Invoice,Posted Sales Invoice';
            OptionMembers = "Sales Order","Sales Invoice","Posted Sales Invoice";
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = IF ("Document Type" = CONST("Posted Sales Invoice")) "Sales Invoice Header"."No."
            else IF ("Document Type" = FILTER("Sales Order" | "Sales Invoice")) "Sales Header"."No.";
        }
        field(6; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(7; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
        }
        field(8; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(9; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(10; "Brand Code"; Code[20])
        {
            Caption = 'Brand Code';
        }
        field(11; "Brand Code Name"; Text[50])
        {
            Caption = 'Brand Code Name';
        }
        field(12; Volume; Decimal)
        {
            Caption = 'Volume';
        }
        field(13; "Sales Price (WithOut VAT)"; Decimal)
        {
            Caption = 'Sales Price (WithOut VAT)';
        }
        field(14; "Royalty Amount LCY"; Decimal)
        {
            Caption = 'Royalty Amount LCY';
        }
        field(15; "Know-How Amount LCY"; Decimal)
        {
            Caption = 'Know-How Amount LCY';
        }
        field(16; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
        }
        field(17; "Royalty Amount EUR"; Decimal)
        {
            Caption = 'Royalty Amount EUR';
        }
        field(18; "Know-How Amount EUR"; Decimal)
        {
            Caption = 'Know-How Amount EUR';
        }
        field(50000; "Accounting Notes Generated"; Boolean)
        {
            Caption = 'Accounting Notes Generated';
        }
    }

    keys
    {
        key(Key1; Year, Month, "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        SalesForecastLineNo: Integer;
        NothingToPostErr: Label 'There is nothing to post.';
}

