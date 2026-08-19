page 55016 "Adj Cost and Post to G/L"
{
    // version HEI.02

    // HEI.01 CHG2098896 IBM POENAB02 18.02.2021 Skip/step over error messages during running an batch job (adjust cost and post cost to G/L)
    //   # Object created
    // HEI.02 CHG2207812 IBM PRASAA03  12.06.2023 Error message Handling for more than 250 character
    //   # Added Error Log 2 Field
    // BC Upgrade KUMARR78 >>
    //
    // Page Name  : Adj Cost and Post to G/L
    // Page ID    : 50435
    //
    // 1. Added Business Central visibility property.
    //    Old:
    //         - ApplicationArea not defined in NAV.
    //    New:
    //         - ApplicationArea = All added at page level.
    //         - Ensures page visibility and compliance with BC UI standards.
    //
    // 2. Replaced legacy NAV table ID with named object reference.
    //    Old:
    //         - SourceTable = 50198;
    //    New:
    //         - SourceTable = "Adj Cost and Post to G/L";
    //         - Removed dependency on numeric object ID.
    //         - Upgrade-safe and SaaS compliant.
    //
    // 3. Verified read-only page behavior for BC.
    //    Old:
    //         - NAV-based configuration.
    //    New:
    //         - DeleteAllowed = false;
    //         - InsertAllowed = false;
    //         - ModifyAllowed = false;
    //         - Explicitly ensures non-editable error log behavior in BC.
    //
    // 4. Validated repeater field structure for AL compliance.
    //    Old:
    //         - Fields without explicit ApplicationArea property.
    //    New:
    //         - Page-level ApplicationArea = All applied.
    //         - Fields verified for BC compatibility.
    //         - No unsupported properties used.
    //
    // 5. Maintained extended error handling structure.
    //    Old:
    //         - Single error message field (NAV).
    //    New:
    //         - "Error Message 2" retained for >250 character handling.
    //         - Supports extended error logging requirement (HEI.02).
    //
    // 6. Maintained pragma suppression for AA0218.
    //    Old:
    //         - Implicit handling without suppression.
    //    New:
    //         - #pragma warning disable/restore AA0218 retained.
    //         - Prevents warnings for legacy table structure during upgrade.
    //
    // BC Upgrade KUMARR78 <<

    Caption = 'Error Log Adj Cost and Post to G/L';
    DeleteAllowed = false;
    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea.
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    // SourceTable = 50198;//BC UPGRADE KUMARR78 Blocking OLD NAV Table ID.
    SourceTable = "Adj Cost and Post to G/L FND";//BC UPGRADE KUMARR78 Replacing 50198 ID with Latest Record Object.

    layout
    {
        area(content)
        {
            repeater(Group)
            {
#pragma warning disable AA0218
                field("Item No."; Rec."Item No.")

                {
                }
                field("Error Message"; Rec."Error Message")
                {
                }
                field("Error Message 2"; Rec."Error Message 2")
                {
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                }
                field(Time; Rec.Time)
                {
                }
#pragma warning restore AA0218
            }

        }
    }

    actions
    {
    }
}

