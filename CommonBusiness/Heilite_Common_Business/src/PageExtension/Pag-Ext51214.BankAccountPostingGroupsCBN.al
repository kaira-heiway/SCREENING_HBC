pageextension 51214 BankAccountPostingGroupsExtCBN extends "Bank Account Posting Groups"
{
    // version NAVW110.0

    //Bc Upgrade YADAVM09 Page Migrated.
    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies the code for the posting group.', FRA = 'Spécifie le code pour le groupe comptabilisation.';
        }

        addafter("G/L Account No.")
        {
            field("AR Suspense Account"; Rec."AR Suspense Account FND")
            {
                ApplicationArea = All;
                ToolTip = 'For Selection of "AR Suspense Account';
            }
            field("AP Suspense Account"; Rec."AP Suspense Account FND")
            {
                ApplicationArea = All;
                ToolTip = 'For Selection of "AP Suspense Account';
            }
        }
    }

    //Unsupported feature: PropertyChange. Please convert manually.

}

