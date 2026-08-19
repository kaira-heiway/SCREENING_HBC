page 50700 "Item Product Group Code BC"
{
    //Bc Upgrade YADAVM09 new page created for item Product group code functionality.
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Product Group BC FND";
    Caption = 'Item Product Group Code';
    DataCaptionFields = "Item Category Code";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}