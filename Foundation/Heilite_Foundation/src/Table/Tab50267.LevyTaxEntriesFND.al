table 50267 "Levy Tax Entries FND"
{
    // version HEI.01

    // HEI.01 CHG2224401 HB3624 YADAVM09 01.04.2024 Health and Security Levy Tax
    //   # New object created

    // BC Upgrade PATELS08 >>
    // # Changed datatype of field "Type" from Option to Enum to avoid implicit conversion 
    // BC Upgrade PATELS08 <<

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '" ,Invoice,Credit Memo"';
            OptionMembers = " ",Invoice,"Credit Memo";
        }
        field(3; "Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Doc. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        // BC Upgrade PATELS08 >> # Changed datatype from Option to Enum to avoid implicit conversion
        // field(9; Type; Option)
        field(9; Type; Enum "Purchase Line Type")
        // BC Upgrade PATELS08 <<
        {
            DataClassification = ToBeClassified;
            // BC Upgrade PATELS08 >> # Blocked Option Properties
            // OptionCaption = '" ,G/L Account,Item,,Fixed Asset,Charge (Item)"';
            // OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
            // BC Upgrade PATELS08 << 
        }
        field(10; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Location; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Zone; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Bin; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Direct Unit Cost Exl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Line Amount Excl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "H&S Levy Tax %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "H&S Levy Tax Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Discount Line Amt Excl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Value Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "ILE Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "User ID"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Inv Credit Memo No."; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Total Amount Excl VAT/H&S"; Decimal)
        {
            Caption = 'Total Amount Excl VAT/H&S';
            DataClassification = ToBeClassified;
        }
        field(29; "HS Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "H&S Tax Posting Group FND";
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        LevyTaxEntries: Record "Levy Tax Entries FND";
        PurchaseLine: Record "Purchase Line";
        NextLeavyTaxEntryNo: Integer;

#pragma warning disable AA0228
    local procedure InsertLeavytaxEntries(purchaseheader: Record "Purchase Header");
#pragma warning restore AA0228
    begin
        LevyTaxEntries.LOCKTABLE();
        if LevyTaxEntries.FINDLAST() then
            NextLeavyTaxEntryNo := LevyTaxEntries."Entry No." + 1
        else
            NextLeavyTaxEntryNo := 1;
        PurchaseLine.RESET();
        PurchaseLine.SETRANGE("Document Type", purchaseheader."Document Type");
        PurchaseLine.SETRANGE("Document No.", purchaseheader."No.");
        if PurchaseLine.findset() then
            repeat
                INIT();
                "Entry No." := NextLeavyTaxEntryNo;
                //"Transaction Type"
                "Doc. No." := PurchaseLine."Document No.";
            //"Posting Date" := PurchaseLine.po
            until PurchaseLine.NEXT() = 0;
    end;

    procedure Set(var LevyTaxEntries: Record "Levy Tax Entries FND" temporary);
    begin
        /*IF TempItemLedgerEntry2.findset THEN
          REPEAT
            Rec := TempItemLedgerEntry2;
            INSERT;
          UNTIL TempItemLedgerEntry2.NEXT = 0;*/

    end;
}

