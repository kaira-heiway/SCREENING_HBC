page 50106 "Market Type List"
{
    // version HEI.01

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 18.08.2017 # MDM Customer Card
    //   # Object created

    PageType = List;
    SourceTable = "Market Type FND";
    ApplicationArea = ALl;  // BC Upgrade NANDIS03
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
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
            }
        }
    }

    actions
    {
    }
}

