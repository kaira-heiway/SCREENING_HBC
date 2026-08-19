page 50071 "Cash Collection Comment List"
{
    // version NAVW110.0,HEI.01

    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order

    AutoSplitKey = true;
    Caption = 'Cash Collection Comment List';
    DelayedInsert = true;
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Cash Collection Cmt Line FND";
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Administration;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; rec.Type)
                {
                    ToolTip = 'Specifies the type of document the comment is attached to: either Reminder or Issued Reminder.';
                }
                field("No."; rec."No.")
                {
                    ToolTip = 'Specifies the document number of the reminder to which the comment applies.';
                }
                field(Date; rec.Date)
                {
                    ToolTip = 'Specifies the date the comment was created.';
                }
                field(Comment; rec.Comment)
                {
                    ToolTip = 'Specifies the comment itself.';
                }
            }
        }
    }

    actions
    {
    }

    var
        Text000: Label 'untitled', Comment = 'it is a caption for empty page';
        Text001: Label 'Reminder';

    local procedure Caption(ReminderCommentLine: Record "Reminder Comment Line"): Text[110];
    begin
        //HEI.01>>
        if ReminderCommentLine."No." = '' then
            exit(Text000);
        exit(Text001 + ' ' + ReminderCommentLine."No." + ' ');
        //HEI.01<<
    end;
}

