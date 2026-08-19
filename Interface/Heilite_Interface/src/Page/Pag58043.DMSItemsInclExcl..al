page 58043 "DMS Items Incl. Excl."
{
    // Heilite Navision Old Id - 50386

    // HEI.01 FDD-HB1268 - CHG2068666 IBM NASTAA02 26.10.2020 # DMS Integration Ivory Coast
    //   # New Page created for DMS Interfaces

    Caption = 'DMS Items Included / Excluded';
    PageType = List;
    SourceTable = "DMS Items Incl. Excl. FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

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
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';
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

