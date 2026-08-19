page 50157 "Return Packaging Material Type"
{
    // HEI.10 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # New page

    Caption = 'Returnable Packaging Material Types';
    PageType = List;
    SourceTable = "Return Pack Material Type FND";
    ApplicationArea = All;
    UsageCategory = Lists;

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
            }
        }
    }

    actions
    {
    }
}

