page 51095 "BankConn.ReplaceCharCBN"
{
    // version HEI.01

    // HEI.01 CHG2119688 IBM POENAB02 19.10.2022 HB2428 Panama CITI - bank connectivity payment file
    //   # Object created

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    //BC Upgrade KAPOOV01  <<

    PageType = List;
    SourceTable = "Bank Conn.- Replace Char. FND";
    ApplicationArea = All;   //BC Upgrade KAPOOV01
    UsageCategory = Lists;  //BC Upgrade KAPOOV01

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Character to be Replaced"; Rec."Character to be Replaced")
                {
                }
                field("New Character"; Rec."New Character")
                {
                }
                field("Delete Character"; Rec."Delete Character")
                {
                }
            }
        }
    }

    actions
    {
    }
}

