page 54027 "License Permissions"
{
    //  BC Upgrade KUMARS145 Nav ID Page 50303 "License Permissions" 

    PageType = List;
    SourceTable = "License Permission";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Containes "Object Type" in License Permission Table';
                    ApplicationArea = all;
                }
                field("Object Number"; Rec."Object Number")
                {
                    ToolTip = 'Containes "Object Number" in License Permission Table';
                    ApplicationArea = all;
                }
                field("Read Permission"; Rec."Read Permission")
                {
                    ToolTip = 'Containes "Read Permission" in License Permission Table';
                    ApplicationArea = all;
                }
                field("Insert Permission"; Rec."Insert Permission")
                {
                    ToolTip = 'Containes "Insert Permission" in License Permission Table';
                    ApplicationArea = all;
                }
                field("Modify Permission"; Rec."Modify Permission")
                {
                    ToolTip = 'Containes "Modify Permission" in License Permission Table';
                    ApplicationArea = all;
                }
                field("Delete Permission"; Rec."Delete Permission")
                {
                    ToolTip = 'Containes "Delete Permission" in License Permission Table';
                    ApplicationArea = all;
                }
                field("Execute Permission"; Rec."Execute Permission")
                {
                    ToolTip = 'Containes "Execute Permission" in License Permission Table';
                    ApplicationArea = all;
                }
                field("Limited Usage Permission"; Rec."Limited Usage Permission")
                {
                    ToolTip = 'Containes "Limited Usage Permission" in License Permission Table';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

