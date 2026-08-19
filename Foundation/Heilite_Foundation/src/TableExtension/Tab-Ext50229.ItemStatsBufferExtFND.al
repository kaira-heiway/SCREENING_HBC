// Added namespace to remove warning
namespace IBM.Heilite.Foundation;
using Microsoft.Inventory.Analysis;

tableextension 50229 ItemStatsBufferExtFND extends "Item Statistics Buffer"
{
    // POENAB02, 19.03.2026, Gap "BPM051-Create CAPEX budget", new object

    fields
    {
        field(50000; "Analysis - Volume 1 FND"; Decimal)
        {
            CalcFormula = sum("Item Analysis View Entry"."Volume 1 101FDW" where("Analysis Area" = field("Analysis Area Filter"),
                                                                         "Analysis View Code" = field("Analysis View Filter"),
                                                                         "Item No." = field("Item Filter"),
                                                                         "Location Code" = field("Location Filter"),
                                                                         "Dimension 1 Value Code" = field("Dimension 1 Filter"),
                                                                         "Dimension 2 Value Code" = field("Dimension 2 Filter"),
                                                                         "Dimension 3 Value Code" = field("Dimension 3 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Source Type" = field("Source Type Filter"),
                                                                         "Source No." = field("Source No. Filter"),
                                                                         "Item Ledger Entry Type" = field("Item Ledger Entry Type Filter"),
                                                                         "Entry Type" = field("Entry Type Filter")));
            Caption = 'Analysis - Volume 1';
            FieldClass = FlowField;
        }
        field(50001; "Analysis - Volume 2 FND"; Decimal)
        {
            CalcFormula = sum("Item Analysis View Entry"."Volume 2 101FDW" where("Analysis Area" = field("Analysis Area Filter"),
                                                                         "Analysis View Code" = field("Analysis View Filter"),
                                                                         "Item No." = field("Item Filter"),
                                                                         "Location Code" = field("Location Filter"),
                                                                         "Dimension 1 Value Code" = field("Dimension 1 Filter"),
                                                                         "Dimension 2 Value Code" = field("Dimension 2 Filter"),
                                                                         "Dimension 3 Value Code" = field("Dimension 3 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Source Type" = field("Source Type Filter"),
                                                                         "Source No." = field("Source No. Filter"),
                                                                         "Item Ledger Entry Type" = field("Item Ledger Entry Type Filter"),
                                                                         "Entry Type" = field("Entry Type Filter")));
            Caption = 'Analysis - Volume 2';
            FieldClass = FlowField;
        }
        field(50002; "Analysis - Budget Volume 1 FND"; Decimal)
        {
            CalcFormula = sum("Item Analysis View Budg. Entry"."Volume 1 FND" where("Analysis Area" = field("Analysis Area Filter"),
                                                                               "Analysis View Code" = field("Analysis View Filter"),
                                                                               "Budget Name" = field("Budget Filter"),
                                                                               "Item No." = field("Item Filter"),
                                                                               "Location Code" = field("Location Filter"),
                                                                               "Dimension 1 Value Code" = field("Dimension 1 Filter"),
                                                                               "Dimension 2 Value Code" = field("Dimension 2 Filter"),
                                                                               "Dimension 3 Value Code" = field("Dimension 3 Filter"),
                                                                               "Posting Date" = field("Date Filter"),
                                                                               "Source Type" = field("Source Type Filter"),
                                                                               "Source No." = field("Source No. Filter")));
            Caption = 'Analysis - Budgeted Volume 1';
            FieldClass = FlowField;
        }
        field(50003; "Analysis - Budget Volume 2 FND"; Decimal)
        {
            CalcFormula = sum("Item Analysis View Budg. Entry"."Volume 2 FND" where("Analysis Area" = field("Analysis Area Filter"),
                                                                               "Analysis View Code" = field("Analysis View Filter"),
                                                                               "Budget Name" = field("Budget Filter"),
                                                                               "Item No." = field("Item Filter"),
                                                                               "Location Code" = field("Location Filter"),
                                                                               "Dimension 1 Value Code" = field("Dimension 1 Filter"),
                                                                               "Dimension 2 Value Code" = field("Dimension 2 Filter"),
                                                                               "Dimension 3 Value Code" = field("Dimension 3 Filter"),
                                                                               "Posting Date" = field("Date Filter"),
                                                                               "Source Type" = field("Source Type Filter"),
                                                                               "Source No." = field("Source No. Filter")));
            Caption = 'Analysis - Budgeted Volume 2';
            FieldClass = FlowField;
        }
    }
}