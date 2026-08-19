page 52012 "Vendor Ledger Entry Duplicate"
{
    // version HEI.01
    //BC UPGRADE SIVA Old Page ID 50111
    // HEI.01 FDD PTPGAP030 IBM.NAIKH01 12.01.2018
    //   #Created a new Page to show the duplicate records.
    // HEI.02 CHG2133239 BHANDS01 11-17-2021
    //   # Modified code in ModifyDuplicateEntryNo() and GetMaxDuplicaterecord() to resolve compilation error
    //************************************************//
    // BC UPGRADE SIVA 8/01/2026
    // SUMMARY OF CHANGES:
    //1.HEI.02 No Changes.
    //2.Document Subtype Code field commented in layout section due to drink it field (2014421).
    //************************************************//
    PageType = List;
    SourceTable = "Vendor Ledger Entry";
    ApplicationArea = All;
    SourceTableView = SORTING("Entry No.")
                      WHERE("Document Type" = CONST(Invoice));
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the unique number that identifies the vendor ledger entry.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the unique number that identifies the vendor.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date on which the vendor ledger entry is posted.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the type of document for the vendor ledger entry.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number of the vendor ledger entry.';
                }
                //BC UPGRADE VAMSIU01 >>
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                }
                //BC UPGRADE VAMSIU01 <<
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the document number that is used in the external system.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the vendor ledger entry.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the code for the currency used in the vendor ledger entry.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the amount of the vendor ledger entry.';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ToolTip = 'Specifies the remaining amount of the vendor ledger entry.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ToolTip = 'Specifies the amount in local currency of the vendor ledger entry.';
                }
                field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)")
                {
                    ToolTip = 'Specifies the remaining amount in local currency of the vendor ledger entry.';
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ToolTip = 'Specifies the posting group that determines the general ledger accounts to be used for the vendor.';
                }
                field("Duplicate Entry No."; Rec."Duplicate Entry No. FND")
                {
                    ToolTip = 'Specifies the duplicate entry number for the vendor ledger entry.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        //HEI.01
        Cnt := GetMaxDuplicaterecord();
        if Cnt = 0 then
            Cnt := 1
        else
            Cnt := Cnt + 1;
        ModifyDuplicateEntryNo(Cnt);
        //HEI.01
    end;

    var
        Cnt: Integer;

    local procedure ModifyDuplicateEntryNo(Cnt1: Integer);
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendorLedgerEntry1: Record "Vendor Ledger Entry";
        DuplicateCnt: Integer;
    begin
        //HEI.01
        if VendorLedgerEntry.FIND() then
            repeat
                // HEI.02 >>
                //     IF VendorLedgerEntry."Duplicate Entry No." = 0 THEN BEGIN
                if VendorLedgerEntry."Duplicate Entry No. FND" = '' then begin
                    // HEI.02 <<
                    VendorLedgerEntry1.RESET();
                    VendorLedgerEntry1.SETRANGE("Vendor No.", VendorLedgerEntry."Vendor No.");
                    VendorLedgerEntry1.SETRANGE("Document No.", VendorLedgerEntry."External Document No.");
                    VendorLedgerEntry1.SETRANGE("Posting Date", VendorLedgerEntry."Document Date");
                    VendorLedgerEntry1.SETRANGE(Amount, VendorLedgerEntry.Amount);
                    if VendorLedgerEntry1.FINDSET() then
                        repeat
                            DuplicateCnt := VendorLedgerEntry1.COUNT;
                            if DuplicateCnt > 1 then begin
                                // HEI.02 >>
                                //              IF VendorLedgerEntry1."Duplicate Entry No." = 0 THEN BEGIN
                                if VendorLedgerEntry1."Duplicate Entry No. FND" = '' then begin
                                    // HEI.02 >>
                                    //                VendorLedgerEntry1."Duplicate Entry No." := Cnt1;
                                    VendorLedgerEntry1."Duplicate Entry No. FND" := FORMAT(Cnt1);
                                    // HEI.02 <<
                                    VendorLedgerEntry1.MODIFY;
                                end;
                            end;
                        until VendorLedgerEntry1.NEXT() = 0;

                    if DuplicateCnt > 1 then
                        Cnt1 := Cnt1 + 1;
                end;
            until VendorLedgerEntry.NEXT() = 0;
    end;

    local procedure GetMaxDuplicaterecord(): Integer;
    var
        VendorLedgerEntry_L: Record "Vendor Ledger Entry";
        Maxentry: Integer;
        VLEDuplicateEntryNo: Integer;
    begin
        //HEI.01
        Maxentry := 0;
        VendorLedgerEntry_L.RESET();
        // HEI.02 >>
        // VendorLedgerEntry_L.SETFILTER("Duplicate Entry No.",'<>%1',0);
        VendorLedgerEntry_L.SETFILTER("Duplicate Entry No. FND", '<>%1', '');
        if VendorLedgerEntry_L.FINDSET() then
            repeat
                //    IF Maxentry < VendorLedgerEntry_L."Duplicate Entry No." THEN
                EVALUATE(VLEDuplicateEntryNo, VendorLedgerEntry_L."Duplicate Entry No. FND");
                if Maxentry < VLEDuplicateEntryNo then
                    //      Maxentry := VendorLedgerEntry_L."Duplicate Entry No."
                    Maxentry := VLEDuplicateEntryNo;
            // HEI.02 <<
            until VendorLedgerEntry_L.NEXT() = 0;
        exit(Maxentry);
    end;
}

