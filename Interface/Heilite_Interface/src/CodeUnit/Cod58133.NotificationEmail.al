codeunit 58133 "Notification Email Ext"
{
    [EventSubscriber(ObjectType::Report, 1320, 'OnBeforeGetTargetRecRef', '', false, false)]
    local procedure OnBeforeGetTargetRecRef(RecRef: RecordRef; var TargetRecRefOut: RecordRef; var IsHandled: Boolean; NotificationEntry: Record "Notification Entry")
    var
        ApprovalEntry: Record "Approval Entry";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalBatch: Record "Item Journal Batch";
        FieldRef: FieldRef;
        Field4Label: Text;
        Field4Value: Text;
        Field1Label: Text;
        Field1Value: Text;
        Field2Label: Text;
        Field2Value: Text;
    begin
        Clear(Field4Label);
        Clear(Field4Value);

        Field4Label := ApprovalEntry.FIELDCAPTION("Approval Type");
        Field4Value := FORMAT(ApprovalEntry."Approval Type");

        case RecRef.Number of
            DATABASE::"Item Journal Line":
                begin
                    RecRef.SETTABLE(ItemJournalLine);
                    Field1Label := ItemJournalLine.FIELDCAPTION("Document No.");
                    Field1Value := FORMAT(ItemJournalLine."Document No.");
                    Field2Label := ItemJournalLine.FIELDCAPTION(Amount);
                    Field2Value := FORMAT(ItemJournalLine.Amount);
                end;

            DATABASE::"Item Journal Batch":
                begin
                    Field1Label := ItemJournalBatch.FIELDCAPTION(Description);
                    FieldRef := RecRef.FIELD(ItemJournalBatch.FIELDNO(Description));
                    Field1Value := FORMAT(FieldRef.VALUE);
                    Field2Label := ItemJournalBatch.FIELDCAPTION("Template Type");
                    FieldRef := RecRef.FIELD(ItemJournalBatch.FIELDNO("Template Type"));
                    FieldRef.CALCFIELD();
                    Field2Value := FORMAT(FieldRef.VALUE);
                end;
        end;
    end;
}
