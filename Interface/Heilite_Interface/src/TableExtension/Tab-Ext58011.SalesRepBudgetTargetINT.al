namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Sales.History;

tableextension 58011 SalesRepBudgetTargetINT extends "Sales Rep Budget/Target FND"
{
    // HEI.02 KS Interface IBM NASTAA02 23.08.2019 # KS Interface
    //   # Added Fields: "Actual Invoice Quantity", "Actual Cr. Memo Quantity", "Total Actual Value Invoice" and "Total Actual Value Cr. Memo"

    fields
    {
        field(50000; "Customer Price Group INT"; Code[20])
        {
            CalcFormula = Lookup("Ortec & KStore Interf. Stp INT"."Customer Price Group Code");
            Caption = 'Customer Price Group';
            FieldClass = FlowField;
        }
        field(50001; "Actual Invoice Quantity INT"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line".Quantity WHERE("SalesPerson Code FND" = FIELD("Sales Person Code"),
                                                                  "No." = FIELD("Item No"),
                                                                   Type = FILTER(Item),
                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                   "Unit of Measure Code" = FIELD("Unit Of Measure Code")));
            Caption = 'Actual Invoice Quantity';
            Description = 'HEI.02';
            FieldClass = FlowField;
        }
        field(50002; "Actual Cr. Memo Quantity INT"; Decimal)
        {
            CalcFormula = Sum("Sales Cr.Memo Line".Quantity WHERE("SalesPerson Code FND" = FIELD("Sales Person Code"),
                                                                   Type = FILTER(Item),
                                                                   "No." = FIELD("Item No"),
                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                   "Unit of Measure Code" = FIELD("Unit Of Measure Code")));
            Caption = 'Actual Cr. Memo Quantity';
            Description = 'HEI.02';
            FieldClass = FlowField;
        }
        field(50003; "Total Actual Value Invoice INT"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line"."Line Amount" WHERE(Type = FILTER(Item),
                                                                        "No." = FIELD("Item No"),
                                                                        "Unit of Measure Code" = FIELD("Unit Of Measure Code"),
                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                        "SalesPerson Code FND" = FIELD("Sales Person Code")));
            Caption = 'Total Actual Value Invoice';
            Description = 'HEI.02';
            FieldClass = FlowField;
        }
        field(50004; "Total Actual Val Cr. Memo INT"; Decimal)
        {
            CalcFormula = Sum("Sales Cr.Memo Line"."Line Amount" WHERE(Type = FILTER(Item),
                                                                        "No." = FIELD("Item No"),
                                                                        "Unit of Measure Code" = FIELD("Unit Of Measure Code"),
                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                        "SalesPerson Code FND" = FIELD("Sales Person Code")));
            Caption = 'Total Actual Value Cr. Memo';
            Description = 'HEI.02';
            FieldClass = FlowField;
        }

    }



}
