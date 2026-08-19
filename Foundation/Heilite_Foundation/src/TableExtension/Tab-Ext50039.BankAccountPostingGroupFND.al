tableextension 50039 BankAccountPostingGroupExtFND extends "Bank Account Posting Group"
{
    // version NAVW19.00
    // No Documentation trigger found though 50000 and 50001 fields added - BC Upgrade NANDIS03
    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        // modify("G/L Bank Account No.")
        // {
        //     CaptionML = ENU='G/L Bank Account No.',FRA='N° compte bancaire compta.';
        // }  // BC Upgrade NANDIS03
        field(50000; "AR Suspense Account FND"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'AR Suspense Account';
        }
        field(50001; "AP Suspense Account FND"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'AP Suspense Account';
        }
    }

    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

