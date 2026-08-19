page 55004 "PPV Setup Checklist"
{
    // version HEI.01

    // HEI.01 CHG2193490 IBM SISUM01 27/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # new object created

    // BC Upgrade POENAB02: Original (HeiLite) page id 50437

    Caption = 'PPV Setup Checklist';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Setup Checklist FND";
    SourceTableView = sorting(Code, ID)
                      where(Code = const('PPV'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec."Code")
                {
                    ToolTip = 'Specifies the code of the setup checklist item.';
                }
                field(ID; Rec."ID")
                {
                    ToolTip = 'Specifies the identification number of the setup checklist item.';
                }
                field("Task Type"; Rec."Task Type")
                {
                    ToolTip = 'Specifies the type of task for the setup checklist item.';
                }
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the identification number of the table for the setup checklist item.';
                }
                field("Table Name"; Rec."Table Name")
                {
                    ToolTip = 'Specifies the name of the table for the setup checklist item.';
                }
                field("Field ID"; Rec."Field ID")
                {
                    ToolTip = 'Specifies the identification number of the field for the setup checklist item.';
                }
                field("Field Name"; Rec."Field Name")
                {
                    ToolTip = 'Specifies the name of the field for the setup checklist item.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the setup checklist item.';
                }
                field("Recommended Value"; Rec."Recommended Value")
                {
                    ToolTip = 'Specifies the recommended value for the setup checklist item.';
                }
                field("Page Tab"; Rec."Page Tab")
                {
                    ToolTip = 'Specifies the page tab where the setup checklist item can be found.';
                }
                field("Page ID"; Rec."Page ID")
                {
                    ToolTip = 'Specifies the identification number of the page for the setup checklist item.';
                }
                field("No. of Database Records"; Rec."No. of Database Records")
                {

                    trigger OnDrillDown();
                    begin
                        if Rec."Page ID" <> 0 then
                            Page.Run(Rec."Page ID");
                    end;
                }
            }
        }
    }

    actions
    {
    }
}

