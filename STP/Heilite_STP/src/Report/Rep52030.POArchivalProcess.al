report 52030 "PO Archival Process"
{
    // version HEI.01

    // HEI.01 CHG2188365 HB3301 IBM NANDIS01 03.02.2023 # Limit PO in PO Archive
    //   # New report to polulate Limit PO field in Purchase Header Additional Archive table

    // BC Upgrade KUMARR78>>
    // 1. Added ApplicationArea property at report level for Business Central compliance.
    //    Old: ApplicationArea property was not defined.
    //    New: ApplicationArea = All;
    // 2. Added UsageCategory property at report level for report discoverability in BC.
    //    Old: UsageCategory property was not defined.
    //    New: UsageCategory = ReportsAndAnalysis;
    // 3. Old Report Reference:
    //    Old Report ID: 50130
    //    Report Name: "PO Archival Process"
    // BC Upgrade KUMARR78<<

    ProcessingOnly = true;
    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade KUMARR78 Adding Usagecategory

    dataset
    {
        dataitem("Purchase Header Additional FND"; "Purchase Header Additional FND")
        {
            DataItemTableView = SORTING("Document Type", "No.");

            trigger OnAfterGetRecord();
            var
                PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
            begin
                //HEI.01>>
                PurchaseHeaderArchiveAddit.RESET();
                PurchaseHeaderArchiveAddit.SETRANGE("Document Type", "Purchase Header Additional FND"."Document Type"::Order);
                PurchaseHeaderArchiveAddit.SETRANGE("No.", "Purchase Header Additional FND"."No.");
                if PurchaseHeaderArchiveAddit.FINDFIRST() then begin
                    PurchaseHeaderArchiveAddit."Limit PO" := "Purchase Header Additional FND"."Limit PO";
                    PurchaseHeaderArchiveAddit.MODIFY();
                end;
                //HEI.01<<
            end;
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

    var
        PurchaseHeaderArchiveAddit: Record "Purchase Header Arch Addit FND";
}

