report 53021 "Update Qty HL"
{
    // version HEI.01

    // SOICAD report to update qty in HL
    // BC Upgrade BHARDA11 >>
    /* This processing-only report is intentionally retained in the repository even though the current Drink-IT related logic is commented out. 
    The original purpose of this report was to update HL quantity fields based on Drink-IT custom fields, which were removed during the BC upgrade.
After discussion with Saikat Nandi, it was decided to keep this report so that, in the future, if equivalent or alternative fields are identified,
 the existing structure can be reused and the field mappings can be reintroduced with minimal effort.
  This helps preserve historical business logic and avoids re-creating the batch process from scratch. */
    // 1. Old Report ID is - 50100.
    // 2. Remove Drink-IT Fields and related code("Unit Volume HL","Valued Quantity in HL","Item Ledger Entry Quantity HL","Invoiced Quantity in HL")
    // 3. Add ApplicationArea property in Report.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Permissions = TableData "Item Ledger Entry" = rm,
                  TableData "Value Entry" = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Inventory Posting Group";
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Item No.");

                trigger OnAfterGetRecord()
                begin
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field("Unit Volume HL","Quantity in HL")
                    // "Unit Volume HL" := Item."Unit Volume HL";
                    // "Quantity in HL" := "Unit Volume HL" * Quantity;
                    // MODIFY;
                    // BC Upgrade BHARDA11 << ----Drink-IT Field("Unit Volume HL","Quantity in HL")

                end;
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code");

                trigger OnAfterGetRecord()
                begin
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field("Unit Volume HL","Valued Quantity in HL","Item Ledger Entry Quantity HL","Invoiced Quantity in HL")
                    // "Unit Volume HL" := Item."Unit Volume HL";
                    // "Valued Quantity in HL" := "Unit Volume HL" * "Valued Quantity";
                    // "Item Ledger Entry Quantity HL" := "Unit Volume HL" * "Item Ledger Entry Quantity";
                    // "Invoiced Quantity in HL" := "Unit Volume HL" * "Invoiced Quantity";
                    // MODIFY;
                    // BC Upgrade BHARDA11 << ----Drink-IT Field("Unit Volume HL","Valued Quantity in HL","Item Ledger Entry Quantity HL","Invoiced Quantity in HL")

                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

