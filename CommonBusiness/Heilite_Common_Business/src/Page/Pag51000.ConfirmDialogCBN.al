page 51000 "ConfirmDialog CBN"
{
    // version HEI.01

    // HEI.01 RFC-CHG0246362 IBM ISYED01 10/09/2018-Reversal Transactional Functionality – Correction of Date of Reversal
    //   # Created page confirm Dialog used to for input dailag for Reversal Date

    PageType = ConfirmationDialog;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(ReversalPostingDate; ReversalPostingDate)
            {
                Caption = 'Provide Reversal Posting Date:';
                ToolTip = 'Specifies the value of the Provide Reversal Posting Date: field.';
            }
        }
    }

    actions
    {
    }

    var
        ReversalPostingDate: Date;

    procedure ReturnEnteredNumber(): Date;
    begin
        exit(ReversalPostingDate);
    end;
}

