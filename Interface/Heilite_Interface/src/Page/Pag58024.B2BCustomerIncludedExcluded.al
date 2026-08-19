page 58024 "B2B Customer Included/Excluded"
{
    // Heilite Navision Old Id - 50268

    // HEI.01 FDD-HB1281 - CHG2056937 IBM NASTAA02 12.04.2021 # B2B Pricing Interface
    //   # New Page created for B2B Pricing Interface
    // HEI.02 INC3510045 - CHG2112803 IBM NASTAA02 02.06.2021 # HeiLite to B2B pricing the file generated is very big and can't be sent via Boomi or Solace
    //   # Deleted Field 20 - Excluded

    // BC Upgrade PATELP08>>
    // Changed name of table from "B2B Customer Included/Excluded" to "B2B Cust Inc/Exc FND"
    // BC Upgrade PATELP08<<

    Caption = 'B2B Customer Included/Excluded';
    PageType = List;
    SourceTable = "B2B Cust Inc/Exc FND";
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
                field(Included; Rec.Included)
                {
                    ToolTip = 'Specifies the value of the Included field.';
                }
            }
        }
    }

    actions
    {
    }
}

