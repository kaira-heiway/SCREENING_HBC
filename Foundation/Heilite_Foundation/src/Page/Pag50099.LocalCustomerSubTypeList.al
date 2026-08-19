page 50099 "Local Customer Sub-Type. List"
{
    // version HEI.01

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 18.08.2017 # MDM Customer Card
    //   # Object created

    Caption = 'Local Customer Sub-Type. List';
    PageType = List;
    SourceTable = "Local Customer Sub-Type FND";
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
                field("Global Cust. Sub-Type"; Rec."Global Cust. Sub-Type")
                {
                    ToolTip = 'Specifies the value of the Global Cust. Sub-Type field.';
                }
            }
        }
    }

    actions
    {
    }
}

