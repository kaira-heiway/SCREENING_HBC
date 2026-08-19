table 58019 "Counterpoint Interf. Stp INT"
{
    // Heilite Navision Old Id - 50071
    // version HEI.01

    // HEI.01 BA-SLSGAP01 IBM LAZARE02 15.10.2018 # New table for Counterpoint interface
    // HEI.02 FDD-BA-SLSGAP01 IBM NASTAA02 19.10.2018 # Counterpoint Interface
    //   # New Fields added

    Caption = 'Counterpoint Interface Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(10; "Sales Interface"; Code[20])
        {
            Caption = 'Sales Interface';
            TableRelation = "Interface Setup INT";
        }
        field(11; "Payouts Interface"; Code[20])
        {
            Caption = 'Payouts Interface';
            TableRelation = "Interface Setup INT";
        }
        field(12; "Stock Adjustments Interface"; Code[20])
        {
            Caption = 'Stock Adjustments Interface';
            TableRelation = "Interface Setup INT";
        }
        field(13; "Stock Transfers Interface"; Code[20])
        {
            Caption = 'Stock Transfers Interface';
            TableRelation = "Interface Setup INT";
        }
        field(14; "Receipts Non Core Interface"; Code[20])
        {
            Caption = 'Receipts Non-Core Interface';
            TableRelation = "Interface Setup INT";
        }
        field(15; "RTV Non Core Interface"; Code[20])
        {
            Caption = 'RTV Non-Core Interface';
            TableRelation = "Interface Setup INT";
        }
        field(16; "Payments Interface"; Code[20])
        {
            Caption = 'Payments Interface';
            TableRelation = "Interface Setup INT";
        }
        field(30; "Burns House CP No."; Text[100])
        {
            Caption = 'Burns House CP No.';
            Description = 'HEI.02';

            trigger OnLookup();
            var
                VendorMappingCP: Record "Vendor Mapping CP FND";
                CPVendorNoFilter: Text[100];
            begin
                //HEI.02>>
                if PAGE.RUNMODAL(50244, VendorMappingCP) = ACTION::LookupOK then
                    CPVendorNoFilter := VendorMappingCP."CP Vendor No.";
                if CPVendorNoFilter <> '' then
                    "Burns House CP No." := CPVendorNoFilter;
                //HEI.02<<
            end;
        }
        field(31; "Sales Excise Tax"; Code[20])
        {
            Caption = 'Sales Excise Tax';
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
        field(33; "Loyalty Sales Reduction TPR"; Code[20])
        {
            Caption = 'Loyalty Sales Reduction TPR';
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
        field(34; "Loyalty Deferred Revenue"; Code[20])
        {
            Caption = 'Loyalty Deferred Revenue';
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
        field(35; "TopUp Accrued Liabilities"; Code[20])
        {
            Caption = 'Top-Up Accrued Liabilities';
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
        field(36; "Other Expenses"; Code[20])
        {
            Caption = 'Other Expenses';
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
        field(39; "TopUp Acc. Liability %"; Decimal)
        {
            Caption = 'Top-Up Acc. Liability %';
            DecimalPlaces = 0 : 2;
            Description = 'HEI.02';
        }
        field(42; "Sales Gen. Journal Template"; Code[10])
        {
            Caption = 'Sales - Gen. Journal Template';
            Description = 'HEI.02';
            TableRelation = "Gen. Journal Template";
        }
        field(43; "Sales Gen. Journal Batch"; Code[10])
        {
            Caption = 'Sales - Gen. Journal Batch';
            Description = 'HEI.02';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Sales Gen. Journal Template"));
        }
        field(44; "Payments Gen. Jnl Template"; Code[10])
        {
            Caption = 'Payments - Gen. Journal Template';
            Description = 'HEI.02';
            TableRelation = "Gen. Journal Template";
        }
        field(45; "Payments Gen. Jnl Batch"; Code[10])
        {
            Caption = 'Payments - Gen. Journal Batch';
            Description = 'HEI.02';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Payments Gen. Jnl Template"));
        }
        field(46; "Payouts Gen. Journal Template"; Code[10])
        {
            Caption = 'Payouts - Gen. Journal Template';
            Description = 'HEI.02';
            TableRelation = "Gen. Journal Template";
        }
        field(47; "Payouts Gen. Journal Batch"; Code[10])
        {
            Caption = 'Payouts-Gen. Journal Batch';
            Description = 'HEI.02';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Payouts Gen. Journal Template"));
        }
        field(48; "COGS Item Journal Template"; Code[10])
        {
            Caption = 'COGS - Item Journal Template';
            Description = 'HEI.02';
            TableRelation = "Item Journal Template";
        }
        field(49; "COGS Item Journal Batch"; Code[10])
        {
            Caption = 'COGS - Item Journal Batch';
            Description = 'HEI.02';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("COGS Item Journal Template"));
        }
        field(50; "Stock Adjst Item Jnl Template"; Code[10])
        {
            Caption = 'Stock Adjst - Item Journal Template';
            Description = 'HEI.02';
            TableRelation = "Item Journal Template";
        }
        field(51; "Stock Adjst Item Jnl Batch"; Code[10])
        {
            Caption = 'Stock Adjst - Item Journal Batch';
            Description = 'HEI.02';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Stock Adjst Item Jnl Template"));
        }
        field(52; "Stock Transf Item Jnl Template"; Code[10])
        {
            Caption = 'Stock Transfer - Item Journall Template';
            Description = 'HEI.02';
            TableRelation = "Item Journal Template";
        }
        field(53; "Stock Transf Item Jnl Batch"; Code[10])
        {
            Caption = 'Stock Transfer - Item Journal Batch';
            Description = 'HEI.02';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Stock Transf Item Jnl Template"));
        }
        field(54; "PO Receipts Item Jnl Template"; Code[10])
        {
            Caption = 'Purch. Order Receipts - Item Journal Template';
            Description = 'HEI.02';
            TableRelation = "Item Journal Template";
        }
        field(55; "RTV Item Jnl Template"; Code[10])
        {
            Caption = 'RTV - Item Journal Template';
            Description = 'HEI.02';
            TableRelation = "Item Journal Template";
        }
        field(56; "Item UoM Retail"; Code[10])
        {
            Caption = 'Item UoM Retail';
            Description = 'HEI.02';
            TableRelation = "Unit of Measure";
        }
        field(57; "Zone Code"; Code[10])
        {
            Caption = 'Zone Code';
            Description = 'HEI.02';
            TableRelation = Zone.Code;
        }
        field(58; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            Description = 'HEI.02';
            TableRelation = Bin.Code;
        }
        field(59; "Fixed Lot No."; Code[20])
        {
            Caption = 'Fixed Lot No.';
            Description = 'HEI.02';
        }
        field(60; "Sales VAT Code"; Code[10])
        {
            Caption = 'Sales VAT Code';
            Description = 'HEI.02';
            TableRelation = "VAT Product Posting Group";
        }
        field(61; "Sales No VAT Code"; Code[10])
        {
            Caption = 'Sales No VAT Code';
            Description = 'HEI.02';
            TableRelation = "VAT Product Posting Group";
        }
        field(72; "PO Receipts Item Jnl Batch"; Code[10])
        {
            Caption = 'PO Receipts-Item Journal Batch';
            Description = 'HEI.02';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("PO Receipts Item Jnl Template"));
        }
        field(73; "RTV Item Jnl Batch"; Code[10])
        {
            Caption = 'RTV - Item Journall Batch';
            Description = 'HEI.02';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("RTV Item Jnl Template"));
        }
        field(80; "Investment Level Dimension"; Code[20])
        {
            Caption = 'Investment Level Dimension';
            Description = 'HEI.02';
            TableRelation = Dimension WHERE(Code = CONST('INV_LEV'));
        }
        field(81; "Investment Level Dim Value"; Code[20])
        {
            Caption = 'Investment Level Dim Value';
            Description = 'HEI.02';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Investment Level Dimension"));
        }
        field(83; "TopUp Account"; Code[20])
        {
            Caption = 'Top-Up Account';
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

