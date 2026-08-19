page 58006 "Maximo Item Category Filter"
{
    // Heilite Navision Old Id - 50105
    // version HEI.02

    // HEI.01 FDD-PURGAP026 IBM NASTAA02 27.07.2018 # Item Selection Heilite-Maximo Interface
    //   # New Page created to setup the Maximo Item Category Filter
    // HEI.02 Defect #2638 IBM NASTAA02 12.09.2018 # CMG Code not updated
    //   # Deleted Field "CMG ID"

    Caption = 'Maximo Item Category Filter';
    PageType = List;
    SourceTable = "Maximo Item Category Flter INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category"; Rec."Item Category")
                {
                    ToolTip = 'Specifies the value of the Item Category field.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                }
                field("CMG Code"; Rec."CMG Code")
                {
                    ToolTip = 'Specifies the value of the CMG Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

