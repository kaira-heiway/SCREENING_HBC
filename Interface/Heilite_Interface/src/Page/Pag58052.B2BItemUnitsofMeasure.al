page 58052 "B2B Item Units of Measure"
{
    // Heilite Navision Old Id - 50416

    // version HEI.01

    // HEI.01 CHG2174122 HB3137 BHANDS01 13.02.2023 # Control for which UOM prices sent to B2B
    //   # New page created
    
    // BC Upgrade PATELP08>>
    // Changed name of table from "B2B Item Units of Measure" to "B2B Item Units of Measure FND"
    // BC Upgrade PATELP08<<
    
    PageType = List;
    SourceTable = "B2B Item Units of Measure FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("B2B UOM"; Rec."B2B UOM")
                {
                    ToolTip = 'Specifies the value of the B2B UOM field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            //Caption = 'Options';  // BC Upgrade NANDIS03
            action("Update B2B Unit of Measure")
            {
                Caption = 'Update B2B Unit of Measure';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Update B2B Unit of Measure action.';
                // RunObject = Report "Update B2B UOM";  // BC Upgrade NANDIS03 - BLocked as report object is yet to be compiled
            }
        }
    }
}

