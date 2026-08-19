page 55013 "G/L Update Log"
{
    // version HEI.01

    // HEI.01 CHG2277569 SAHAL01 06.02.2025 Not able to apply Entries
    //   # Created New Page: 50656 - G/L Update Log
    //Bc Upgrade YADAVM09 Field properties Addedd.
    //Bc Upgrade YADAVM09 old id-50656

    Caption = 'G/L Update Log';
    Editable = false;
    PageType = List;
    SourceTable = "G/L Update Log RTR";
    ApplicationArea = All; //Bc Upgrade YADAVM09<<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("Parent G/L Entry No."; Rec."Parent G/L Entry No.")
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
                field("Child G/L Entry No."; Rec."Child G/L Entry No.")
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
                field("Closed by Entry No."; Rec."Closed by Entry No.")
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
                field("Closed at Date"; Rec."Closed at Date")
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
                field("Closed by Amount"; Rec."Closed by Amount")
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
                field("Last Time Modified"; Rec."Last Time Modified")
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
                field("Last Modified By User"; Rec."Last Modified By User")
                {
                    ApplicationArea = All; //Bc Upgrade YADAVM09<<
                }
            }
        }
    }

    actions
    {
    }
}

