page 50128 "WHT Certificate Buffer List"
{
    // version HEI.01

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # Object created

    Caption = 'WHT Certificate Buffer List';
    PageType = List;
    SourceTable = "WHT Certificate Buffer FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
            }
        }
    }

    actions
    {
    }
}

