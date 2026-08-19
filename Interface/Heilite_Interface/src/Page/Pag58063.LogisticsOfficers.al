page 58063 "Logistics Officers"
{
    // Heilite Navision Old Id - 50459

    // version HEI.01

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 25.06.2021 Ibecor - PO API
    //   # New Page created for Ibecor PFI Interface

    // BC Upgrade MISHRA14 >>
    // Changed table name to "Logistics Officers FND" as its moved from Interface to Fondation Layer.
    // BC Upgrade MISHRS14 <<

    PageType = List;
    SourceTable = "Logistics Officers FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("LO Code"; Rec."LO Code")
                {
                    ToolTip = 'Specifies the value of the LO Code field.';
                }
                field("LO Name"; Rec."LO Name")
                {
                    ToolTip = 'Specifies the value of the LO Name field.';
                }
                field("LO Email"; Rec."LO Email")
                {
                    ToolTip = 'Specifies the value of the LO Email field.';
                }
            }
        }
    }

    actions
    {
    }
}

