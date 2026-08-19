page 50272 "CAD Entries"
{
    // HEI.01 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Page created
    //**********************************************************************************************
    //BC UPGRADE PATHAA02 12.11.25 -Done
    //Errors removed
    //**********************************************************************************************


    Caption = 'CAD Entries';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "CAD Entry FND" = rm;
    SourceTable = "CAD Entry FND";
    SourceTableView = sorting("Entry No.")
                      ORDER(Descending);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Sell-to / Buy-from No."; Rec."Sell-to / Buy-from No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to / Buy-from No. field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Amount Excl. VAT"; Rec."Amount Excl. VAT")
                {
                    ToolTip = 'Specifies the value of the Amount Excl. VAT field.';
                }
                field(Base; Rec.Base)
                {
                    ToolTip = 'Specifies the value of the Base field.';
                }
                field("CAD Amount"; Rec."CAD Amount")
                {
                    ToolTip = 'Specifies the value of the CAD Amount field.';
                }
                field("Amount Including CAD"; Rec."Amount Including CAD")
                {
                    ToolTip = 'Specifies the value of the Amount Including CAD field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ToolTip = 'Specifies the value of the Transaction No. field.';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                }
                field("CAD %"; Rec."CAD %")
                {
                    ToolTip = 'Specifies the value of the CAD % field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ToolTip = 'Specifies the value of the Source Code field.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the value of the Reason Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

