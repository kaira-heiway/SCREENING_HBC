page 50315 "Vendor Categories"
{
    // HEI.01 FDD-PURGAP033 BULIMC01 28.02.2019 # new page of type list created on Vendor Category table

    Caption = 'Vendor Categories';
    PageType = List;
    SourceTable = "Vendor Category FND";
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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
    }
}

