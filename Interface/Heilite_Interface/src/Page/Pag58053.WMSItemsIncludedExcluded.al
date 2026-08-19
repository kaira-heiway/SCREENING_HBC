page 58053 "WMS Items Included/Excluded"
{
    // Heilite Navision Old Id - 50417

    // HEI.01 CHG2077574 IBM GAVANM01 04.09.2020 # WMS Integration - new page for include/exclude items to be exported

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "WMS Items Included/Excluded" to "WMS Items Included/ExcludedFND"
    // BC UPGRADE PATELS08 <<

    PageType = List;
    PromotedActionCategories = 'Filters';
    SourceTable = "WMS Items Included/ExcludedFND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Code"; Rec."Item Code")
                {
                    ToolTip = 'Specifies the value of the Item Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Item Category"; Rec."Item Category")
                {
                    ToolTip = 'Specifies the value of the Item Category field.';
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

