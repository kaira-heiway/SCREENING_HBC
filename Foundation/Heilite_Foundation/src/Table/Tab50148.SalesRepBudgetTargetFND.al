table 50148 "Sales Rep Budget/Target FND"
{
    // HEI.02 CHG2038267 IBM NASTAA02 28.11.2019 # Suriname KS- Export Sales Reps Actuals
    //   # Removed filter on Sell-to Customer No. from FlowFields: "Actual Invoice Quantity"
    //                                                             "Actual Cr. Memo Quantity"
    //                                                             "Total Actual Value Invoice"
    //                                                             "Total Actual Value Cr. Memo"

    // BC Upgrade SHUKLP03 >>
    // HEI.02 => fields  "Actual Invoice Quantity", "Actual Cr. Memo Quantity", "Total Actual Value Invoice" and "Total Actual Value Cr. Memo" shared with Sakshi.
    //Lenght increase for Item Description field  from 50 to 100

    // BC Upgrade SHUKLP03 <<



    fields
    {
        field(1; Budget; Code[10])
        {
            Caption = 'Budget';
        }
        field(2; "Sales Person Code"; Code[20])
        {
            Caption = 'Sales Person Code';
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(3; "Sales Person Name"; Text[50])
        {
            CalcFormula = Lookup("Salesperson/Purchaser".Name where(Code = FIELD("Sales Person Code")));
            Caption = 'Sales Person Name';
            FieldClass = FlowField;
        }
        field(4; "Item No"; Code[20])
        {
            Caption = 'Item No';
            TableRelation = Item."No.";
        }
        field(5; "Item Description"; Text[100])
        {
            CalcFormula = Lookup(Item.Description where("No." = FIELD("Item No")));
            Caption = 'Item Description';
            FieldClass = FlowField;
        }
        field(6; "Unit Of Measure Code"; Code[20])
        {
            CalcFormula = Lookup(Item."Sales Unit of Measure" where("No." = FIELD("Item No")));
            Caption = 'Unit Of Measure Code';
            FieldClass = FlowField;
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(8; "Unit Price"; Decimal)
        {
            FieldClass = Normal;
        }
        field(9; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            TableRelation = Currency.Code;
        }
        field(10; "Total Value (budget)"; Decimal)
        {
            Caption = 'Total Value (budget)';
        }
        field(11; Year; Integer)
        {
            Caption = 'Year';
        }
        field(12; Month; Integer)
        {
            Caption = 'Month';
        }
        field(13; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
        }
        field(19; Day; Integer)
        {
            Caption = 'Day';
        }
        field(21; "Customer Code"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(22; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Sales Person Code", Year, Month, "Item No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        "Last Date Modified" := TODAY;
    end;

    trigger OnModify();
    begin
        "Last Date Modified" := TODAY;
    end;
}

