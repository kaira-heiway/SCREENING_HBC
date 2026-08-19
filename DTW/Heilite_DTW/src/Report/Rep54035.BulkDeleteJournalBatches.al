report 54035 "Bulk Delete Journal Batches"
{
    // version HEI.01

    // HEI.01 CHG2311152 KAMNAY01 29.07.2025 Developed for mass deletion of journal batches
    //   # Created New Report: 50619 - Bulk Delete Journal Batches
    //***************************************
    //BC UPGRADE PATHAA02 27.02.26
    //Main Report ID: 50619-Bulk Delete Journal Batches
    //Added Application Area and UsageCategory properties.
    //***************************************
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Journal Batch"; "Item Journal Batch")
        {
            RequestFilterFields = "Journal Template Name", Name;

            trigger OnAfterGetRecord();
            var
                ItemJnlLine: Record "Item Journal Line";
                ReservationEntry: Record "Reservation Entry";
                ShouldDelete: Boolean;
            begin
                //HEI.01>>
                ItemJnlLine.RESET;
                ItemJnlLine.SETRANGE("Journal Template Name", "Item Journal Batch"."Journal Template Name");
                ItemJnlLine.SETRANGE("Journal Batch Name", "Item Journal Batch".Name);
                if ItemJnlLine.FINDFIRST then begin
                    repeat
                        ReservationEntry.RESET;
                        ReservationEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
                        ReservationEntry.SETRANGE("Source ID", ItemJnlLine."Journal Template Name");
                        ReservationEntry.SETRANGE("Source Batch Name", ItemJnlLine."Journal Batch Name");
                        ReservationEntry.SETRANGE("Source Ref. No.", ItemJnlLine."Line No.");
                        if ReservationEntry.FINDFIRST then
                            repeat
                                ReservationEntry.DELETE(true);
                            until ReservationEntry.NEXT = 0;
                        ItemJnlLine.DELETE(true);
                    until ItemJnlLine.NEXT = 0;
                end;
                "Item Journal Batch".DELETE(true);

                DeletedCount += 1;
                if BatchCount > 0 then begin
                    Window.UPDATE(1, FORMAT(BatchCount));
                    Window.UPDATE(2, FORMAT(DeletedCount));
                    Window.UPDATE(3, "Item Journal Batch"."Journal Template Name");
                    Window.UPDATE(4, "Item Journal Batch".Name);
                end;
                //HEI.01<<
            end;

            trigger OnPostDataItem();
            begin
                //HEI.01>>
                if BatchCount > 0 then
                    Window.CLOSE;
                MESSAGE(Text003, DeletedCount);
                //HEI.01<<
            end;

            trigger OnPreDataItem();
            begin
                //HEI.01>>
                if ("Item Journal Batch".GETFILTER("Journal Template Name") = '') then
                    ERROR(Text004);

                if ("Item Journal Batch".GETFILTER(Name) = '') then
                    ERROR(Text005);

                Confirmed := CONFIRM(Text002, false);
                if not Confirmed then
                    CurrReport.BREAK;
                BatchCount := "Item Journal Batch".COUNT;
                DeletedCount := 0;
                if BatchCount = 0 then
                    CurrReport.BREAK;
                Window.OPEN(Text001);
                //HEI.01<<
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Window: Dialog;
        BatchCount: Integer;
        DeletedCount: Integer;
        Confirmed: Boolean;
        Text001: TextConst ENU = 'Deleting Item Journal Batches...\=====\Total to Delete: #1######\Deleted So Far: #2######\-------------------------------------\Currently Deleting:\Template: #3#########################\Batch : #4#########################\======';
        Text002: Label '''This will permanently delete item journal batches and related item tracking lines. Do you want to continue?''';
        Text003: Label '''Deleted %1 Item Journal Batches and related lines.''';
        Text004: Label '''Please specify a filter for "Journal Template Name".''';
        Text005: Label '''Please specify a filter for "Name".''';
}

