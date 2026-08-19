page 55009 "C2S Setup Checklist"
{
    // HEI.01 CHG2143950 IBM BULIMC01 27/01/2022#new page created for C2S setup

    // BC Upgrade POENAB02: Original (HeiLite) page id 50510

    PageType = List;
    SourceTable = "Setup Checklist FND";
    SourceTableView = sorting(Code, ID)
                      order(Ascending)
                      where(Code = CONST('C2S'));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    Editable = false;
                }
                field(ID; Rec.ID)
                {
                }
                field("Task Type"; Rec."Task Type")
                {
                }
                field("Table ID"; Rec."Table ID")
                {
                }
                field("Table Name"; Rec."Table Name")
                {
                }
                field("Field ID"; Rec."Field ID")
                {
                }
                field("Field Name"; Rec."Field Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Recommended Value"; Rec."Recommended Value")
                {
                }
                field("Page Tab"; Rec."Page Tab")
                {
                }
                field("Page ID"; Rec."Page ID")
                {
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

