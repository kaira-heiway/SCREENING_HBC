page 50024 "Blocked Reasons"
{
    // version HEI.01

    // HEI.01 FDD-OTCGAP057 IBM.NAIKH01 29-06-2017
    //   # created a new Page for Customers flagged for litigation

    PageType = List;
    SourceTable = "Blocked Reason FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
            }
        }
    }

    actions
    {
    }
}

