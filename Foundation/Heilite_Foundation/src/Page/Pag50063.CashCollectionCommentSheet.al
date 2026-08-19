page 50063 "Cash Collection Comment Sheet"
{
    // version NAVW110.0

    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order

    AutoSplitKey = true;
    Caption = 'Cash Collection Comment Sheet';
    DataCaptionExpression = Caption(Rec);
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
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
                field(Date; rec.Date)
                {
                    ToolTip = 'Specifies the date the comment was created.';
                }
                field(Comment; rec.Comment)
                {
                    ToolTip = 'Specifies the comment itself.';
                }
                field("Code"; rec.Code)
                {
                    ToolTip = 'Specifies a code for the comment.';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        //HEI.01>>
        Rec.SetUpNewLine();
        //HEI.01<<
    end;

    var
        Text000: Label 'untitled';
        Text001: Label 'Reminder';

    local procedure Caption(CashCollectionCommentLine: Record "Cash Collection Cmt Line FND"): Text[110];
    begin
        //HEI.01>>
        if CashCollectionCommentLine."No." = '' then
            exit(Text000);
        exit(Text001 + ' ' + CashCollectionCommentLine."No." + ' ');
        //HEI.01<<
    end;
}

