page 58069 "SEM Customer Included/Excluded"
{
    // Heilite Navision Old Id - 50468

    // HEI.01 CHG2115040 HB2342 IBM GAVANM01 16.08.2021 #SEM Customer Integration
    //   # New Page created for SEM Interface

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "SEM Customer Included/Excluded" to "SEM Customer Included
    // BC UPGRADE PATELS08 <<

    PageType = List;
    SourceTable = "SEM Cust Inc/Exc FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Control55001)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Included; Rec.Included)
                {
                    ToolTip = 'Specifies the value of the Included field.';
                }
                field(Excluded; Rec.Excluded)
                {
                    ToolTip = 'Specifies the value of the Excluded field.';
                }
            }
        }
    }

    actions
    {
    }
}

