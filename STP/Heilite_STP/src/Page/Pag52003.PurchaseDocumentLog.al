page 52003 "Purchase Document Log"
{
    // BC Upgrade Kamnay01 Original(Heilite) page id 50306
    // version HEI.01

    // HEI.01 FDD-PURGAP030 - Send updated PO to supplier with specified  changes_V1.1, IBM.NAIKH01 , 21.01.2019
    //   # Created New Page
    //BC UPGRADE PATHAA02-30.10.25

    Editable = false;
    PageType = List;
    SourceTable = "Purchase Document Log FND";
    ApplicationArea = All;  // BC Upgrade PATHAA02
    UsageCategory = Lists;  // BC Upgrade PATHAA02

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Creation Datetime"; Rec."Creation Datetime")
                {
                    ToolTip = 'Specifies the value of the Creation Datetime field.';
                }
                field("Field No."; Rec."Field No.")
                {
                    ToolTip = 'Specifies the value of the Field No. field.';
                }
                field("Old Value"; Rec."Old Value")
                {
                    ToolTip = 'Specifies the value of the Old Value field.';
                }
                field("New Value"; Rec."New Value")
                {
                    ToolTip = 'Specifies the value of the New Value field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
            }
        }
    }

    actions
    {
    }
}

