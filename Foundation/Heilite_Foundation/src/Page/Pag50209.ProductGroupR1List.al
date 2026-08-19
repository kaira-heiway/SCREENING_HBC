page 50209 "Product Group R1 List"
{
    // version HEI.01

    // HEI.01 Defect #1328 #1329 IBM NASTAA02 19.12.2017 # Missing fields in file creation
    //   # New Page created

    Caption = 'Product Group R1 List';
    PageType = List;
    SourceTable = "Product Group R1 FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

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
            }
        }
    }

    actions
    {
    }
}

