report 53011 "Update Lot Expiration Date"
{
    // version HEI.01

    // HEI.01 CHG2224064 IBM SISUM01 18.10.2023 2 different DLUO on the same lot in base
    //   # New object created

    // BC Upgrade RAHUL>>
    // 1. Added ApplicationArea = All property at report level for BC visibility.
    // 2. Added UsageCategory = ReportsAndAnalysis property at report level for BC searchability.
    // 3. Blocking Caption Property on Request Field.
    // 4. Old Report ID - 50267
    // BC Upgrade RAHUL<<

    ApplicationArea = all; // BC Upgrade RAHUL Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade RAHUL Adding UsageCategory
    Permissions = TableData "Item Ledger Entry" = rm,

                  TableData "Warehouse Entry" = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            RequestFilterFields = "Entry No.", "Lot No.";

            trigger OnAfterGetRecord();
            begin
                if ("Lot No." <> '') then begin
                    "Expiration Date" := NewLotExpirationDate;
                    MODIFY();
                end;
            end;
        }
        dataitem("Warehouse Entry"; "Warehouse Entry")
        {
            RequestFilterFields = "Entry No.", "Lot No.";

            trigger OnAfterGetRecord();
            begin
                if ("Lot No." <> '') then begin
                    "Expiration Date" := NewLotExpirationDate;
                    MODIFY();
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                // Caption = 'General'; //BC Upgrade RAHUL Blocking Caption Property
                field("New Lot Expiration Date"; NewLotExpirationDate)
                {
                    Caption = 'New Lot Expiration Date';
                    ApplicationArea = all;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        MESSAGE(Text000);
    end;

    trigger OnPreReport();
    begin
        CheckFilters();
    end;

    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        WhseEntry: Record "Warehouse Entry";
        WhseItemEntryRelation: Record "Whse. Item Entry Relation";
        NewLotExpirationDate: Date;
        Text000: Label 'Update finished.';
        Text001: Label 'New Lot Expiration Date is mandatory.';
        Text002: Label 'New Lot Expiration Date muste be greater then today.';
        Text003: Label 'Item Ledger Entry filters are mandatory (Lot No. or/and Entry No.)';
        Text004: Label 'Warehouse Entry filters are mandatory (Lot No. or/and Entry No.)';

    local procedure CheckFilters();
    begin
        if (NewLotExpirationDate = 0D) then
            ERROR(Text001);

        if (NewLotExpirationDate <= TODAY) then
            ERROR(Text002);

        if ("Item Ledger Entry".GETFILTER("Lot No.") = '') and ("Item Ledger Entry".GETFILTER("Entry No.") = '') then
            ERROR(Text003);

        if ("Warehouse Entry".GETFILTER("Lot No.") = '') and ("Warehouse Entry".GETFILTER("Entry No.") = '') then
            ERROR(Text004);
    end;
}

