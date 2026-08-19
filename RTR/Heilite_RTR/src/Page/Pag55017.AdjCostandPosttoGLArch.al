page 55017 "Adj Cost and Post to G/L Arch."
{
    // HEI.01 CHG2098896 IBM POENAB02 18.02.2021 Skip/step over error messages during running an batch job (adjust cost and post cost to G/L)
    //   # Object created

    // BC Upgrade KUMARR78 >>
    //
    // Page Name  : Adj Cost and Post to G/L Arch.
    // Page ID    : 50436
    //
    // 1. Added Business Central visibility property.
    //    Old:
    //         - ApplicationArea not defined in NAV.
    //    New:
    //         - ApplicationArea = All added at page level.
    //         - Ensures visibility and searchability in Business Central.
    //
    // 2. Replaced legacy NAV table ID with named object reference.
    //    Old:
    //         - SourceTable = 50199;
    //    New:
    //         - SourceTable = "Adj Cost and Post to G/L Arch.";
    //         - Removes dependency on numeric object ID.
    //         - Upgrade-safe and SaaS compliant.
    //
    // 3. Verified read-only behavior for archive log page.
    //    Old:
    //         - NAV-based configuration.
    //    New:
    //         - DeleteAllowed = false;
    //         - InsertAllowed = false;
    //         - ModifyAllowed = false;
    //         - Explicitly ensures archive log remains non-editable in BC.
    //
    // 4. Validated SourceTableView syntax for AL compliance.
    //    Old:
    //         - NAV-style sorting syntax.
    //    New:
    //         - SourceTableView = SORTING("Entry No.")
    //                             ORDER(Descending);
    //         - Verified AL-compatible syntax.
    //
    // 5. Verified repeater structure for AL compliance.
    //    Old:
    //         - Fields without explicit ApplicationArea.
    //    New:
    //         - Page-level ApplicationArea = All applied.
    //         - No unsupported properties used.
    //         - Structure compatible with BC UI framework.
    // BC Upgrade KUMARR78 <<
    Caption = 'Error Log Adj Cost and Post to G/L Archive';
    DeleteAllowed = false;
    InsertAllowed = false;
    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea.
    ModifyAllowed = false;
    PageType = List;
    // SourceTable = 50199;//BC UPGRADE KUMARR78 Blocking OLD NAV Table ID.
    SourceTable = "Adj Cost Post to G/L Arch. FND";//BC UPGRADE KUMARR78 Replacing 50199 ID with Latest Record Object.
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field("Error Message"; Rec."Error Message")
                {
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                }
                field(Time; Rec.Time)
                {
                }
            }
        }
    }

    actions
    {
    }
}

